import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class AppHopState: ObservableObject {

    @Published var activeAppWindows: [String] = ["Xcode - ContentView.swift", "Xcode - Project Settings", "Xcode - Debugger"]

}

struct AppHopView: View {
    @StateObject private var state = AppHopState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("AppHop")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌥ `")
            }
            
            VStack(spacing: 4) {
                ForEach(Array(state.activeAppWindows.enumerated()), id: \.offset) { idx, win in
                    HStack {
                        Text("\(idx + 1)")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(.secondary)
                        Text(win)
                            .font(.system(size: 11))
                        Spacer()
                    }
                    .padding(6)
                    .glassCard(cornerRadius: 6)
                }
            }

            
            HStack {
                Text("Indie Suite Pro Ready")
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
    var menuBarController: MenuBarController<AppHopView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = AppHopView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "arrow.triangle.2.circlepath",
            titleText: "AppHop",
            contentWidth: 340,
            contentHeight: 360
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
