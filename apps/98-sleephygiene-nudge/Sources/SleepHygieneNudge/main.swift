import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class SleepHygieneNudgeState: ObservableObject {

    @Published var bedtimeHour: String = "11:00 PM"

}

struct SleepHygieneNudgeView: View {
    @StateObject private var state = SleepHygieneNudgeState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "moon.stars.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("SleepHygiene Nudge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Warm Filter Active")
            }
            
            Text("Warms color temperature to 2400K and enforces screen wind-down 60m before bed.")
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
    var menuBarController: MenuBarController<SleepHygieneNudgeView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = SleepHygieneNudgeView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "moon.stars.fill",
            titleText: "Bedtime (11 PM)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
