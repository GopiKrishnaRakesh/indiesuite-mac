import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PodcastChapterMarkerState: ObservableObject {

    @Published var chapterCount: Int = 8

}

struct PodcastChapterMarkerView: View {
    @StateObject private var state = PodcastChapterMarkerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "waveform.and.magnifyingglass")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PodcastChapter Marker")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("8 Chapters")
            }
            
            Text("00:00 Intro • 04:20 Architecture • 12:40 Live Demo • 22:10 Q&A")
                .font(.system(size: 10, design: .monospaced))
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
    var menuBarController: MenuBarController<PodcastChapterMarkerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PodcastChapterMarkerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "waveform.and.magnifyingglass",
            titleText: "Chapters",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
