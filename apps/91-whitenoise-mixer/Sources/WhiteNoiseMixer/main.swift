import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class WhiteNoiseMixerState: ObservableObject {

    @Published var rainVol: Double = 0.8
    @Published var fireVol: Double = 0.4

}

struct WhiteNoiseMixerView: View {
    @StateObject private var state = WhiteNoiseMixerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "slider.vertical.3")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("WhiteNoise Mixer")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("4 Channels")
            }
            
            Text("Mix realistic ambient field recordings for deep coding and quiet environments.")
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
    var menuBarController: MenuBarController<WhiteNoiseMixerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = WhiteNoiseMixerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "slider.vertical.3",
            titleText: "Noise Mixer",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
