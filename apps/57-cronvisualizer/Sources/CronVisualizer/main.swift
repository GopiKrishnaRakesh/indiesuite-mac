import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CronVisualizerState: ObservableObject {

    @Published var cronExpr: String = "*/15 * * * *"
    @Published var humanMeaning: String = "Every 15 minutes"

}

struct CronVisualizerView: View {
    @StateObject private var state = CronVisualizerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("CronVisualizer")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.cronExpr)
                    .font(.system(size: 10, design: .monospaced))
            }
            
            Text("Meaning: \(state.humanMeaning)")
                .font(.system(size: 11, weight: .bold))
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
    var menuBarController: MenuBarController<CronVisualizerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CronVisualizerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "clock.arrow.circlepath",
            titleText: "Cron (*/5)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
