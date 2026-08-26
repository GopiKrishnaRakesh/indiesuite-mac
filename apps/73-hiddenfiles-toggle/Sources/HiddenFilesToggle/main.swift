import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class HiddenFilesToggleState: ObservableObject {

    @Published var showHidden: Bool = true

}

struct HiddenFilesToggleView: View {
    @StateObject private var state = HiddenFilesToggleState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "eye.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("HiddenFiles Toggle")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌘ ⇧ .")
            }
            
            Toggle("Show hidden dotfiles (.git, .env, .zshrc) in Finder", isOn: $state.showHidden)
                .font(.system(size: 11))
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
    var menuBarController: MenuBarController<HiddenFilesToggleView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = HiddenFilesToggleView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "eye.circle.fill",
            titleText: "Dotfiles",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
