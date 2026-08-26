import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class FontInspectState: ObservableObject {

    @Published var sampleText: String = "The quick brown fox jumps over the lazy dog"
    @Published var fontSize: Double = 16.0
    @Published var selectedFont: String = "SF Pro Display"

}

struct FontInspectView: View {
    @StateObject private var state = FontInspectState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "textformat")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("FontInspect")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.selectedFont)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            Text(state.sampleText)
                .font(.system(size: CGFloat(state.fontSize), design: .rounded))
                .padding(10)
                .frame(maxWidth: .infinity, minHeight: 60)
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
    var menuBarController: MenuBarController<FontInspectView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = FontInspectView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "textformat",
            titleText: "FontInspect",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
