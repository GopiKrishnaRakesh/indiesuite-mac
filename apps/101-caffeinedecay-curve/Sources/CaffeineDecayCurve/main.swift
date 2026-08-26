import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CaffeineDecayCurveState: ObservableObject {

    @Published var activeMg: Int = 85
    @Published var cutoffHour: String = "2:00 PM"

}

struct CaffeineDecayCurveView: View {
    @StateObject private var state = CaffeineDecayCurveState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("CaffeineDecay Curve")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("85mg Active")
            }
            
            Text("Based on 5.5hr half-life, caffeine will drop below sleep threshold by 10:30 PM.")
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
    var menuBarController: MenuBarController<CaffeineDecayCurveView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CaffeineDecayCurveView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "cup.and.saucer.fill",
            titleText: "Caffeine (85mg)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
