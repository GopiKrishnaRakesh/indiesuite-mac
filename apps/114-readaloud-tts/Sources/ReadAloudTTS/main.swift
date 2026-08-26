import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ReadAloudTTSState: ObservableObject {

    @Published var voice: String = "Neural Samantha (Natural HD)"

}

struct ReadAloudTTSView: View {
    @StateObject private var state = ReadAloudTTSState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "speaker.wave.3.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("ReadAloud TTS")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.voice)
                    .font(.system(size: 9))
            }
            
            Text("Listen to articles and documentation hands-free with high-definition offline voice synthesis.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)

            
            HStack {
                Text("Indie Suite Pro • 130 Apps")
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
    var menuBarController: MenuBarController<ReadAloudTTSView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ReadAloudTTSView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "speaker.wave.3.fill",
            titleText: "Neural TTS",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
