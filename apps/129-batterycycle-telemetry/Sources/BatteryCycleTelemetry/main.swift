import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class BatteryCycleTelemetryState: ObservableObject {

    @Published var cycles: Int = 142
    @Published var maxCapacity: Int = 97

}

struct BatteryCycleTelemetryView: View {
    @StateObject private var state = BatteryCycleTelemetryState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("BatteryCycle Telemetry")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("97% Max Capacity")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("142 cycles over 14 months • 0.2% monthly degradation rate (Optimal)")
                .font(.system(size: 10))
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
    var menuBarController: MenuBarController<BatteryCycleTelemetryView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = BatteryCycleTelemetryView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "chart.xyaxis.line",
            titleText: "Battery (97%)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
