import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class MeetingPrepCountdownState: ObservableObject {

    @Published var upcomingCall: String = "Design Review @ 3:00 PM"

}

struct MeetingPrepCountdownView: View {
    @StateObject private var state = MeetingPrepCountdownState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bell.badge.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("MeetingPrep Countdown")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("2m Warning")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("Next: \(state.upcomingCall) (1-click auto join)")
                .font(.system(size: 11, weight: .semibold))
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
    var menuBarController: MenuBarController<MeetingPrepCountdownView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = MeetingPrepCountdownView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "bell.badge.fill",
            titleText: "Meeting (2m)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
