import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class StandUpTimerState: ObservableObject {

    @Published var standIntervalMins: Int = 45
    @Published var sitIntervalMins: Int = 15

}

struct StandUpTimerView: View {
    @StateObject private var state = StandUpTimerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("StandUp Timer")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Standing Time")
                    .font(.system(size: 10))
            }
            
            HStack(spacing: 8) {
                MetricBadge(title: "Sit Interval", value: "45 min", icon: "chair.fill", tint: .blue)
                MetricBadge(title: "Stand Interval", value: "15 min", icon: "figure.stand", tint: .orange)
            }

            
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
    var menuBarController: MenuBarController<StandUpTimerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = StandUpTimerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "arrow.up.circle.fill",
            titleText: "Stand (22m)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
