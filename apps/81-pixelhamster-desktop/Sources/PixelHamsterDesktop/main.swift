import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PixelHamsterDesktopState: ObservableObject {

    @Published var wheelSpeedRpm: Int = 120
    @Published var totalDistanceKm: Double = 4.2

}

struct PixelHamsterDesktopView: View {
    @StateObject private var state = PixelHamsterDesktopState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "circle.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("PixelHamster Desktop")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🐹 120 RPM")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("Runs faster as your typing speed and compilation activity increases.")
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
    var menuBarController: MenuBarController<PixelHamsterDesktopView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PixelHamsterDesktopView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "circle.circle.fill",
            titleText: "Hamster (Running)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
