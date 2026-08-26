import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class CurlCraftState: ObservableObject {

    @Published var targetLang: String = "Swift (URLSession)"

}

struct CurlCraftView: View {
    @StateObject private var state = CurlCraftState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bolt.horizontal.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("CurlCraft")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.targetLang)
                    .font(.system(size: 10))
            }
            
            Text("Paste any cURL command to generate typesafe Swift URLSession / Python requests code.")
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
    var menuBarController: MenuBarController<CurlCraftView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = CurlCraftView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "bolt.horizontal.fill",
            titleText: "CurlCraft",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
