import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DMInboxUnifiedState: ObservableObject {

    @Published var unreadCount: Int = 2

}

struct DMInboxUnifiedView: View {
    @StateObject private var state = DMInboxUnifiedState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "tray.full.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("DMInbox Unified")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.unreadCount) Unread DMs")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("Slack: Team lead mentioned you in #deployments")
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
    var menuBarController: MenuBarController<DMInboxUnifiedView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DMInboxUnifiedView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "tray.full.fill",
            titleText: "DMs (2)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
