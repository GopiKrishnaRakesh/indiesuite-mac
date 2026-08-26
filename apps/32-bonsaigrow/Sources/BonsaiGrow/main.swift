import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class BonsaiGrowState: ObservableObject {

    @Published var treeAgeDays: Int = 18
    @Published var leafCount: Int = 142
    @Published var healthPercentage: Int = 96

}

struct BonsaiGrowView: View {
    @StateObject private var state = BonsaiGrowState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("BonsaiGrow")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Day \(state.treeAgeDays)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(spacing: 6) {
                Text("🪴")
                    .font(.system(size: 42))
                Text("Juniper Zen Bonsai")
                    .font(.system(size: 12, weight: .bold))
                Text("\(state.leafCount) healthy leaves grown across 36 deep-work sessions")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
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
    var menuBarController: MenuBarController<BonsaiGrowView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = BonsaiGrowView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "leaf.fill",
            titleText: "Bonsai (Lush)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
