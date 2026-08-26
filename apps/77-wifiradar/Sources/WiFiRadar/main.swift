import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class WiFiRadarState: ObservableObject {

    @Published var signalRSSI: String = "-42 dBm (Excellent)"
    @Published var speedMbps: Int = 680

}

struct WiFiRadarView: View {
    @StateObject private var state = WiFiRadarState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "wifi")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("WiFiRadar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.speedMbps) Mbps")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Signal: \(state.signalRSSI) • Channel 149 (5GHz 80MHz)")
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
    var menuBarController: MenuBarController<WiFiRadarView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = WiFiRadarView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "wifi",
            titleText: "WiFi (5GHz)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
