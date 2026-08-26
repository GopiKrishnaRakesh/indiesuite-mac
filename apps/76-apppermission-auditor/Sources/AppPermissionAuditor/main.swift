import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class AppPermissionAuditorState: ObservableObject {

    @Published var appsWithAccess: Int = 12

}

struct AppPermissionAuditorView: View {
    @StateObject private var state = AppPermissionAuditorState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "lock.trianglebadge.exclamationmark.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("AppPermission Auditor")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("TCC Audit")
                    .font(.system(size: 10))
            }
            
            Text("12 apps have screen recording or accessibility access. 1-click revoke available.")
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
    var menuBarController: MenuBarController<AppPermissionAuditorView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = AppPermissionAuditorView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "lock.trianglebadge.exclamationmark.fill",
            titleText: "Permissions",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
