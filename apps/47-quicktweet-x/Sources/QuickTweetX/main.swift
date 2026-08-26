import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class QuickTweetXState: ObservableObject {

    @Published var tweetDraft: String = "Shipping 50 more native macOS apps today! 🚀 #buildinpublic"

}

struct QuickTweetXView: View {
    @StateObject private var state = QuickTweetXState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("QuickTweet / Post Hub")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌥ X")
            }
            
            TextEditor(text: $state.tweetDraft)
                .font(.system(size: 11))
                .frame(height: 70)
                .padding(4)
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
    var menuBarController: MenuBarController<QuickTweetXView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = QuickTweetXView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "paperplane.fill",
            titleText: "Post Hub",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
