import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class BrainWaveSyncState: ObservableObject {

    @Published var frequency: String = "40Hz Gamma (Hyper-Focus)"

}

struct BrainWaveSyncView: View {
    @StateObject private var state = BrainWaveSyncState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("BrainWave Sync")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("40Hz Active")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.cyan)
            }
            
            Text("Scientific binaural beats proven to synchronize neural oscillations during deep problem solving.")
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
    var menuBarController: MenuBarController<BrainWaveSyncView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = BrainWaveSyncView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "waveform.path.ecg",
            titleText: "40Hz Gamma",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
