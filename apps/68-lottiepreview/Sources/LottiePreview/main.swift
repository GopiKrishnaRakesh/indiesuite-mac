import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class LottiePreviewState: ObservableObject {

    @Published var fps: Int = 60

}

struct LottiePreviewView: View {
    @StateObject private var state = LottiePreviewState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("LottiePreview")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("60 FPS")
                    .font(.system(size: 10))
            }
            
            Text("Drop .lottie or .json to inspect vector animation frames and export transparent GIFs.")
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
    var menuBarController: MenuBarController<LottiePreviewView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = LottiePreviewView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "play.circle.fill",
            titleText: "Lottie (60fps)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
