import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class GitCommitAIState: ObservableObject {

    @Published var generatedCommit: String = "feat(core): add 50 new apps across focus, routine, pets & AI"

}

struct GitCommitAIView: View {
    @StateObject private var state = GitCommitAIState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.branch")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("GitCommit AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Diff Parsed")
                    .font(.system(size: 10))
            }
            
            Text(state.generatedCommit)
                .font(.system(size: 11, design: .monospaced))
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
    var menuBarController: MenuBarController<GitCommitAIView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = GitCommitAIView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "arrow.triangle.branch",
            titleText: "Commit AI",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
