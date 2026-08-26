import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class RedisLensState: ObservableObject {

    @Published var keyCount: Int = 240

}

struct RedisLensView: View {
    @StateObject private var state = RedisLensState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cylinder.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("RedisLens")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("240 Keys")
            }
            
            Text("session:user_8912 (TTL: 3400s) • cache:homepage (TTL: 120s)")
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
    var menuBarController: MenuBarController<RedisLensView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = RedisLensView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "cylinder.fill",
            titleText: "Redis (6379)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
