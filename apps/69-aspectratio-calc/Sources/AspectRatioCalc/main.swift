import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class AspectRatioCalcState: ObservableObject {

    @Published var ratio: String = "16:9 (1920x1080)"

}

struct AspectRatioCalcView: View {
    @StateObject private var state = AspectRatioCalcState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "aspectratio.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("AspectRatio Calc")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.ratio)
                    .font(.system(size: 10, design: .monospaced))
            }
            
            Text("Calculate Retina 2x/3x scaling, fluid font rem sizes, and video dimensions.")
                .font(.system(size: 10))
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
    var menuBarController: MenuBarController<AspectRatioCalcView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = AspectRatioCalcView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "aspectratio.fill",
            titleText: "Ratio (16:9)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
