import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DisksCleanerMiniState: ObservableObject {

    @Published var reclaimableGB: Double = 18.4

}

struct DisksCleanerMiniView: View {
    @StateObject private var state = DisksCleanerMiniState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "internaldrive.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("DisksCleaner Mini")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("18.4 GB Cleanable")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("node_modules (8.2 GB) • Xcode DerivedData (6.4 GB) • Old DMGs (3.8 GB)")
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
    var menuBarController: MenuBarController<DisksCleanerMiniView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DisksCleanerMiniView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "internaldrive.fill",
            titleText: "Disk (42GB Free)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
