import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class BreakReminderState: ObservableObject {

    @Published var nextBreakMins: Int = 14
    @Published var breaksCompletedToday: Int = 8

}

struct BreakReminderView: View {
    @StateObject private var state = BreakReminderState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "eye.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("BreakReminder 20-20-20")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Next in \(state.nextBreakMins)m")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Look at an object 20 feet away for 20 seconds every 20 minutes to eliminate eye fatigue.")
                .font(.system(size: 10))
                .foregroundColor(.secondary)
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
    var menuBarController: MenuBarController<BreakReminderView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = BreakReminderView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "eye.fill",
            titleText: "20-20-20 (14m)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
