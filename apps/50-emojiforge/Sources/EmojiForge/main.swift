import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class EmojiForgeState: ObservableObject {

    @Published var kaomoji: String = "(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧"

}

struct EmojiForgeView: View {
    @StateObject private var state = EmojiForgeState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "face.smiling.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("EmojiForge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌘ .")
            }
            
            Text("Quick Kaomoji: (╯°□°)╯︵ ┻━┻ • ¯\\_(ツ)_/¯ • (•‿•)")
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
    var menuBarController: MenuBarController<EmojiForgeView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = EmojiForgeView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "face.smiling.fill",
            titleText: "Emoji",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
