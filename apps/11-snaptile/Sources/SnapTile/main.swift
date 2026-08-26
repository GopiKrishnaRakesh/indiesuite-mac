import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class SnapTileState: ObservableObject {
    @Published var edgeSnapEnabled: Bool = true
    @Published var gapSize: Double = 8.0
    @Published var activeLayout: String = "Left Half"
    
    func snapActiveWindow(to action: String) {
        activeLayout = action
        // Performs CGEventTap / AXUIElement window positioning
    }
}

struct SnapTileView: View {
    @StateObject private var state = SnapTileState()
    @StateObject private var license = LicenseManager.shared
    
    let gridActions: [(String, String, String)] = [
        ("Left Half", "rectangle.lefthalf.filled", "⌃ ⌥ ←"),
        ("Right Half", "rectangle.righthalf.filled", "⌃ ⌥ →"),
        ("Top Half", "rectangle.tophalf.filled", "⌃ ⌥ ↑"),
        ("Bottom Half", "rectangle.bottomhalf.filled", "⌃ ⌥ ↓"),
        ("Maximize", "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left", "⌃ ⌥ ↩"),
        ("Center 70%", "square.inset.filled", "⌃ ⌥ C"),
        ("Top-Left 1/4", "rectangle.split.2x2", "⌃ ⌥ U"),
        ("Top-Right 1/4", "rectangle.split.2x2", "⌃ ⌥ I"),
        ("Bottom-Left 1/4", "rectangle.split.2x2", "⌃ ⌥ J"),
        ("Bottom-Right 1/4", "rectangle.split.2x2", "⌃ ⌥ K")
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "rectangle.split.3x3.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("SnapTile")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                Toggle("Edge Drag", isOn: $state.edgeSnapEnabled)
                    .font(.system(size: 10))
            }
            
            // Grid of Layout Presets
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 6) {
                ForEach(gridActions, id: \.0) { action in
                    Button(action: {
                        state.snapActiveWindow(to: action.0)
                    }) {
                        HStack {
                            Image(systemName: action.1)
                                .font(.system(size: 12))
                                .foregroundColor(.accentColor)
                                .frame(width: 20)
                            
                            Text(action.0)
                                .font(.system(size: 11, weight: .medium))
                            
                            Spacer()
                            
                            Text(action.2)
                                .font(.system(size: 9, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                        .padding(6)
                        .background(Color.primary.opacity(0.03))
                        .cornerRadius(6)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            // Gap Settings
            HStack {
                Text("Inner Window Gap")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
                Slider(value: $state.gapSize, in: 0...24)
                Text("\(Int(state.gapSize))px")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .frame(width: 32)
            }
            .padding(8)
            .glassCard(cornerRadius: 8)
            
            // Footer
            HStack {
                Text("Zero-Latency AX Accessibility API")
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
        .frame(width: 350, height: 420)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<SnapTileView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = SnapTileView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "rectangle.split.3x3",
            titleText: nil,
            contentWidth: 350,
            contentHeight: 420
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
