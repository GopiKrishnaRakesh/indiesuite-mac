import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class TeleprompterHUDState: ObservableObject {

    @Published var scrollSpeed: Double = 1.2

}

struct TeleprompterHUDView: View {
    @StateObject private var state = TeleprompterHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "text.quote")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("Teleprompter HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1.2x Speed")
            }
            
            Text("Place near webcam for natural eye contact during remote presentations and recordings.")
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
    var menuBarController: MenuBarController<TeleprompterHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = TeleprompterHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "text.quote",
            titleText: "Prompter",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
