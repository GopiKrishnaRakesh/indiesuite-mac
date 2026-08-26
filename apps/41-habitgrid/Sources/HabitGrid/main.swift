import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class HabitGridState: ObservableObject {

    @Published var streakDays: Int = 42
    @Published var habitsTracked: Int = 4

}

struct HabitGridView: View {
    @StateObject private var state = HabitGridState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "calendar.day.timeline.left")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("HabitGrid")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.streakDays) Day Streak 🔥")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 (100% Habit Completion)")
                .font(.system(size: 11, design: .monospaced))
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
    var menuBarController: MenuBarController<HabitGridView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = HabitGridView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "calendar.day.timeline.left",
            titleText: "Habits (365d)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
