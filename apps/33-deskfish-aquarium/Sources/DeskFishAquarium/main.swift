import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DeskFishAquariumState: ObservableObject {

    @Published var fishCount: Int = 3
    @Published var tankCleanliness: Int = 98

}

struct DeskFishAquariumView: View {
    @StateObject private var state = DeskFishAquariumState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "drop.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("DeskFish Aquarium")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🐠 🐡 🐟")
            }
            
            Text("Translucent floating desk aquarium. Keeps swimming as you maintain your workflow habits.")
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
    var menuBarController: MenuBarController<DeskFishAquariumView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DeskFishAquariumView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "drop.circle.fill",
            titleText: "Aquarium (3 Fish)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
