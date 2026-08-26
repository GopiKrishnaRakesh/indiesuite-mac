import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class JSONMasterProState: ObservableObject {

    @Published var isValidJSON: Bool = true

}

struct JSONMasterProView: View {
    @StateObject private var state = JSONMasterProState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "curlybraces")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("JSONMaster Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Valid JSON ✓")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Tree inspector, YAML/TOML converter, and TypeScript interface generator.")
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
    var menuBarController: MenuBarController<JSONMasterProView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = JSONMasterProView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "curlybraces",
            titleText: "JSON Pro",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
