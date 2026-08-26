import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DnsLookupHUDState: ObservableObject {

    @Published var ipAddress: String = "76.76.21.21 (Vercel Anycast)"

}

struct DnsLookupHUDView: View {
    @StateObject private var state = DnsLookupHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "globe.americas.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("DnsLookup HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Global Propagated")
                    .font(.system(size: 9))
                    .foregroundColor(.green)
            }
            
            Text("indiesuite.app -> A Record: 76.76.21.21 • TTL: 300s")
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
    var menuBarController: MenuBarController<DnsLookupHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DnsLookupHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "globe.americas.fill",
            titleText: "DNS Lookup",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
