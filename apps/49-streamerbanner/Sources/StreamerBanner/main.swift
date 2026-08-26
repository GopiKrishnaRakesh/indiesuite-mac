import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class StreamerBannerState: ObservableObject {

    @Published var bannerText: String = "@IndieDev • Shipping 80 Native macOS Apps"

}

struct StreamerBannerView: View {
    @StateObject private var state = StreamerBannerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles.tv.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("StreamerBanner")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Overlay Active")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text(state.bannerText)
                .font(.system(size: 11, weight: .bold))
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
    var menuBarController: MenuBarController<StreamerBannerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = StreamerBannerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "sparkles.tv.fill",
            titleText: "Banner",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
