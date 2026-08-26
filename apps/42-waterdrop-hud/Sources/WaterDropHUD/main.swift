import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class WaterDropHUDState: ObservableObject {

    @Published var currentLiters: Double = 1.8
    @Published var targetLiters: Double = 2.5

}

struct WaterDropHUDView: View {
    @StateObject private var state = WaterDropHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("WaterDrop HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("72% Goal")
                    .font(.system(size: 10, weight: .bold))
            }
            
            HStack {
                Button("+250ml Glass 💧") { state.currentLiters += 0.25 }
                    .buttonStyle(.plain)
                    .font(.system(size: 11, weight: .bold))
                    .padding(8)
                    .background(Color.cyan.opacity(0.2))
                    .cornerRadius(6)
                Spacer()
                Text(String(format: "%.1fL / %.1fL", state.currentLiters, state.targetLiters))
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
            }
            .padding(6)
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
    var menuBarController: MenuBarController<WaterDropHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = WaterDropHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "drop.fill",
            titleText: "1.8L / 2.5L",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
