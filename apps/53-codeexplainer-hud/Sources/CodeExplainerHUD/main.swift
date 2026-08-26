import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CodeExplainerHUDState: ObservableObject {

    @Published var explanation: String = "This regex validates RFC 5322 email addresses with domain extensions."

}

struct CodeExplainerHUDView: View {
    @StateObject private var state = CodeExplainerHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("CodeExplainer HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Instant Decrypt")
                    .font(.system(size: 10))
            }
            
            Text(state.explanation)
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
    var menuBarController: MenuBarController<CodeExplainerHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CodeExplainerHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "questionmark.circle.fill",
            titleText: "Explain",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
