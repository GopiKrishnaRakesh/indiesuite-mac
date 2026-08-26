import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class TailLogsState: ObservableObject {

    @Published var logLines: Int = 1420

}

struct TailLogsView: View {
    @StateObject private var state = TailLogsState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("TailLogs")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Tailing 3 Files")
                    .font(.system(size: 10))
            }
            
            Text("[200 OK] GET /api/v1/auth - 12ms • [500 ERR] POST /webhook - timeout")
                .font(.system(size: 9, design: .monospaced))
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
    var menuBarController: MenuBarController<TailLogsView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = TailLogsView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "doc.text.fill",
            titleText: "Logs (Live)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
