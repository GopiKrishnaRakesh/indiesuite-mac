import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PlantNurseryHUDState: ObservableObject {

    @Published var plantsGrown: Int = 5

}

struct PlantNurseryHUDView: View {
    @StateObject private var state = PlantNurseryHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "leaf.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("PlantNursery HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🌵 5 Succulents")
            }
            
            Text("Complete hydration and focus intervals to unlock exotic virtual desert flora.")
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
    var menuBarController: MenuBarController<PlantNurseryHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PlantNurseryHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "leaf.circle.fill",
            titleText: "Nursery (5 Plants)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
