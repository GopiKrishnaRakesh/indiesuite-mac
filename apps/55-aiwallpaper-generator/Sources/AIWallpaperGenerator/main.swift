import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class AIWallpaperGeneratorState: ObservableObject {

    @Published var prompt: String = "Futuristic neon cyberpunk Tokyo rain 4K"

}

struct AIWallpaperGeneratorView: View {
    @StateObject private var state = AIWallpaperGeneratorState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "photo.artframe")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("AIWallpaper Generator")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("CoreML 4K")
                    .font(.system(size: 10))
            }
            
            Text("Prompt: \(state.prompt)")
                .font(.system(size: 11))
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
    var menuBarController: MenuBarController<AIWallpaperGeneratorView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = AIWallpaperGeneratorView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "photo.artframe",
            titleText: "Wallpapers",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
