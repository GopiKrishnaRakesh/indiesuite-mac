import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class AppIconForgeState: ObservableObject {

    @Published var iconsGenerated: Int = 24

}

struct AppIconForgeView: View {
    @StateObject private var state = AppIconForgeState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "app.badge.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("AppIconForge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("24 Icons")
                    .font(.system(size: 10))
            }
            
            Text("Generates complete AppIcon.appiconset with Contents.json in 1 second.")
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
    var menuBarController: MenuBarController<AppIconForgeView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = AppIconForgeView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "app.badge.fill",
            titleText: "IconForge",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
