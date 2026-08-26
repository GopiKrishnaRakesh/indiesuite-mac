import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class AudioRecordHUDState: ObservableObject {

    @Published var isRecording: Bool = false

}

struct AudioRecordHUDView: View {
    @StateObject private var state = AudioRecordHUDState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "record.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("AudioRecord HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.isRecording ? "RECORDING..." : "STANDBY")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Button(action: { state.isRecording.toggle() }) {
                HStack {
                    Image(systemName: state.isRecording ? "stop.fill" : "record.circle")
                    Text(state.isRecording ? "Stop & Save MP3" : "Record Internal Audio + Mic")
                }
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(state.isRecording ? Color.red : Color.accentColor)
                .cornerRadius(6)
            }
            .buttonStyle(.plain)

            
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
    var menuBarController: MenuBarController<AudioRecordHUDView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = AudioRecordHUDView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "record.circle.fill",
            titleText: "Rec Audio",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
