import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class HttpHeaderInspectorState: ObservableObject {

    @Published var corsStatus: String = "Access-Control-Allow-Origin: *"

}

struct HttpHeaderInspectorView: View {
    @StateObject private var state = HttpHeaderInspectorState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shield.checkered")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("HttpHeader Inspector")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("TLS 1.3")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text("Strict-Transport-Security • X-Content-Type-Options: nosniff")
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
    var menuBarController: MenuBarController<HttpHeaderInspectorView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = HttpHeaderInspectorView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "shield.checkered",
            titleText: "HTTP Headers",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
