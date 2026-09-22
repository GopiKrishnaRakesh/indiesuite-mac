import SwiftUI
import AppKit
import Carbon
import DesignSystem
import AppKitKit
import Licensing
import AudioVideoCore

struct OCRHistoryItem: Identifiable {
    let id = UUID()
    let content: String
    let type: String
}

/// Very small, honest heuristic classifier — not a claim of ML detection,
/// just enough to label the extracted text usefully.
func classifyText(_ text: String) -> String {
    let lower = text.lowercased()
    if lower.contains("select ") && lower.contains("from ") { return "SQL Query" }
    if text.contains("https://") || text.contains("http://") { return "URL" }
    if lower.contains("func ") || lower.contains("import swiftui") || lower.contains("struct ") { return "Swift" }
    if lower.contains("function ") || lower.contains("const ") || lower.contains("=>") { return "JavaScript" }
    if text.contains("{") && text.contains("}") && text.contains(":") { return "JSON / Code" }
    if lower.contains("def ") || lower.contains("import ") { return "Python" }
    return "Plain Text"
}

class LocalLensState: ObservableObject {
    @Published var autoCopy: Bool = true
    @Published var isCapturing: Bool = false
    @Published var lastExtractedText: String = "Click \"Capture & Extract\" to select any part of your screen."
    @Published var detectedLanguage: String = "Ready"
    @Published var errorMessage: String?

    @Published var history: [OCRHistoryItem] = []

    func captureScreenArea() {
        guard !isCapturing else { return }
        isCapturing = true
        errorMessage = nil

        let tmpFile = FileManager.default.temporaryDirectory.appendingPathComponent("locallens-\(UUID().uuidString).png")

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
        // -i interactive selection, -x no capture sound
        process.arguments = ["-i", "-x", tmpFile.path]

        process.terminationHandler = { [weak self] _ in
            DispatchQueue.main.async {
                self?.handleCaptureFinished(fileURL: tmpFile)
            }
        }

        do {
            try process.run()
        } catch {
            isCapturing = false
            errorMessage = "Could not launch screencapture: \(error.localizedDescription)"
        }
    }

    private func handleCaptureFinished(fileURL: URL) {
        guard FileManager.default.fileExists(atPath: fileURL.path),
              let image = NSImage(contentsOf: fileURL) else {
            // User pressed Esc / cancelled the selection — not an error.
            isCapturing = false
            return
        }

        ScreenOCRService.shared.recognizeText(from: image) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.isCapturing = false
                try? FileManager.default.removeItem(at: fileURL)

                switch result {
                case .success(let text):
                    let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    if trimmed.isEmpty {
                        self.lastExtractedText = "No text detected in that selection."
                        self.detectedLanguage = "Empty"
                    } else {
                        self.lastExtractedText = trimmed
                        self.detectedLanguage = classifyText(trimmed)
                        self.history.insert(OCRHistoryItem(content: trimmed, type: self.detectedLanguage), at: 0)
                        if self.history.count > 8 { self.history.removeLast() }

                        if self.autoCopy {
                            NSPasteboard.general.clearContents()
                            NSPasteboard.general.setString(trimmed, forType: .string)
                        }
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct LocalLensView: View {
    @ObservedObject var state: LocalLensState
    @StateObject private var license = LicenseManager.shared

    var body: some View {
        VStack(spacing: 14) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "viewfinder.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("LocalLens OCR")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌘ ⇧ 2")
            }

            VStack(spacing: 10) {
                Button(action: { state.captureScreenArea() }) {
                    HStack {
                        Image(systemName: "crop")
                            .font(.system(size: 14, weight: .bold))
                        Text(state.isCapturing ? "Selecting screen area..." : "Capture & Extract Screen Area")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(DSTheme.cyanGradient)
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
                .disabled(state.isCapturing)

                HStack {
                    Toggle("Auto-copy to clipboard", isOn: $state.autoCopy)
                        .font(.system(size: 11))
                    Spacer()
                }

                if let err = state.errorMessage {
                    Text(err)
                        .font(.system(size: 9))
                        .foregroundColor(.red)
                }
            }
            .padding(10)
            .glassCard(cornerRadius: 10)

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Extracted Content")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.secondary)

                    Text(state.detectedLanguage)
                        .font(.system(size: 9, weight: .semibold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.cyan.opacity(0.15))
                        .foregroundColor(.cyan)
                        .cornerRadius(4)

                    Spacer()

                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(state.lastExtractedText, forType: .string)
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                            .font(.system(size: 10))
                    }
                    .buttonStyle(.plain)
                }

                ScrollView {
                    Text(state.lastExtractedText)
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textSelection(.enabled)
                }
                .frame(maxHeight: 90)
                .padding(8)
                .background(Color.primary.opacity(0.04))
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Extraction History")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)

                if state.history.isEmpty {
                    Text("Real captures will appear here")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                } else {
                    ScrollView {
                        VStack(spacing: 4) {
                            ForEach(state.history) { item in
                                HStack {
                                    Text(item.type)
                                        .font(.system(size: 9, weight: .bold))
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 1)
                                        .background(Color.primary.opacity(0.08))
                                        .cornerRadius(3)

                                    Text(item.content)
                                        .font(.system(size: 10, design: .monospaced))
                                        .lineLimit(1)
                                        .foregroundColor(.secondary)

                                    Spacer()
                                }
                                .padding(4)
                            }
                        }
                    }
                    .frame(maxHeight: 90)
                }
            }

            HStack {
                Text("Vision Framework • On-device, offline")
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
    var menuBarController: MenuBarController<LocalLensView>?
    let state = LocalLensState()

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = LocalLensView(state: state)
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "viewfinder.circle",
            titleText: nil,
            contentWidth: 360,
            contentHeight: 500
        )

        _ = GlobalHotkeyManager.shared.registerHotkey(keyCode: UInt32(kVK_ANSI_2), modifiers: UInt32(cmdKey | shiftKey)) { [weak self] in
            self?.state.captureScreenArea()
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
