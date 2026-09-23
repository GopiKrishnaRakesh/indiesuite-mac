import SwiftUI
import AppKit
import ImageIO
import AVFoundation
import UniformTypeIdentifiers
import DesignSystem
import AppKitKit
import Licensing
import AudioVideoCore

struct MediaQueueItem: Identifiable {
    let id = UUID()
    let sourceURL: URL
    let filename: String
    let originalBytes: Int64
    var outputURL: URL?
    var compressedBytes: Int64?
    var status: Status
    var errorMessage: String?

    enum Status { case waiting, processing, done, failed }

    var savingsPercent: Int? {
        guard let compressedBytes, originalBytes > 0 else { return nil }
        return Int((1.0 - Double(compressedBytes) / Double(originalBytes)) * 100)
    }
}

enum MediaShrinker {
    static let imageTypes: Set<String> = ["jpg", "jpeg", "png", "heic", "tiff", "bmp"]

    static func fileSize(_ url: URL) -> Int64 {
        (try? FileManager.default.attributesOfItem(atPath: url.path)[.size] as? Int64) ?? 0
    }

    static func outputURL(for input: URL, suffix: String) -> URL {
        let base = input.deletingPathExtension().lastPathComponent
        let ext = input.pathExtension
        return input.deletingLastPathComponent().appendingPathComponent("\(base)-\(suffix).\(ext)")
    }

    /// Real lossy re-encode via ImageIO — actually shrinks JPEG/HEIC bytes on disk.
    static func compressImage(at url: URL, quality: Double, completion: @escaping (Result<URL, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
                  CGImageSourceGetCount(source) > 0,
                  let type = CGImageSourceGetType(source) else {
                completion(.failure(NSError(domain: "ShrinkMedia", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not read image"])))
                return
            }

            let dest = outputURL(for: url, suffix: "shrunk")
            guard let destination = CGImageDestinationCreateWithURL(dest as CFURL, type, 1, nil) else {
                completion(.failure(NSError(domain: "ShrinkMedia", code: -2, userInfo: [NSLocalizedDescriptionKey: "Could not create output"])))
                return
            }

            let props: [CFString: Any] = [kCGImageDestinationLossyCompressionQuality: quality]
            // Copy from the source (not a bare CGImage) so EXIF/GPS/color profile survive --
            // dropping the Orientation tag would turn portrait photos sideways.
            CGImageDestinationAddImageFromSource(destination, source, 0, props as CFDictionary)

            if CGImageDestinationFinalize(destination) {
                completion(.success(dest))
            } else {
                completion(.failure(NSError(domain: "ShrinkMedia", code: -3, userInfo: [NSLocalizedDescriptionKey: "Encode failed"])))
            }
        }
    }

    static func compressVideo(at url: URL, quality: Double, completion: @escaping (Result<URL, Error>) -> Void) {
        let dest = outputURL(for: url, suffix: "shrunk").deletingPathExtension().appendingPathExtension("mp4")
        try? FileManager.default.removeItem(at: dest)
        let preset = quality > 0.66 ? AVAssetExportPresetMediumQuality : AVAssetExportPresetLowQuality
        // AVAssetExportSession refuses to overwrite, so re-shrinking the same file would fail.
        try? FileManager.default.removeItem(at: dest)
        VideoCompressor.shared.compressVideo(inputURL: url, outputURL: dest, preset: preset) { result in
            completion(result)
        }
    }
}

class ShrinkMediaState: ObservableObject {
    @Published var qualitySlider: Double = 0.6
    @Published var isProcessing: Bool = false
    @Published var queuedFiles: [MediaQueueItem] = []

    var totalSavedBytes: Int64 {
        queuedFiles.reduce(0) { total, item in
            guard let compressed = item.compressedBytes else { return total }
            return total + max(0, item.originalBytes - compressed)
        }
    }

    func pickFiles() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.image, .movie, .mpeg4Movie, .quickTimeMovie]
        if panel.runModal() == .OK {
            for url in panel.urls {
                let item = MediaQueueItem(sourceURL: url, filename: url.lastPathComponent, originalBytes: MediaShrinker.fileSize(url), status: .waiting)
                queuedFiles.append(item)
            }
        }
    }

    func compressAll() {
        isProcessing = true
        let waitingIndices = queuedFiles.indices.filter { queuedFiles[$0].status == .waiting }
        let group = DispatchGroup()

        for idx in waitingIndices {
            group.enter()
            queuedFiles[idx].status = .processing
            let item = queuedFiles[idx]
            let ext = item.sourceURL.pathExtension.lowercased()

            let handleResult: (Result<URL, Error>) -> Void = { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let outURL):
                        let newBytes = MediaShrinker.fileSize(outURL)
                        if newBytes >= item.originalBytes {
                            // Lossless formats (PNG) or already-compressed files can grow on
                            // re-encode; never leave a bigger "shrunk" copy behind.
                            try? FileManager.default.removeItem(at: outURL)
                            self.queuedFiles[idx].status = .failed
                            self.queuedFiles[idx].errorMessage = "Already optimal — no smaller"
                        } else {
                            self.queuedFiles[idx].outputURL = outURL
                            self.queuedFiles[idx].compressedBytes = newBytes
                            self.queuedFiles[idx].status = .done
                        }
                    case .failure(let error):
                        self.queuedFiles[idx].status = .failed
                        self.queuedFiles[idx].errorMessage = error.localizedDescription
                    }
                    group.leave()
                }
            }

            if MediaShrinker.imageTypes.contains(ext) {
                MediaShrinker.compressImage(at: item.sourceURL, quality: qualitySlider, completion: handleResult)
            } else {
                MediaShrinker.compressVideo(at: item.sourceURL, quality: qualitySlider, completion: handleResult)
            }
        }

        group.notify(queue: .main) {
            self.isProcessing = false
        }
    }

    func revealInFinder(_ item: MediaQueueItem) {
        guard let outputURL = item.outputURL else { return }
        NSWorkspace.shared.activateFileViewerSelecting([outputURL])
    }
}

func formatBytes(_ bytes: Int64) -> String {
    if bytes > 1_000_000_000 { return String(format: "%.2f GB", Double(bytes) / 1_000_000_000) }
    if bytes > 1_000_000 { return String(format: "%.1f MB", Double(bytes) / 1_000_000) }
    if bytes > 1_000 { return String(format: "%.0f KB", Double(bytes) / 1_000) }
    return "\(bytes) B"
}

struct ShrinkMediaView: View {
    @StateObject private var state = ShrinkMediaState()
    @StateObject private var license = LicenseManager.shared

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.down.right.and.arrow.up.left.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("ShrinkMedia")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Saved \(formatBytes(state.totalSavedBytes))")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.green.opacity(0.15))
                    .foregroundColor(.green)
                    .cornerRadius(4)
            }

            Button(action: { state.pickFiles() }) {
                VStack(spacing: 6) {
                    Image(systemName: "square.and.arrow.down.on.square.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("Choose Images or Videos to Shrink")
                        .font(.system(size: 12, weight: .bold))
                    Text("Real ImageIO / AVFoundation re-encode • saved next to original")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.primary.opacity(0.02))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                        .foregroundColor(Color.primary.opacity(0.15))
                )
                .cornerRadius(10)
            }
            .buttonStyle(.plain)

            VStack(spacing: 8) {
                HStack {
                    Text("Quality / Size Tradeoff")
                        .font(.system(size: 11))
                    Slider(value: $state.qualitySlider, in: 0.2...0.95)
                    Text("\(Int(state.qualitySlider * 100))%")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .frame(width: 38)
                }
            }
            .padding(10)
            .glassCard(cornerRadius: 10)

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Batch Queue (\(state.queuedFiles.count))")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.secondary)
                    Spacer()
                    Button(state.isProcessing ? "Compressing..." : "Compress All") {
                        state.compressAll()
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(DSTheme.roseGradient)
                    .cornerRadius(4)
                    .disabled(state.isProcessing || state.queuedFiles.allSatisfy { $0.status != .waiting })
                }

                ScrollView {
                    VStack(spacing: 4) {
                        ForEach(state.queuedFiles) { item in
                            Button(action: { state.revealInFinder(item) }) {
                                HStack {
                                    Image(systemName: MediaShrinker.imageTypes.contains(item.sourceURL.pathExtension.lowercased()) ? "photo" : "film")
                                        .font(.system(size: 11))
                                        .foregroundColor(.secondary)

                                    VStack(alignment: .leading, spacing: 1) {
                                        Text(item.filename)
                                            .font(.system(size: 11, weight: .semibold))
                                            .lineLimit(1)
                                        Text("\(formatBytes(item.originalBytes)) → \(item.compressedBytes.map(formatBytes) ?? (item.status == .failed ? (item.errorMessage ?? "Failed") : "Pending"))")
                                            .font(.system(size: 9, design: .monospaced))
                                            .foregroundColor(.secondary)
                                    }

                                    Spacer()

                                    if let pct = item.savingsPercent {
                                        Text("\(pct)%")
                                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                                            .foregroundColor(.green)
                                    } else if item.status == .processing {
                                        ProgressView().scaleEffect(0.5)
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                            .padding(6)
                            .background(Color.primary.opacity(0.03))
                            .cornerRadius(6)
                        }
                    }
                }
                .frame(maxHeight: 120)
            }

            HStack {
                Text("Click a finished row to reveal it in Finder")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
                Spacer()
                Button("Quit") { NSApp.terminate(nil) }
                    .buttonStyle(.plain)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 360, height: 500)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<ShrinkMediaView>?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ShrinkMediaView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "arrow.down.right.and.arrow.up.left.circle",
            titleText: nil,
            contentWidth: 360,
            contentHeight: 500
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
