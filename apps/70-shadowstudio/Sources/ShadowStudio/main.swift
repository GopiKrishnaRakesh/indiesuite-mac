import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ShadowStudioState: ObservableObject {

    @Published var layers: Int = 4

}

struct ShadowStudioView: View {
    @StateObject private var state = ShadowStudioState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shadow")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ShadowStudio")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("4-Layer Shadow")
                    .font(.system(size: 10))
            }
            
            Text("Multi-layer diffused lighting shadows with 1-click SwiftUI .shadow() export.")
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
    var menuBarController: MenuBarController<ShadowStudioView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ShadowStudioView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "shadow",
            titleText: "Shadows",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
