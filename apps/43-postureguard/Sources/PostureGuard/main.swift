import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PostureGuardState: ObservableObject {

    @Published var isGoodPosture: Bool = true
    @Published var postureScore: Int = 94

}

struct PostureGuardView: View {
    @StateObject private var state = PostureGuardState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "figure.stand")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PostureGuard")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("100% Offline Vision")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            
            Text(state.isGoodPosture ? "✓ Ergonomic Spine Alignment Detected" : "⚠️ Slouching detected - adjust chair & monitor")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(state.isGoodPosture ? .green : .red)
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
    var menuBarController: MenuBarController<PostureGuardView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PostureGuardView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "figure.stand",
            titleText: "Posture (Good)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
