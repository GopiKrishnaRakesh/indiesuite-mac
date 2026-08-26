import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DeskDuckState: ObservableObject {

    @Published var socraticPrompt: String = "What did you expect the code to do versus what actually happened?"

}

struct DeskDuckView: View {
    @StateObject private var state = DeskDuckState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "questionmark.bubble.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("DeskDuck")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🦆 Quack!")
            }
            
            Text(state.socraticPrompt)
                .font(.system(size: 11, weight: .semibold))
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
    var menuBarController: MenuBarController<DeskDuckView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DeskDuckView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "questionmark.bubble.fill",
            titleText: "DeskDuck",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
