import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ScratchPadHUDState: ObservableObject {

    @Published var noteContent: String = "## Daily Sprint Notes\n- Deploy 30 macOS Apps via Website\n- Setup LemonSqueezy Checkout Webhook\n- Test Sparkle auto-updater appcasts"

}

struct ScratchPadHUDView: View {
    @StateObject private var state = ScratchPadHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "note.text")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ScratchPad HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌥ N")
            }
            
            TextEditor(text: $state.noteContent)
                .font(.system(size: 11, design: .monospaced))
                .frame(height: 140)
                .padding(4)
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
    var menuBarController: MenuBarController<ScratchPadHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ScratchPadHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "note.text",
            titleText: "Notes",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
