import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class BluetoothAutoHopState: ObservableObject {

    @Published var connectedDevice: String = "AirPods Pro (2nd Gen)"
    @Published var batteryLevel: Int = 85

}

struct BluetoothAutoHopView: View {
    @StateObject private var state = BluetoothAutoHopState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "headphones")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("BluetoothAutoHop")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.batteryLevel)%")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(state.connectedDevice)
                    .font(.system(size: 12, weight: .bold))
                Text("Auto-disconnect on system sleep • Auto-reconnect on wake")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            .padding(8)
            .glassCard(cornerRadius: 8)

            
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
    var menuBarController: MenuBarController<BluetoothAutoHopView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = BluetoothAutoHopView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "headphones",
            titleText: "AirPods (85%)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
