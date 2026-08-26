import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class SqliteLensState: ObservableObject {

    @Published var tablesCount: Int = 14

}

struct SqliteLensView: View {
    @StateObject private var state = SqliteLensState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cylinder.split.1x2.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("SqliteLens")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.tablesCount) Tables")
                    .font(.system(size: 10))
            }
            
            Text("Drop any .db / .sqlite file to browse rows, run queries, and export CSVs.")
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
    var menuBarController: MenuBarController<SqliteLensView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = SqliteLensView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "cylinder.split.1x2.fill",
            titleText: "SQLite",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
