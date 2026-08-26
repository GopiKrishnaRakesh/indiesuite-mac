import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PomodoroDragonState: ObservableObject {

    @Published var dragonLevel: Int = 6
    @Published var pomodorosCompleted: Int = 24
    @Published var currentStreak: Int = 5

}

struct PomodoroDragonView: View {
    @StateObject private var state = PomodoroDragonState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "flame.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("PomodoroDragon")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🔥 Ignis Dragon")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            HStack(spacing: 8) {
                MetricBadge(title: "Pomodoros", value: "\(state.pomodorosCompleted)", icon: "timer", tint: .red)
                MetricBadge(title: "Dragon Level", value: "Lv. \(state.dragonLevel)", icon: "sparkles", tint: .orange)
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
    var menuBarController: MenuBarController<PomodoroDragonView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PomodoroDragonView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "flame.circle.fill",
            titleText: "Dragon (Lv. 6)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
