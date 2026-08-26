import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class DuplicateFinderState: ObservableObject {

    @Published var dupesFound: Int = 38
    @Published var reclaimableMB: Double = 840.0

}

struct DuplicateFinderView: View {
    @StateObject private var state = DuplicateFinderState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.on.doc.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("DuplicateFinder")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("840 MB Duplicates")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("SHA-256 binary hash detection finds duplicate photos, downloads, and videos safely.")
                .font(.system(size: 10))
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
    var menuBarController: MenuBarController<DuplicateFinderView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = DuplicateFinderView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "doc.on.doc.fill",
            titleText: "Duplicates",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
