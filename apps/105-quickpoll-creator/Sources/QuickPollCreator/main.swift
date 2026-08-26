import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class QuickPollCreatorState: ObservableObject {

    @Published var question: String = "What is your favorite macOS utility category?"

}

struct QuickPollCreatorView: View {
    @StateObject private var state = QuickPollCreatorState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("QuickPoll Creator")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Multi-Platform")
            }
            
            Text("1. Developer Tools • 2. Desktop Pets • 3. Focus & Flow • 4. Local AI")
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
    var menuBarController: MenuBarController<QuickPollCreatorView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = QuickPollCreatorView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "chart.bar.fill",
            titleText: "Poll Creator",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
