import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CertSentryState: ObservableObject {

    @Published var domainsTracked: Int = 8

}

struct CertSentryView: View {
    @StateObject private var state = CertSentryState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "lock.badge.clock.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("CertSentry")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("8 Domains Valid")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("indiesuite.app (Expires in 84 days) • api.indiesuite.app (Expires in 34 days)")
                .font(.system(size: 10, design: .monospaced))
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
    var menuBarController: MenuBarController<CertSentryView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CertSentryView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "lock.badge.clock.fill",
            titleText: "SSL (34d)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
