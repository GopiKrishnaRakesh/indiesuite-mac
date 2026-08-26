import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class FocusSlothState: ObservableObject {

    @Published var branchProgress: Int = 75

}

struct FocusSlothView: View {
    @StateObject private var state = FocusSlothState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "figure.walk")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("FocusSloth")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🦥 75% Climbed")
            }
            
            Text("The sloth climbs higher along your MacBook notch the longer you avoid tab switching.")
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
    var menuBarController: MenuBarController<FocusSlothView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = FocusSlothView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "figure.walk",
            titleText: "Sloth (Notch)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
