import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class LocalEmbeddingsSearchState: ObservableObject {

    @Published var indexedDocs: Int = 1420

}

struct LocalEmbeddingsSearchView: View {
    @StateObject private var state = LocalEmbeddingsSearchState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("LocalEmbeddings Search")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1,420 Vectors")
            }
            
            Text("Find code snippets and markdown notes by concept meaning rather than exact keywords.")
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
    var menuBarController: MenuBarController<LocalEmbeddingsSearchView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = LocalEmbeddingsSearchView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "magnifyingglass.circle.fill",
            titleText: "Vector Search",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
