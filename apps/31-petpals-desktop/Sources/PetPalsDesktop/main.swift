import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PetPalsDesktopState: ObservableObject {

    @Published var petName: String = "Mochi"
    @Published var petMood: String = "Joyful & Energetic"
    @Published var hungerLevel: Int = 85
    @Published var focusStreakMins: Int = 45
    @Published var petAction: String = "Walking along Xcode title bar"

}

struct PetPalsDesktopView: View {
    @StateObject private var state = PetPalsDesktopState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("PetPals Desktop")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Lv. 4 Companion")
                    .font(.system(size: 10, weight: .bold))
                    .padding(4)
                    .background(Color.orange.opacity(0.15))
                    .cornerRadius(4)
            }
            
            VStack(spacing: 8) {
                HStack {
                    Text("🐱")
                        .font(.system(size: 36))
                    VStack(alignment: .leading, spacing: 2) {
                        Text(state.petName)
                            .font(.system(size: 13, weight: .bold))
                        Text(state.petMood)
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button("Feed Fish 🐟") {
                        state.hungerLevel = min(100, state.hungerLevel + 10)
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .semibold))
                    .padding(6)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(6)
                }
                
                HStack(spacing: 8) {
                    MetricBadge(title: "Hydration Nudge", value: "Every 45m", icon: "drop.fill", tint: .blue)
                    MetricBadge(title: "Focus Time", value: "\(state.focusStreakMins)m", icon: "timer", tint: .green)
                }
            }
            .padding(10)
            .glassCard(cornerRadius: 10)

            
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
    var menuBarController: MenuBarController<PetPalsDesktopView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PetPalsDesktopView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "pawprint.fill",
            titleText: "PetPal (Happy)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
