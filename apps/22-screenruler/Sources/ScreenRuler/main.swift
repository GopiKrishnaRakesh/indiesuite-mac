import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ScreenRulerState: ObservableObject {

    @Published var pixelDistance: Int = 144
    @Published var showCrosshair: Bool = true

}

struct ScreenRulerView: View {
    @StateObject private var state = ScreenRulerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "ruler.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("ScreenRuler")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.pixelDistance) px")
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                    .foregroundColor(.orange)
            }
            
            Toggle("Show Dynamic Crosshairs", isOn: $state.showCrosshair)
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)

            
            HStack {
                Text("Indie Suite Pro Ready")
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
    var menuBarController: MenuBarController<ScreenRulerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ScreenRulerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "ruler.fill",
            titleText: "Ruler",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
