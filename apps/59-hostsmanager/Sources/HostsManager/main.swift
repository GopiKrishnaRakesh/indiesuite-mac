import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class HostsManagerState: ObservableObject {

    @Published var activeProfile: String = "Local Dev (127.0.0.1)"

}

struct HostsManagerView: View {
    @StateObject private var state = HostsManagerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "server.rack")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("HostsManager")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.activeProfile)
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text("1-click switch between Staging, Dev, QA, and Production DNS entries.")
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
    var menuBarController: MenuBarController<HostsManagerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = HostsManagerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "server.rack",
            titleText: "Hosts (Dev)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
