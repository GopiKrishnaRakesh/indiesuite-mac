import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PresenterCamState: ObservableObject {

    @Published var shape: String = "Circle"
    @Published var blurBackground: Bool = true
    @Published var spotlightPointer: Bool = true

}

struct PresenterCamView: View {
    @StateObject private var state = PresenterCamState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "camera.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("PresenterCam")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌘ ⇧ P")
            }
            
            VStack(spacing: 8) {
                Toggle("Virtual Background Blur", isOn: $state.blurBackground)
                    .font(.system(size: 11))
                Toggle("Spotlight Pointer Tracking", isOn: $state.spotlightPointer)
                    .font(.system(size: 11))
            }
            .padding(10)
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
    var menuBarController: MenuBarController<PresenterCamView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PresenterCamView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "camera.circle.fill",
            titleText: "PresenterCam",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
