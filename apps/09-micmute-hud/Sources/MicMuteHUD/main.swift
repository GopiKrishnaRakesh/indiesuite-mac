import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class MicMuteState: ObservableObject {
    @Published var isMuted: Bool = false
    @Published var isCameraBlocked: Bool = false
    @Published var playSoundCue: Bool = true
    @Published var showOnScreenPill: Bool = true
    @Published var activeMic: String = "Built-in Microphone (MacBook Pro)"
    
    func toggleMute() {
        isMuted.toggle()
        if playSoundCue {
            NSSound(named: isMuted ? "Purr" : "Pop")?.play()
        }
    }
}

struct MicMuteView: View {
    @StateObject private var state = MicMuteState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: state.isMuted ? "mic.slash.fill" : "mic.fill")
                        .font(.system(size: 18))
                        .foregroundColor(state.isMuted ? .red : .green)
                    Text("MicMute HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                HotkeyPill(keyCombination: "⌘ ⇧ M")
            }
            
            // Big Toggle Button
            Button(action: {
                state.toggleMute()
            }) {
                VStack(spacing: 8) {
                    Circle()
                        .fill(state.isMuted ? Color.red.opacity(0.18) : Color.green.opacity(0.18))
                        .frame(width: 58, height: 58)
                        .overlay(
                            Image(systemName: state.isMuted ? "mic.slash.fill" : "mic.fill")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(state.isMuted ? .red : .green)
                        )
                    
                    Text(state.isMuted ? "MICROPHONE MUTED" : "MICROPHONE LIVE")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(state.isMuted ? .red : .green)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .glassCard(cornerRadius: 12)
            }
            .buttonStyle(.plain)
            
            // Preferences
            VStack(spacing: 8) {
                HStack {
                    Text("Input Device")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(state.activeMic)
                        .font(.system(size: 10))
                        .lineLimit(1)
                }
                
                Divider()
                
                Toggle("Sound cue on toggle", isOn: $state.playSoundCue)
                    .font(.system(size: 11))
                
                Toggle("Floating On-Screen Pill Indicator", isOn: $state.showOnScreenPill)
                    .font(.system(size: 11))
            }
            .padding(10)
            .glassCard(cornerRadius: 10)
            
            // Footer
            HStack {
                Text("Works across Zoom, Meet, Teams, Discord")
                    .font(.system(size: 9))
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
        .frame(width: 320, height: 350)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<MicMuteView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = MicMuteView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "mic.fill",
            titleText: nil,
            contentWidth: 320,
            contentHeight: 350
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
