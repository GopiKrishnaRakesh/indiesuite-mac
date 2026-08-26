import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class IconGridOverlayState: ObservableObject {

    @Published var gridType: String = "macOS Squircle (1024x1024)"

}

struct IconGridOverlayView: View {
    @StateObject private var state = IconGridOverlayState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "square.grid.3x3.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("IconGrid Overlay")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.gridType)
                    .font(.system(size: 9))
            }
            
            Text("Superimposes official Apple HIG squircle curvature and safe zone padding.")
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
    var menuBarController: MenuBarController<IconGridOverlayView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = IconGridOverlayView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "square.grid.3x3.fill",
            titleText: "Icon Grid",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
