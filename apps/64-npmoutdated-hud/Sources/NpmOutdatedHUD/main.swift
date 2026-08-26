import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class NpmOutdatedHUDState: ObservableObject {

    @Published var outdatedPackages: Int = 3

}

struct NpmOutdatedHUDView: View {
    @StateObject private var state = NpmOutdatedHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.shield.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("NpmOutdated HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("3 Patches Available")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("next@15.1.0 (Security Patch) • axios@1.7.9 • tailwindcss@4.0")
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
    var menuBarController: MenuBarController<NpmOutdatedHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = NpmOutdatedHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "exclamationmark.shield.fill",
            titleText: "NPM Radar",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
