import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class FocusHeatmapState: ObservableObject {

    @Published var topApp: String = "Xcode (4.2 hrs)"

}

struct FocusHeatmapView: View {
    @StateObject private var state = FocusHeatmapState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("FocusHeatmap")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.topApp)
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text("Visual breakdown of keyboard and mouse activity across development, browser, and chat apps.")
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
    var menuBarController: MenuBarController<FocusHeatmapView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = FocusHeatmapView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "flame.fill",
            titleText: "Heatmap",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
