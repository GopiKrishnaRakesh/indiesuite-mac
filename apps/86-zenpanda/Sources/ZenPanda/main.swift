import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ZenPandaState: ObservableObject {

    @Published var breatheState: String = "Inhale (4s)..."

}

struct ZenPandaView: View {
    @StateObject private var state = ZenPandaState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("ZenPanda")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🐼 Zen Mode")
            }
            
            Text(state.breatheState)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.cyan)
                .padding(10)
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
    var menuBarController: MenuBarController<ZenPandaView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ZenPandaView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "heart.circle.fill",
            titleText: "ZenPanda",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
