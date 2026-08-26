import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class StatusSyncState: ObservableObject {

    @Published var currentStatus: String = "🎧 Deep Coding (Do Not Disturb)"
    @Published var activePlatforms: [String] = ["Slack", "Discord", "Teams"]

}

struct StatusSyncView: View {
    @StateObject private var state = StatusSyncState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("StatusSync")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("3 Apps Synced")
                    .font(.system(size: 10))
            }
            
            Text(state.currentStatus)
                .font(.system(size: 11, weight: .bold))
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
    var menuBarController: MenuBarController<StatusSyncView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = StatusSyncView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "bubble.left.and.bubble.right.fill",
            titleText: "Status (Sync)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
