import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CodeCatState: ObservableObject {

    @Published var purrOnCommit: Bool = true
    @Published var meowOnBuildFail: Bool = true

}

struct CodeCatView: View {
    @StateObject private var state = CodeCatState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cat.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("CodeCat")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🐱 Code Companion")
                    .font(.system(size: 10))
            }
            
            VStack(spacing: 6) {
                Toggle("Purr on successful Git commit", isOn: $state.purrOnCommit)
                    .font(.system(size: 11))
                Toggle("Meow on test or build failure", isOn: $state.meowOnBuildFail)
                    .font(.system(size: 11))
            }
            .padding(10)
            .glassCard(cornerRadius: 10)

            
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
    var menuBarController: MenuBarController<CodeCatView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CodeCatView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "cat.fill",
            titleText: "CodeCat (Purring)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
