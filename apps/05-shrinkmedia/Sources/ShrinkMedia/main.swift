import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing
import AudioVideoCore

class ShrinkMediaState: ObservableObject {
    @Published var selectedPreset: String = "HEVC High Efficiency (1080p)"
    @Published var targetFormat: String = "MP4"
    @Published var qualitySlider: Double = 0.75
    @Published var isProcessing: Bool = false
    @Published var totalSavedMB: Double = 342.6
    
    @Published var queuedFiles: [MediaQueueItem] = [
        MediaQueueItem(filename: "product_demo_4k.mov", originalSize: "248.5 MB", compressedSize: "28.2 MB", status: .done, savings: "88%"),
        MediaQueueItem(filename: "screen_recording_raw.mp4", originalSize: "112.0 MB", compressedSize: "14.1 MB", status: .done, savings: "87%"),
        MediaQueueItem(filename: "keynote_presentation.mp4", originalSize: "84.2 MB", compressedSize: "Pending", status: .waiting, savings: "--")
    ]
    
    struct MediaQueueItem: Identifiable {
        let id = UUID()
        let filename: String
        let originalSize: String
        var compressedSize: String
        var status: ProcessStatus
        var savings: String
        
        enum ProcessStatus {
            case waiting, processing, done
        }
    }
    
    func compressAll() {
        isProcessing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.isProcessing = false
            if let idx = self.queuedFiles.firstIndex(where: { $0.status == .waiting }) {
                self.queuedFiles[idx].compressedSize = "11.8 MB"
                self.queuedFiles[idx].status = .done
                self.queuedFiles[idx].savings = "86%"
                self.totalSavedMB += 72.4
            }
        }
    }
}

struct ShrinkMediaView: View {
    @StateObject private var state = ShrinkMediaState()
    @StateObject private var license = LicenseManager.shared
    
    let presets = ["HEVC High Efficiency (1080p)", "H.264 Universal Compatible", "Animated GIF (Lossless)", "ProRes Proxy", "AV1 Next-Gen"]
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.down.right.and.arrow.up.left.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("ShrinkMedia")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                Text(String(format: "Saved %.1f MB", state.totalSavedMB))
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.green.opacity(0.15))
                    .foregroundColor(.green)
                    .cornerRadius(4)
            }
            
            // Drop Zone Area
            VStack(spacing: 6) {
                Image(systemName: "square.and.arrow.down.on.square.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(DSTheme.roseGradient)
                
                Text("Drag & Drop Videos or Images")
                    .font(.system(size: 12, weight: .bold))
                
                Text("Hardware VideoToolbox accelerated • Zero quality loss")
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
            
            // Compression Settings Card
            VStack(spacing: 8) {
                Picker("Preset", selection: $state.selectedPreset) {
                    ForEach(presets, id: \.self) { preset in
                        Text(preset).tag(preset)
                    }
                }
                .pickerStyle(.menu)
                .font(.system(size: 11))
                
                HStack {
                    Text("Quality Ratio")
                        .font(.system(size: 11))
                    Slider(value: $state.qualitySlider, in: 0.3...1.0)
                    Text("\(Int(state.qualitySlider * 100))%")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .frame(width: 38)
                }
            }
            .padding(10)
            .glassCard(cornerRadius: 10)
            
            // Queue List
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Batch Queue")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.secondary)
                    Spacer()
                    Button("Compress All") {
                        state.compressAll()
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(DSTheme.roseGradient)
                    .cornerRadius(4)
                }
                
                ScrollView {
                    VStack(spacing: 4) {
                        ForEach(state.queuedFiles) { item in
                            HStack {
                                Image(systemName: item.filename.hasSuffix(".gif") ? "photo.stack" : "film")
                                    .font(.system(size: 11))
                                    .foregroundColor(.secondary)
                                
                                VStack(alignment: .leading, spacing: 1) {
                                    Text(item.filename)
                                        .font(.system(size: 11, weight: .semibold))
                                        .lineLimit(1)
                                    Text("\(item.originalSize) → \(item.compressedSize)")
                                        .font(.system(size: 9, design: .monospaced))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Text(item.savings)
                                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                                    .foregroundColor(item.status == .done ? .green : .secondary)
                            }
                            .padding(6)
                            .background(Color.primary.opacity(0.03))
                            .cornerRadius(6)
                        }
                    }
                }
                .frame(maxHeight: 120)
            }
            
            // Footer
            HStack {
                Text("Apple Silicon HW Acceleration Active")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button("Quit") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(.plain)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 350, height: 480)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<ShrinkMediaView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ShrinkMediaView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "arrow.down.right.and.arrow.up.left.circle",
            titleText: "ShrinkMedia",
            contentWidth: 350,
            contentHeight: 480
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
