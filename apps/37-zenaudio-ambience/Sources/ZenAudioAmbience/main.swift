import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ZenAudioAmbienceState: ObservableObject {

    @Published var soundTrack: String = "Nordic Rain & Brown Noise"
    @Published var volume: Double = 0.7

}

struct ZenAudioAmbienceView: View {
    @StateObject private var state = ZenAudioAmbienceState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "headphones")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("ZenAudio Ambience")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("432Hz Focus")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.cyan)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Soundscape: \(state.soundTrack)")
                    .font(.system(size: 11, weight: .semibold))
                Slider(value: $state.volume, in: 0...1)
            }
            .padding(8)
            .glassCard(cornerRadius: 8)

            
            HStack {
                Text("Indie Suite Pro • 80 Apps")
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
        .frame(width: 340, height: 360)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<ZenAudioAmbienceView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ZenAudioAmbienceView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "headphones",
            titleText: "Zen (Rain)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
