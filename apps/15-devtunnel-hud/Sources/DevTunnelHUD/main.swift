import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DevTunnelHUDState: ObservableObject {

    @Published var activeTunnels: [TunnelInfo] = [
        TunnelInfo(provider: "Cloudflare", localPort: 3000, publicUrl: "https://indie-preview.trycloudflare.com", status: "Online", requests: 142),
        TunnelInfo(provider: "Ngrok", localPort: 8000, publicUrl: "https://9b41-2a02.ngrok-free.app", status: "Online", requests: 38)
    ]
    struct TunnelInfo: Identifiable {
        let id = UUID()
        let provider: String
        let localPort: Int
        let publicUrl: String
        let status: String
        let requests: Int
    }

}

struct DevTunnelHUDView: View {
    @StateObject private var state = DevTunnelHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "point.3.connected.trianglepath.dotted")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("DevTunnel HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("2 Tunnels Active")
                    .font(.system(size: 10, weight: .bold))
                    .padding(4)
                    .background(Color.cyan.opacity(0.15))
                    .cornerRadius(4)
            }
            
            VStack(spacing: 8) {
                ForEach(state.activeTunnels) { t in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(t.provider)
                                .font(.system(size: 11, weight: .bold))
                            Spacer()
                            Text(":\(t.localPort)")
                                .font(.system(size: 10, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                        Text(t.publicUrl)
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundColor(.blue)
                    }
                    .padding(8)
                    .glassCard(cornerRadius: 8)
                }
            }

            
            HStack {
                Text("Indie Suite Pro Ready")
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
    var menuBarController: MenuBarController<DevTunnelHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DevTunnelHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "point.3.connected.trianglepath.dotted",
            titleText: "Tunnels (2)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
