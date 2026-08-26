import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CodeOtterState: ObservableObject {

    @Published var fishCaught: Int = 18

}

struct CodeOtterView: View {
    @StateObject private var state = CodeOtterState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "water.waves")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("CodeOtter")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🦦 18 Fish")
            }
            
            Text("Otter companion celebrates when unit tests pass with celebratory swimming flips.")
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
    var menuBarController: MenuBarController<CodeOtterView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CodeOtterView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "water.waves",
            titleText: "CodeOtter",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
