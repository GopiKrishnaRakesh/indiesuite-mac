import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DayPlannerNotchState: ObservableObject {

    @Published var nextMeeting: String = "Sprint Review @ 3:00 PM"
    @Published var eventsLeftToday: Int = 3

}

struct DayPlannerNotchView: View {
    @StateObject private var state = DayPlannerNotchState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "calendar.badge.clock")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("DayPlanner Notch")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.eventsLeftToday) Events Left")
                    .font(.system(size: 10))
            }
            
            Text("Upcoming: \(state.nextMeeting)")
                .font(.system(size: 11, weight: .semibold))
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
    var menuBarController: MenuBarController<DayPlannerNotchView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DayPlannerNotchView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "calendar.badge.clock",
            titleText: "Schedule (Notch)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
