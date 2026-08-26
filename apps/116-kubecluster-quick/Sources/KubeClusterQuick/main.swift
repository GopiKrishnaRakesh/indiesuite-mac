import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class KubeClusterQuickState: ObservableObject {

    @Published var podCount: Int = 6

}

struct KubeClusterQuickView: View {
    @StateObject private var state = KubeClusterQuickState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shippingbox.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("KubeCluster Quick")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("6 Pods Healthy")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("ingress-controller • auth-service • api-deployment • redis-master")
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
    var menuBarController: MenuBarController<KubeClusterQuickView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = KubeClusterQuickView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "shippingbox.circle.fill",
            titleText: "K8s (6 Pods)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
