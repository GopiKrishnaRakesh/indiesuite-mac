import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class MemoryPurgeProState: ObservableObject {

    @Published var memoryPressure: String = "Normal (24% Used)"
    @Published var freeRAMGB: Double = 12.4

}

struct MemoryPurgeProView: View {
    @StateObject private var state = MemoryPurgeProState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "memorychip.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("MemoryPurge Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.memoryPressure)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Button("Purge Inactive RAM & Flush Caches") {}
                .buttonStyle(.plain)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(DSTheme.emeraldGradient)
                .cornerRadius(6)

            
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
    var menuBarController: MenuBarController<MemoryPurgeProView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = MemoryPurgeProView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "memorychip.fill",
            titleText: "RAM (2.1GB Free)",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
