import SwiftUI
import AppKit
import Carbon
import DesignSystem
import AppKitKit
import Licensing

/// Real window tiling via the macOS Accessibility (AX) API.
enum WindowTiler {
    static func isTrusted(prompt: Bool) -> Bool {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: prompt]
        return AXIsProcessTrustedWithOptions(options)
    }

    static func openAccessibilitySettings() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
            NSWorkspace.shared.open(url)
        }
    }

    /// Returns the AXUIElement for the focused window of the frontmost app (excluding this app itself).
    private static func frontmostWindow() -> AXUIElement? {
        guard let frontApp = NSWorkspace.shared.frontmostApplication,
              frontApp.processIdentifier != ProcessInfo.processInfo.processIdentifier else {
            return nil
        }
        let appElement = AXUIElementCreateApplication(frontApp.processIdentifier)
        var windowRef: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(appElement, kAXFocusedWindowAttribute as CFString, &windowRef)
        guard result == .success, let window = windowRef else { return nil }
        return (window as! AXUIElement)
    }

    @discardableResult
    static func apply(rect: CGRect) -> Bool {
        guard let window = frontmostWindow() else { return false }

        var position = rect.origin
        var size = rect.size

        guard let positionValue = AXValueCreate(.cgPoint, &position),
              let sizeValue = AXValueCreate(.cgSize, &size) else { return false }

        AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, positionValue)
        AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString, sizeValue)
        return true
    }

    /// Computes the target rect for a named layout on the screen under the mouse (falls back to main screen).
    static func rect(for layout: String, gap: CGFloat) -> CGRect? {
        let screen = NSScreen.screens.first { NSMouseInRect(NSEvent.mouseLocation, $0.frame, false) } ?? NSScreen.main
        guard let visible = screen?.visibleFrame else { return nil }

        let half = CGRect(x: visible.minX, y: visible.minY, width: visible.width / 2, height: visible.height)
        let quarter = CGSize(width: visible.width / 2, height: visible.height / 2)

        var rect: CGRect
        switch layout {
        case "Left Half": rect = CGRect(x: visible.minX, y: visible.minY, width: visible.width / 2, height: visible.height)
        case "Right Half": rect = CGRect(x: visible.midX, y: visible.minY, width: visible.width / 2, height: visible.height)
        case "Top Half": rect = CGRect(x: visible.minX, y: visible.midY, width: visible.width, height: visible.height / 2)
        case "Bottom Half": rect = CGRect(x: visible.minX, y: visible.minY, width: visible.width, height: visible.height / 2)
        case "Maximize": rect = visible
        case "Center 70%":
            let w = visible.width * 0.7, h = visible.height * 0.7
            rect = CGRect(x: visible.midX - w / 2, y: visible.midY - h / 2, width: w, height: h)
        case "Top-Left 1/4": rect = CGRect(x: visible.minX, y: visible.midY, width: quarter.width, height: quarter.height)
        case "Top-Right 1/4": rect = CGRect(x: visible.midX, y: visible.midY, width: quarter.width, height: quarter.height)
        case "Bottom-Left 1/4": rect = CGRect(x: visible.minX, y: visible.minY, width: quarter.width, height: quarter.height)
        case "Bottom-Right 1/4": rect = CGRect(x: visible.midX, y: visible.minY, width: quarter.width, height: quarter.height)
        default: rect = half
        }

        // Apply an inner gap without pushing the window off-screen.
        if gap > 0 {
            rect = rect.insetBy(dx: gap / 2, dy: gap / 2)
        }
        // AX coordinates are top-left origin; NSScreen frames are bottom-left origin. Flip Y.
        let screenHeight = screen?.frame.height ?? visible.height
        let flippedY = screenHeight - rect.origin.y - rect.height
        return CGRect(x: rect.origin.x, y: flippedY, width: rect.width, height: rect.height)
    }
}

class SnapTileState: ObservableObject {
    @Published var gapSize: Double = 8.0
    @Published var activeLayout: String = ""
    @Published var accessibilityGranted: Bool = WindowTiler.isTrusted(prompt: false)
    @Published var lastResult: String = ""

    func refreshPermission() {
        accessibilityGranted = WindowTiler.isTrusted(prompt: false)
    }

    func snapActiveWindow(to layout: String) {
        guard accessibilityGranted else {
            lastResult = "Accessibility permission required"
            _ = WindowTiler.isTrusted(prompt: true)
            return
        }
        guard let rect = WindowTiler.rect(for: layout, gap: gapSize) else {
            lastResult = "No screen found"
            return
        }
        activeLayout = layout
        let ok = WindowTiler.apply(rect: rect)
        lastResult = ok ? "Snapped to \(layout)" : "No focused window to tile"
    }
}

struct SnapTileView: View {
    @StateObject private var state = SnapTileState()
    @StateObject private var license = LicenseManager.shared

    let gridActions: [(String, String, String)] = [
        ("Left Half", "rectangle.lefthalf.filled", "⌃⌥←"),
        ("Right Half", "rectangle.righthalf.filled", "⌃⌥→"),
        ("Top Half", "rectangle.tophalf.filled", "⌃⌥↑"),
        ("Bottom Half", "rectangle.bottomhalf.filled", "⌃⌥↓"),
        ("Maximize", "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left", "⌃⌥↩"),
        ("Center 70%", "square.inset.filled", "⌃⌥C"),
        ("Top-Left 1/4", "rectangle.split.2x2", "⌃⌥U"),
        ("Top-Right 1/4", "rectangle.split.2x2", "⌃⌥I"),
        ("Bottom-Left 1/4", "rectangle.split.2x2", "⌃⌥J"),
        ("Bottom-Right 1/4", "rectangle.split.2x2", "⌃⌥K")
    ]

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "rectangle.split.3x3.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("SnapTile").font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Circle()
                    .fill(state.accessibilityGranted ? Color.green : Color.orange)
                    .frame(width: 8, height: 8)
            }

            if !state.accessibilityGranted {
                Button(action: {
                    _ = WindowTiler.isTrusted(prompt: true)
                    WindowTiler.openAccessibilitySettings()
                }) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.orange)
                        Text("Grant Accessibility access to tile windows")
                            .font(.system(size: 10, weight: .semibold))
                        Spacer()
                        Text("Fix").font(.system(size: 10, weight: .bold)).foregroundColor(.accentColor)
                    }
                    .padding(8)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
                .onAppear { state.refreshPermission() }
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 6) {
                ForEach(gridActions, id: \.0) { action in
                    Button(action: { state.snapActiveWindow(to: action.0) }) {
                        HStack {
                            Image(systemName: action.1)
                                .font(.system(size: 12))
                                .foregroundColor(.accentColor)
                                .frame(width: 20)
                            Text(action.0).font(.system(size: 11, weight: .medium))
                            Spacer()
                            Text(action.2).font(.system(size: 9, design: .monospaced)).foregroundColor(.secondary)
                        }
                        .padding(6)
                        .background(Color.primary.opacity(0.03))
                        .cornerRadius(6)
                    }
                    .buttonStyle(.plain)
                }
            }

            HStack {
                Text("Inner Window Gap").font(.system(size: 10)).foregroundColor(.secondary)
                Slider(value: $state.gapSize, in: 0...24)
                Text("\(Int(state.gapSize))px").font(.system(size: 10, weight: .bold, design: .monospaced)).frame(width: 32)
            }
            .padding(8)
            .glassCard(cornerRadius: 8)

            HStack {
                Text(state.lastResult.isEmpty ? "AXUIElement window positioning" : state.lastResult)
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                Spacer()
                Button("Quit") { NSApp.terminate(nil) }
                    .buttonStyle(.plain)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 360, height: 440)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<SnapTileView>?
    let sharedState = SnapTileState()

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = SnapTileView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "rectangle.split.3x3",
            titleText: nil,
            contentWidth: 360,
            contentHeight: 440
        )

        registerHotkeys()
    }

    private func registerHotkeys() {
        let mgr = GlobalHotkeyManager.shared
        let ctrlOpt = UInt32(controlKey | optionKey)
        _ = mgr.registerHotkey(keyCode: UInt32(kVK_LeftArrow), modifiers: ctrlOpt) { WindowTiler.apply(rect: WindowTiler.rect(for: "Left Half", gap: 8) ?? .zero) }
        _ = mgr.registerHotkey(keyCode: UInt32(kVK_RightArrow), modifiers: ctrlOpt) { WindowTiler.apply(rect: WindowTiler.rect(for: "Right Half", gap: 8) ?? .zero) }
        _ = mgr.registerHotkey(keyCode: UInt32(kVK_UpArrow), modifiers: ctrlOpt) { WindowTiler.apply(rect: WindowTiler.rect(for: "Top Half", gap: 8) ?? .zero) }
        _ = mgr.registerHotkey(keyCode: UInt32(kVK_DownArrow), modifiers: ctrlOpt) { WindowTiler.apply(rect: WindowTiler.rect(for: "Bottom Half", gap: 8) ?? .zero) }
        _ = mgr.registerHotkey(keyCode: UInt32(kVK_Return), modifiers: ctrlOpt) { WindowTiler.apply(rect: WindowTiler.rect(for: "Maximize", gap: 0) ?? .zero) }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
