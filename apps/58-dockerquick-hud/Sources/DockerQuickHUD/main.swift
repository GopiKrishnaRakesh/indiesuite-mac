import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DockerQuickHUDState: ObservableObject {

    @Published var runningContainers: Int = 4

}

struct DockerQuickHUDView: View {
    @StateObject private var state = DockerQuickHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shippingbox.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("DockerQuick HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.runningContainers) Running")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("redis:latest • postgres:16 • nextjs-app • api-gateway")
                .font(.system(size: 10, design: .monospaced))
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
    var menuBarController: MenuBarController<DockerQuickHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DockerQuickHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "shippingbox.fill",
            titleText: "Docker (4)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
