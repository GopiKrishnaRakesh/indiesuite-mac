import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DiscordRoleAutoPingState: ObservableObject {

    @Published var embedTitle: String = "🚀 Major Suite Release v2.0"

}

struct DiscordRoleAutoPingView: View {
    @StateObject private var state = DiscordRoleAutoPingState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bubble.left.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("DiscordRole AutoPing")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Rich Embed")
            }
            
            Text("Generates formatted JSON payloads for webhooks and community announcements.")
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
    var menuBarController: MenuBarController<DiscordRoleAutoPingView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DiscordRoleAutoPingView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "bubble.left.fill",
            titleText: "Discord Helper",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
