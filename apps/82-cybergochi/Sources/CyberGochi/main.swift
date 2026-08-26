import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CyberGochiState: ObservableObject {

    @Published var gochiLevel: Int = 3
    @Published var hunger: Int = 80

}

struct CyberGochiView: View {
    @StateObject private var state = CyberGochiState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "gamecontroller.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("CyberGochi")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("👾 Cyber Pet")
            }
            
            Text("Check off tasks in Reminders or Linear to feed and evolve your CyberGochi.")
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
    var menuBarController: MenuBarController<CyberGochiView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CyberGochiView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "gamecontroller.fill",
            titleText: "Gochi (Lv. 3)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
