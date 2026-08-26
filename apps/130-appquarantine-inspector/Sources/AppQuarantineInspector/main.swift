import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class AppQuarantineInspectorState: ObservableObject {

    @Published var quarantinedApps: Int = 2

}

struct AppQuarantineInspectorView: View {
    @StateObject private var state = AppQuarantineInspectorState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "lock.open.shield.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("AppQuarantine Inspector")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Gatekeeper Tool")
            }
            
            Text("1-click clear xattr -d com.apple.quarantine for unsigned developer test builds.")
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
    var menuBarController: MenuBarController<AppQuarantineInspectorView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = AppQuarantineInspectorView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "lock.open.shield.fill",
            titleText: "Quarantine",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
