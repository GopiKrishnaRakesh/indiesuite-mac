import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ScreenDimmerFocusState: ObservableObject {

    @Published var dimOpacity: Double = 0.65
    @Published var blurBackground: Bool = true

}

struct ScreenDimmerFocusView: View {
    @StateObject private var state = ScreenDimmerFocusState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sun.min.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("ScreenDimmer Focus")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(Int(state.dimOpacity * 100))% Dim")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Slider(value: $state.dimOpacity, in: 0.2...0.9)
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
    var menuBarController: MenuBarController<ScreenDimmerFocusView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ScreenDimmerFocusView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "sun.min.fill",
            titleText: "Dimmer",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
