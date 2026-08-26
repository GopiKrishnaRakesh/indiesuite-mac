import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class VoiceTranscribeBatchState: ObservableObject {

    @Published var filesProcessed: Int = 12

}

struct VoiceTranscribeBatchView: View {
    @StateObject private var state = VoiceTranscribeBatchState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "mic.badge.plus")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("VoiceTranscribe Batch")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("WhisperKit MLX")
                    .font(.system(size: 10))
            }
            
            Text("Drop .mp3 / .wav / .m4a files for batch background transcription with timestamps.")
                .font(.system(size: 10))
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
    var menuBarController: MenuBarController<VoiceTranscribeBatchView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = VoiceTranscribeBatchView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "mic.badge.plus",
            titleText: "Batch Audio",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
