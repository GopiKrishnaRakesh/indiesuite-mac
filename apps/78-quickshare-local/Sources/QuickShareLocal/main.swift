import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class QuickShareLocalState: ObservableObject {

    @Published var localUrl: String = "http://192.168.1.14:8080/share"

}

struct QuickShareLocalView: View {
    @StateObject private var state = QuickShareLocalState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bonjour")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("QuickShare Local")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("P2P Web Server")
                    .font(.system(size: 9))
            }
            
            Text("Share with any device on your Wi-Fi: \(state.localUrl)")
                .font(.system(size: 10, design: .monospaced))
                .foregroundColor(.blue)
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
    var menuBarController: MenuBarController<QuickShareLocalView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = QuickShareLocalView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "bonjour",
            titleText: "QuickShare",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
