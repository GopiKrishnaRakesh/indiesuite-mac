import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class MonoSpaceFlowState: ObservableObject {

    @Published var wordCount: Int = 412
    @Published var clickSound: Bool = true

}

struct MonoSpaceFlowView: View {
    @StateObject private var state = MonoSpaceFlowState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("MonoSpace Flow")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.wordCount) Words")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Toggle("Mechanical Switch Audio Cues", isOn: $state.clickSound)
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
    var menuBarController: MenuBarController<MonoSpaceFlowView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = MonoSpaceFlowView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "character.cursor.ibeam",
            titleText: "Typewriter",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
