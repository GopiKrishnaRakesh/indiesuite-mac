import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class ApiMockServerState: ObservableObject {

    @Published var mockEndpoint: String = "http://localhost:4000/api/users"

}

struct ApiMockServerView: View {
    @StateObject private var state = ApiMockServerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "server.rack")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ApiMock Server")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Listening :4000")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text("Simulate 200 OK, 401 Unauthorized, 500 Server Error with 200ms latency.")
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
    var menuBarController: MenuBarController<ApiMockServerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ApiMockServerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "server.rack",
            titleText: "Mock Server",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
