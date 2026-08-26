import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PDFWhisperAIState: ObservableObject {

    @Published var pdfDocName: String = "quarterly_earnings_report.pdf"

}

struct PDFWhisperAIView: View {
    @StateObject private var state = PDFWhisperAIState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PDFWhisper AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Offline Embeddings")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            
            Text("Drop any PDF to ask questions, extract tables, and summarize key insights locally.")
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
    var menuBarController: MenuBarController<PDFWhisperAIView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PDFWhisperAIView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "doc.text.magnifyingglass",
            titleText: "PDF AI",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
