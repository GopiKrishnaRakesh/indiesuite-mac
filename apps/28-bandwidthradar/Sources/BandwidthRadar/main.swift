import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class BandwidthRadarState: ObservableObject {

    @Published var downSpeed: String = "2.4 MB/s"
    @Published var upSpeed: String = "480 KB/s"

}

struct BandwidthRadarView: View {
    @StateObject private var state = BandwidthRadarState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("BandwidthRadar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Live Monitor")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 8) {
                MetricBadge(title: "Download", value: state.downSpeed, icon: "arrow.down", tint: .green)
                MetricBadge(title: "Upload", value: state.upSpeed, icon: "arrow.up", tint: .blue)
            }

            
            HStack {
                Text("Indie Suite Pro Ready")
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
    var menuBarController: MenuBarController<BandwidthRadarView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = BandwidthRadarView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "antenna.radiowaves.left.and.right",
            titleText: "↓ 2.4 MB/s",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
