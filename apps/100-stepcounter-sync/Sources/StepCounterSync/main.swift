import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class StepCounterSyncState: ObservableObject {

    @Published var steps: Int = 7420
    @Published var goal: Int = 10000

}

struct StepCounterSyncView: View {
    @StateObject private var state = StepCounterSyncState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "figure.walk.motion")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("StepCounter Sync")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("74% Goal")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("7,420 / 10,000 daily steps completed from Apple Health.")
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
    var menuBarController: MenuBarController<StepCounterSyncView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = StepCounterSyncView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "figure.walk.motion",
            titleText: "7,420 Steps",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
