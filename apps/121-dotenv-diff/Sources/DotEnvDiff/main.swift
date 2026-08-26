import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DotEnvDiffState: ObservableObject {

    @Published var missingKeys: [String] = ["STRIPE_WEBHOOK_SECRET"]

}

struct DotEnvDiffView: View {
    @StateObject private var state = DotEnvDiffState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.badge.ellipsis")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("DotEnv Diff")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1 Missing Key")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("Missing in .env: STRIPE_WEBHOOK_SECRET (required by .env.example)")
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
    var menuBarController: MenuBarController<DotEnvDiffView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DotEnvDiffView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "doc.badge.ellipsis",
            titleText: ".env Diff",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
