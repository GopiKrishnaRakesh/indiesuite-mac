import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class VideoThumbnailTesterState: ObservableObject {

    @Published var ctrPrediction: String = "12.4% (High Contrast)"

}

struct VideoThumbnailTesterView: View {
    @StateObject private var state = VideoThumbnailTesterState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "photo.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("VideoThumbnail Tester")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.ctrPrediction)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Simulates YouTube homepage and mobile feed appearance before uploading.")
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
    var menuBarController: MenuBarController<VideoThumbnailTesterView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = VideoThumbnailTesterView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "photo.fill",
            titleText: "Thumbnail Test",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
