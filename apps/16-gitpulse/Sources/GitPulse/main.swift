import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class GitPulseState: ObservableObject {

    @Published var repos: [RepoStatus] = [
        RepoStatus(name: "web-storefront", branch: "main", dirtyFiles: 2, behind: 0, ahead: 1),
        RepoStatus(name: "shared-core", branch: "feature/sparkle", dirtyFiles: 0, behind: 2, ahead: 0),
        RepoStatus(name: "api-backend", branch: "master", dirtyFiles: 0, behind: 0, ahead: 0)
    ]
    struct RepoStatus: Identifiable {
        let id = UUID()
        let name: String
        let branch: String
        let dirtyFiles: Int
        let behind: Int
        let ahead: Int
    }

}

struct GitPulseView: View {
    @StateObject private var state = GitPulseState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.branch")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("GitPulse")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Multi-Repo Watcher")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 6) {
                ForEach(state.repos) { r in
                    HStack {
                        VStack(alignment: .leading, spacing: 1) {
                            Text(r.name)
                                .font(.system(size: 11, weight: .bold))
                            Text(r.branch)
                                .font(.system(size: 9, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if r.dirtyFiles > 0 {
                            Text("\(r.dirtyFiles) dirty")
                                .font(.system(size: 9, weight: .bold))
                                .padding(3)
                                .background(Color.orange.opacity(0.15))
                                .foregroundColor(.orange)
                                .cornerRadius(3)
                        } else {
                            Text("Clean")
                                .font(.system(size: 9))
                                .foregroundColor(.green)
                        }
                    }
                    .padding(6)
                    .glassCard(cornerRadius: 6)
                }
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
    var menuBarController: MenuBarController<GitPulseView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = GitPulseView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "arrow.triangle.branch",
            titleText: "Git (3)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
