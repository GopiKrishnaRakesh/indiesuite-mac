import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class MetaScrubState: ObservableObject {

    @Published var scrubbedCount: Int = 18

}

struct MetaScrubView: View {
    @StateObject private var state = MetaScrubState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "eye.slash.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("MetaScrub")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.scrubbedCount) Files Scrubbed")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(spacing: 6) {
                Image(systemName: "shield.lefthalf.filled")
                    .font(.system(size: 22))
                    .foregroundStyle(DSTheme.roseGradient)
                Text("Drag Photos or PDFs to Strip EXIF & GPS")
                    .font(.system(size: 11, weight: .semibold))
                Text("Removes camera serials, location metadata, and device tags")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .glassCard(cornerRadius: 8)

            
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
    var menuBarController: MenuBarController<MetaScrubView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = MetaScrubView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "eye.slash.circle.fill",
            titleText: "MetaScrub",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
