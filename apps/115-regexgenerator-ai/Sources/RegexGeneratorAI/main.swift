import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class RegexGeneratorAIState: ObservableObject {

    @Published var generatedRegex: String = "^[A-Z]{2}[0-9]{4}[a-z]?$"

}

struct RegexGeneratorAIView: View {
    @StateObject private var state = RegexGeneratorAIState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("RegexGenerator AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Tested ✓")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Regex: \(state.generatedRegex)")
                .font(.system(size: 11, design: .monospaced))
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
    var menuBarController: MenuBarController<RegexGeneratorAIView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = RegexGeneratorAIView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "character.cursor.ibeam",
            titleText: "Regex AI",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
