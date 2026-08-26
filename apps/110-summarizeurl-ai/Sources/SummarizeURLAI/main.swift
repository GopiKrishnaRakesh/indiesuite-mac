import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class SummarizeURLAIState: ObservableObject {

    @Published var takeaways: String = "1. Native architecture • 2. Zero tax • 3. 130 apps"

}

struct SummarizeURLAIView: View {
    @StateObject private var state = SummarizeURLAIState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.plaintext.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("SummarizeURL AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("3 Takeaways")
            }
            
            Text(state.takeaways)
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
    var menuBarController: MenuBarController<SummarizeURLAIView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = SummarizeURLAIView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "doc.plaintext.fill",
            titleText: "Summary AI",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
