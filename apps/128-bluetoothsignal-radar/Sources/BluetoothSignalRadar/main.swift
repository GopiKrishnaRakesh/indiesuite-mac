import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class BluetoothSignalRadarState: ObservableObject {

    @Published var airpodsRssi: String = "-38 dBm (Strong)"

}

struct BluetoothSignalRadarView: View {
    @StateObject private var state = BluetoothSignalRadarState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "antenna.radiowaves.left.and.right.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("BluetoothSignal Radar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Strong Signal")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("AirPods Pro: -38 dBm • Magic Keyboard: -44 dBm • Magic Mouse: -48 dBm")
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
    var menuBarController: MenuBarController<BluetoothSignalRadarView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = BluetoothSignalRadarView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "antenna.radiowaves.left.and.right.circle.fill",
            titleText: "AirPods (-38dBm)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
