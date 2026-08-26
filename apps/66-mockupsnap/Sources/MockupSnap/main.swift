import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class MockupSnapState: ObservableObject {

    @Published var selectedFrame: String = "MacBook Pro 16\" Space Black"

}

struct MockupSnapView: View {
    @StateObject private var state = MockupSnapState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "display")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("MockupSnap")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.selectedFrame)
                    .font(.system(size: 10))
            }
            
            Text("Drop screenshot to render instant 4K marketing device frames with reflections.")
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
    var menuBarController: MenuBarController<MockupSnapView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = MockupSnapView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "display",
            titleText: "MockupSnap",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
