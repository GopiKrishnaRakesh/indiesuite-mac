import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class SVGOptimState: ObservableObject {

    @Published var totalSavings: String = "64.2%"
    @Published var rawSvgSize: String = "28.4 KB"
    @Published var optimizedSvgSize: String = "10.2 KB"

}

struct SVGOptimView: View {
    @StateObject private var state = SVGOptimState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles.square.filled.on.square")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("SVGOptim")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("-\(state.totalSavings)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(spacing: 6) {
                Image(systemName: "arrow.triangle.2.circlepath.doc.on.clipboard")
                    .font(.system(size: 24))
                    .foregroundStyle(DSTheme.roseGradient)
                Text("Drop SVG for Clean Path & SwiftUI Export")
                    .font(.system(size: 11, weight: .semibold))
                Text("Removes metadata, unused defs, and formats precision")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
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
    var menuBarController: MenuBarController<SVGOptimView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = SVGOptimView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "sparkles.square.filled.on.square",
            titleText: "SVGOptim",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
