import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class RegexForgeState: ObservableObject {

    @Published var pattern: String = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
    @Published var testInput: String = "Contact team at support@indiesuite.app or founder@macsuite.io"
    @Published var matchCount: Int = 2

}

struct RegexForgeView: View {
    @StateObject private var state = RegexForgeState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("RegexForge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.matchCount) Matches")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Pattern")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                TextField("Regex", text: $state.pattern)
                    .textFieldStyle(.plain)
                    .font(.system(size: 11, design: .monospaced))
                    .padding(6)
                    .glassCard(cornerRadius: 6)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Test String")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                TextEditor(text: $state.testInput)
                    .font(.system(size: 10, design: .monospaced))
                    .frame(height: 80)
                    .padding(4)
                    .glassCard(cornerRadius: 6)
            }

            
            HStack {
                Text("Indie Suite Pro Ready")
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
    var menuBarController: MenuBarController<RegexForgeView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = RegexForgeView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "character.cursor.ibeam",
            titleText: "RegexForge",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
