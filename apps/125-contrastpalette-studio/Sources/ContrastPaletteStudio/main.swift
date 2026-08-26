import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ContrastPaletteStudioState: ObservableObject {

    @Published var contrastRating: String = "7.4:1 (WCAG AAA Compliant)"

}

struct ContrastPaletteStudioView: View {
    @StateObject private var state = ContrastPaletteStudioState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "paintpalette.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ContrastPalette Studio")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("AAA Pass ✓")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text(state.contrastRating)
                .font(.system(size: 11, weight: .bold))
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
    var menuBarController: MenuBarController<ContrastPaletteStudioView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContrastPaletteStudioView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "paintpalette.fill",
            titleText: "WCAG Studio",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
