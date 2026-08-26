import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class WhisperSubtitlesSRTState: ObservableObject {

    @Published var subtitleFormat: String = "SubRip (.srt) + WebVTT (.vtt)"

}

struct WhisperSubtitlesSRTView: View {
    @StateObject private var state = WhisperSubtitlesSRTState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "captions.bubble.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("WhisperSubtitles SRT")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("100% Offline")
            }
            
            Text("Drop any .mp4 or .mov video to generate accurate subtitle tracks with zero cloud delay.")
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
    var menuBarController: MenuBarController<WhisperSubtitlesSRTView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = WhisperSubtitlesSRTView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "captions.bubble.fill",
            titleText: "SRT Maker",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
