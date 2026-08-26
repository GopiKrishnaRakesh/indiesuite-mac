import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CleanDeskProState: ObservableObject {

    @Published var hideDesktopIcons: Bool = true
    @Published var muteNotifications: Bool = true
    @Published var presentationWallpaper: Bool = false

}

struct CleanDeskProView: View {
    @StateObject private var state = CleanDeskProState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("CleanDesk Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1-Click Presentation")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 8) {
                Toggle("Hide all Desktop icons", isOn: $state.hideDesktopIcons)
                    .font(.system(size: 11))
                Toggle("Do Not Disturb (Silence alerts)", isOn: $state.muteNotifications)
                    .font(.system(size: 11))
            }
            .padding(10)
            .glassCard(cornerRadius: 8)

            
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
    var menuBarController: MenuBarController<CleanDeskProView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CleanDeskProView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "sparkles",
            titleText: "CleanDesk",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
