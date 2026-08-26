import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class TabLimiterProState: ObservableObject {

    @Published var maxTabsAllowed: Int = 5

}

struct TabLimiterProView: View {
    @StateObject private var state = TabLimiterProState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "square.stack.3d.down.right.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("TabLimiter Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Max 5 Tabs")
            }
            
            Text("Maintains cognitive clarity by preventing 50+ tab hoarding in Safari and Chrome.")
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
    var menuBarController: MenuBarController<TabLimiterProView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = TabLimiterProView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "square.stack.3d.down.right.fill",
            titleText: "Tabs (Max 5)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
