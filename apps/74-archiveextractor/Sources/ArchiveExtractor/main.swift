import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ArchiveExtractorState: ObservableObject {

    @Published var autoDeleteArchive: Bool = true

}

struct ArchiveExtractorView: View {
    @StateObject private var state = ArchiveExtractorState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "archivebox.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("ArchiveExtractor")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("7z • RAR • TAR")
                    .font(.system(size: 10))
            }
            
            Toggle("Auto-delete archive after successful extraction", isOn: $state.autoDeleteArchive)
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
    var menuBarController: MenuBarController<ArchiveExtractorView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ArchiveExtractorView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "archivebox.fill",
            titleText: "Unarchiver",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
