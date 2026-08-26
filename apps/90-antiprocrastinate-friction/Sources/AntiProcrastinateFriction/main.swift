import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class AntiProcrastinateFrictionState: ObservableObject {

    @Published var frictionSeconds: Int = 10

}

struct AntiProcrastinateFrictionView: View {
    @StateObject private var state = AntiProcrastinateFrictionState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "hourglass")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("AntiProcrastinate Friction")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("10s Delay")
            }
            
            Text("Forces mindful pauses before social media tabs load, breaking subconscious dopamine loops.")
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
    var menuBarController: MenuBarController<AntiProcrastinateFrictionView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = AntiProcrastinateFrictionView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "hourglass",
            titleText: "Friction Gate",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
