import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class SqlQueryAIState: ObservableObject {

    @Published var query: String = "SELECT * FROM apps WHERE downloads > 1000 ORDER BY rating DESC;"

}

struct SqlQueryAIView: View {
    @StateObject private var state = SqlQueryAIState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "server.rack")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("SqlQuery AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("SQL Ready")
            }
            
            Text(state.query)
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
    var menuBarController: MenuBarController<SqlQueryAIView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = SqlQueryAIView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "server.rack",
            titleText: "SQL AI",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
