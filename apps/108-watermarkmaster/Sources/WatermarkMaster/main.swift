import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class WatermarkMasterState: ObservableObject {

    @Published var opacity: Double = 0.5

}

struct WatermarkMasterView: View {
    @StateObject private var state = WatermarkMasterState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "signature")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("WatermarkMaster")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Batch Stamp")
            }
            
            Text("Drop image folder to stamp dynamic copyright, logo, or transparent signature.")
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
    var menuBarController: MenuBarController<WatermarkMasterView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = WatermarkMasterView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "signature",
            titleText: "Watermark",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
