import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CaffeineBarState: ObservableObject {

    @Published var isAwake: Bool = true

}

struct CaffeineBarView: View {
    @StateObject private var state = CaffeineBarState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("CaffeineBar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.isAwake ? "AWAKE FOREVER ☕️" : "SYSTEM SLEEP ON")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(state.isAwake ? .green : .secondary)
            }
            
            Toggle("Prevent display and system idle sleep", isOn: $state.isAwake)
                .font(.system(size: 11))
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
    var menuBarController: MenuBarController<CaffeineBarView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CaffeineBarView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "cup.and.saucer.fill",
            titleText: "Awake (∞)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
