import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class SugarFastingTrackerState: ObservableObject {

    @Published var fastingHours: Double = 14.5
    @Published var targetHours: Double = 16.0

}

struct SugarFastingTrackerView: View {
    @StateObject private var state = SugarFastingTrackerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "timer")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("Sugar & Fasting Tracker")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Ketosis Stage")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("14.5 hrs / 16 hrs completed (Autophagy stage activated).")
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
    var menuBarController: MenuBarController<SugarFastingTrackerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = SugarFastingTrackerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "timer",
            titleText: "Fasting (14h)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
