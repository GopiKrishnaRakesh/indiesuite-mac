import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DeepFlowBlockerState: ObservableObject {

    @Published var isShieldActive: Bool = true
    @Published var blockedSites: [String] = ["x.com", "reddit.com", "youtube.com", "instagram.com"]

}

struct DeepFlowBlockerView: View {
    @StateObject private var state = DeepFlowBlockerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shield.lefthalf.filled")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("DeepFlow Blocker")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.isShieldActive ? "SHIELD ON" : "PAUSED")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(state.isShieldActive ? .green : .secondary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Blocked Domains")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                Text(state.blockedSites.joined(separator: " • "))
                    .font(.system(size: 11, design: .monospaced))
                    .padding(8)
                    .glassCard(cornerRadius: 8)
            }

            
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
    var menuBarController: MenuBarController<DeepFlowBlockerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DeepFlowBlockerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "shield.lefthalf.filled",
            titleText: "Shield (Active)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
