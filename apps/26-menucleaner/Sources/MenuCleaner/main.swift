import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class MenuCleanerState: ObservableObject {

    @Published var isHidden: Bool = false
    @Published var autoHideSeconds: Int = 10

}

struct MenuCleanerView: View {
    @StateObject private var state = MenuCleanerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left.2")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("MenuCleaner")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Menu Bar Organizer")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            Toggle("Collapse Inactive Icons Behind Divider", isOn: $state.isHidden)
                .font(.system(size: 11))
                .padding(8)
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
    var menuBarController: MenuBarController<MenuCleanerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = MenuCleanerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "chevron.left.2",
            titleText: "<|",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
