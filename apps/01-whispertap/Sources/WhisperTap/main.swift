import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing
import AudioVideoCore

class WhisperTapState: ObservableObject {
    @Published var isRecording: Bool = false
    @Published var selectedModel: String = "WhisperKit-Small (Apple Silicon MLX)"
    @Published var activeLanguage: String = "Auto Detect"
    @Published var autoPasteEnabled: Bool = true
    @Published var autoPunctuation: Bool = true
    @Published var smartCodeMode: Bool = false
    @Published var audioLevel: Float = 0.0
    @Published var lastTranscript: String = "Ready to transcribe. Hold Option+Space to speak anywhere."
    @Published var history: [TranscriptItem] = [
        TranscriptItem(text: "Implement the login controller with OAuth2 and PKCE authorization.", timestamp: Date().addingTimeInterval(-300), duration: 2.4),
        TranscriptItem(text: "Hey team, let's sync up on the sprint deliverables at 3 PM.", timestamp: Date().addingTimeInterval(-1200), duration: 1.8)
    ]
    
    struct TranscriptItem: Identifiable {
        let id = UUID()
        let text: String
        let timestamp: Date
        let duration: Double
    }
    
    func toggleRecording() {
        isRecording.toggle()
        if isRecording {
            audioLevel = 0.65
        } else {
            audioLevel = 0.0
            lastTranscript = "Transcribed in 120ms: 'Refactor the shared design system components into a modular package.'"
            history.insert(TranscriptItem(text: "Refactor the shared design system components into a modular package.", timestamp: Date(), duration: 1.2), at: 0)
        }
    }
}

struct WhisperTapView: View {
    @StateObject private var state = WhisperTapState()
    @StateObject private var license = LicenseManager.shared
    
    let models = ["WhisperKit-Tiny (39MB)", "WhisperKit-Small (Apple Silicon MLX)", "WhisperKit-Medium (769MB)", "Cloud OpenAI Whisper API"]
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "waveform.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("WhisperTap")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                HotkeyPill(keyCombination: "⌥ Space")
            }
            
            // Status & Push-To-Talk Visualizer Card
            VStack(spacing: 12) {
                HStack {
                    StatusDot(isActive: state.isRecording, activeColor: .red)
                    Text(state.isRecording ? "Listening & Transcribing..." : "Ready for Dictation")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(state.isRecording ? .red : .secondary)
                    Spacer()
                    if state.isRecording {
                        Text("Metal Neural Engine")
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.red.opacity(0.15))
                            .foregroundColor(.red)
                            .cornerRadius(4)
                    }
                }
                
                // Live Waveform visualizer
                HStack(spacing: 4) {
                    ForEach(0..<20, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(state.isRecording ? DSTheme.primaryGradient : LinearGradient(colors: [Color.gray.opacity(0.3)], startPoint: .top, endPoint: .bottom))
                            .frame(width: 4, height: state.isRecording ? CGFloat.random(in: 12...38) : 6)
                            .animation(.easeInOut(duration: 0.15).repeatCount(1), value: state.isRecording)
                    }
                }
                .frame(height: 42)
                
                Button(action: {
                    state.toggleRecording()
                }) {
                    HStack {
                        Image(systemName: state.isRecording ? "stop.circle.fill" : "mic.fill")
                        Text(state.isRecording ? "Release to Paste (Esc to Cancel)" : "Click to Test Dictation")
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(state.isRecording ? Color.red.opacity(0.85) : Color.accentColor.opacity(0.85))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
            .padding(12)
            .glassCard(cornerRadius: 12)
            
            // Latest Transcript Output
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Latest Output")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.secondary)
                    Spacer()
                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(state.lastTranscript, forType: .string)
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                            .font(.system(size: 10))
                    }
                    .buttonStyle(.plain)
                }
                
                Text(state.lastTranscript)
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(Color.primary.opacity(0.04))
                    .cornerRadius(8)
            }
            
            // Controls & Engine Config
            VStack(spacing: 8) {
                Picker("Engine", selection: $state.selectedModel) {
                    ForEach(models, id: \.self) { model in
                        Text(model).tag(model)
                    }
                }
                .pickerStyle(.menu)
                .font(.system(size: 11))
                
                HStack {
                    Toggle("Auto-paste in active app", isOn: $state.autoPasteEnabled)
                        .font(.system(size: 11))
                    Spacer()
                    Toggle("Code Mode", isOn: $state.smartCodeMode)
                        .font(.system(size: 11))
                }
            }
            .padding(10)
            .glassCard(cornerRadius: 10)
            
            // History Snippets
            VStack(alignment: .leading, spacing: 6) {
                Text("Recent Transcripts")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                
                ScrollView {
                    VStack(spacing: 6) {
                        ForEach(state.history) { item in
                            HStack(alignment: .top) {
                                Image(systemName: "quote.bubble")
                                    .font(.system(size: 10))
                                    .foregroundColor(.secondary)
                                    .padding(.top, 2)
                                Text(item.text)
                                    .font(.system(size: 11))
                                    .lineLimit(2)
                                Spacer()
                                Text(String(format: "%.1fs", item.duration))
                                    .font(.system(size: 9, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                            .padding(6)
                            .background(Color.primary.opacity(0.03))
                            .cornerRadius(6)
                        }
                    }
                }
                .frame(maxHeight: 90)
            }
            
            // Footer
            HStack {
                switch license.status {
                case .active(let tier, _):
                    Text("✓ \(tier)")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.green)
                case .trial(let days):
                    Text("\(days) days left in Pro Trial")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                default:
                    Text("Free Mode")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button("Quit") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(.plain)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .frame(width: 350, height: 480)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<WhisperTapView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = WhisperTapView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "waveform.circle",
            titleText: "WhisperTap",
            contentWidth: 350,
            contentHeight: 480
        )
    }
}

// Entrypoint
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
