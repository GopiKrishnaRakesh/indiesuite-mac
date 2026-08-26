import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class GradientMeshMakerState: ObservableObject {

    @Published var pointCount: Int = 9

}

struct GradientMeshMakerView: View {
    @StateObject private var state = GradientMeshMakerState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "circle.hexagongrid.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("GradientMesh Maker")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("3x3 Mesh")
            }
            
            Text("Interactive color anchor drag to generate complex organic fluid gradients.")
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
    var menuBarController: MenuBarController<GradientMeshMakerView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = GradientMeshMakerView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "circle.hexagongrid.fill",
            titleText: "Mesh Maker",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
