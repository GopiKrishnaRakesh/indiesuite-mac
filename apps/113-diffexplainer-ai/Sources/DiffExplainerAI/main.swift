import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DiffExplainerAIState: ObservableObject {

    @Published var releaseNote: String = "- Added 50 new apps (Suite now total 130 apps)\n- Optimized build pipeline"

}

struct DiffExplainerAIView: View {
    @StateObject private var state = DiffExplainerAIState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("DiffExplainer AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Changelog")
            }
            
            Text(state.releaseNote)
                .font(.system(size: 10, design: .monospaced))
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
    var menuBarController: MenuBarController<DiffExplainerAIView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DiffExplainerAIView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "list.bullet.rectangle.portrait.fill",
            titleText: "Diff AI",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
