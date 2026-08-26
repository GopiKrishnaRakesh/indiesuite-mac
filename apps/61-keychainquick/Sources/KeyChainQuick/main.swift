import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class KeyChainQuickState: ObservableObject {

    @Published var keyCount: Int = 5

}

struct KeyChainQuickView: View {
    @StateObject private var state = KeyChainQuickState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "key.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("KeyChainQuick")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌥ K")
            }
            
            Text("id_ed25519.pub • github_deploy_key • aws_s3_read_token")
                .font(.system(size: 10, design: .monospaced))
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
    var menuBarController: MenuBarController<KeyChainQuickView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = KeyChainQuickView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "key.fill",
            titleText: "SSH Keys",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
