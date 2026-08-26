import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class MicroJournalBarState: ObservableObject {

    @Published var todayEntry: String = "Shipped 130 native macOS apps suite! Feeling great."

}

struct MicroJournalBarView: View {
    @StateObject private var state = MicroJournalBarState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("MicroJournal Bar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1-Line Log")
            }
            
            Text(state.todayEntry)
                .font(.system(size: 11))
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
    var menuBarController: MenuBarController<MicroJournalBarView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = MicroJournalBarView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "square.and.pencil",
            titleText: "Journal",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
