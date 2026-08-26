import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class EyeBlinkCoachState: ObservableObject {

    @Published var blinkIntervalSecs: Int = 15

}

struct EyeBlinkCoachView: View {
    @StateObject private var state = EyeBlinkCoachState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "eye.circle")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("EyeBlink Coach")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Every 15s")
            }
            
            Text("Prevents dry eyes and screen fatigue during intense programming and writing sessions.")
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
    var menuBarController: MenuBarController<EyeBlinkCoachView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = EyeBlinkCoachView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "eye.circle",
            titleText: "Blink Nudge",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
