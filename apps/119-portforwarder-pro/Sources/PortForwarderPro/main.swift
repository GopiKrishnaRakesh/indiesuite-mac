import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PortForwarderProState: ObservableObject {

    @Published var activeTunnel: String = "localhost:5433 -> prod-db:5432"

}

struct PortForwarderProView: View {
    @StateObject private var state = PortForwarderProState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.swap")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("PortForwarder Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Connected ✓")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text(state.activeTunnel)
                .font(.system(size: 10, design: .monospaced))
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
    var menuBarController: MenuBarController<PortForwarderProView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PortForwarderProView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "arrow.triangle.swap",
            titleText: "SSH Tunnel",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
