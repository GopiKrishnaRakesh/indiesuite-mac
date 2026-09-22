import SwiftUI
import AppKit
import Carbon
import UniformTypeIdentifiers
import DesignSystem
import AppKitKit
import Licensing

struct ShelfItem: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String
    let icon: NSImage
    let fileURL: URL?
}

class NotchShelfState: ObservableObject {
    @Published var items: [ShelfItem] = []
    @Published var isTargeted: Bool = false

    func removeItem(id: UUID) {
        items.removeAll { $0.id == id }
    }

    func clearShelf() {
        items.removeAll()
    }

    /// Real drop handling — accepts files, images and plain text/links dropped from Finder or a browser.
    func handleDrop(providers: [NSItemProvider]) -> Bool {
        var handled = false
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
                handled = true
                provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { [weak self] item, _ in
                    guard let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) else { return }
                    let icon = NSWorkspace.shared.icon(forFile: url.path)
                    let size = (try? FileManager.default.attributesOfItem(atPath: url.path)[.size] as? Int64) ?? 0
                    DispatchQueue.main.async {
                        self?.items.insert(ShelfItem(name: url.lastPathComponent, subtitle: Self.formatSize(size), icon: icon, fileURL: url), at: 0)
                    }
                }
            } else if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                handled = true
                provider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { [weak self] item, _ in
                    guard let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) else { return }
                    DispatchQueue.main.async {
                        self?.items.insert(ShelfItem(name: url.absoluteString, subtitle: "Link", icon: NSWorkspace.shared.icon(for: .url), fileURL: nil), at: 0)
                    }
                }
            } else if provider.hasItemConformingToTypeIdentifier(UTType.plainText.identifier) {
                handled = true
                provider.loadItem(forTypeIdentifier: UTType.plainText.identifier, options: nil) { [weak self] item, _ in
                    var text: String?
                    if let data = item as? Data { text = String(data: data, encoding: .utf8) }
                    else if let str = item as? String { text = str }
                    guard let text, !text.isEmpty else { return }
                    DispatchQueue.main.async {
                        self?.items.insert(ShelfItem(name: String(text.prefix(40)), subtitle: "Text snippet", icon: NSWorkspace.shared.icon(for: .plainText), fileURL: nil), at: 0)
                    }
                }
            }
        }
        return handled
    }

    static func formatSize(_ bytes: Int64) -> String {
        if bytes > 1_000_000 { return String(format: "%.1f MB", Double(bytes) / 1_000_000) }
        if bytes > 1_000 { return String(format: "%.0f KB", Double(bytes) / 1_000) }
        return "\(bytes) B"
    }
}

struct NotchShelfView: View {
    @ObservedObject var state: NotchShelfState
    @StateObject private var license = LicenseManager.shared

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle().fill(Color.primary.opacity(0.3)).frame(width: 6, height: 6)
                Text("NotchShelf Drop Zone").font(.system(size: 11, weight: .bold))
                Spacer()
                Text("\(state.items.count) Staged Items").font(.system(size: 10)).foregroundColor(.secondary)
            }

            VStack(spacing: 6) {
                Image(systemName: state.isTargeted ? "tray.and.arrow.down.fill" : "tray.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(DSTheme.primaryGradient)
                Text("Drag files, links or text here to stage")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(state.isTargeted ? Color.accentColor.opacity(0.08) : Color.primary.opacity(0.02))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [4]))
                    .foregroundColor(state.isTargeted ? Color.accentColor : Color.primary.opacity(0.15))
            )
            .cornerRadius(8)
            .onDrop(of: [.fileURL, .url, .plainText], isTargeted: $state.isTargeted) { providers in
                state.handleDrop(providers: providers)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(state.items) { item in
                        VStack(spacing: 4) {
                            HStack {
                                Spacer()
                                Button(action: { state.removeItem(id: item.id) }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 10))
                                        .foregroundColor(.secondary)
                                }
                                .buttonStyle(.plain)
                            }
                            Image(nsImage: item.icon)
                                .resizable()
                                .frame(width: 26, height: 26)
                            Text(item.name)
                                .font(.system(size: 10, weight: .medium))
                                .lineLimit(1)
                                .frame(width: 80)
                            Text(item.subtitle)
                                .font(.system(size: 8, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                        .padding(8)
                        .glassCard(cornerRadius: 8)
                        .onTapGesture {
                            if let url = item.fileURL {
                                NSWorkspace.shared.activateFileViewerSelecting([url])
                            }
                        }
                        .onDrag {
                            if let url = item.fileURL {
                                return NSItemProvider(object: url as NSURL)
                            }
                            return NSItemProvider(object: item.name as NSString)
                        }
                    }
                }
                .padding(.vertical, 4)
            }

            HStack {
                Button("Clear Shelf") { state.clearShelf() }
                    .buttonStyle(.plain)
                    .font(.system(size: 10))
                    .foregroundColor(.red)
                Spacer()
                Button("Quit") { NSApp.terminate(nil) }
                    .buttonStyle(.plain)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .frame(width: 360, height: 260)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var panel: FloatingHUDWindow<NotchShelfView>?
    let state = NotchShelfState()

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem?.button {
            let image = NSImage(systemSymbolName: "tray.full", accessibilityDescription: "NotchShelf")
            image?.isTemplate = true
            button.image = image
            button.target = self
            button.action = #selector(togglePanel)
        }

        panel = FloatingHUDWindow(contentView: NotchShelfView(state: state), size: CGSize(width: 360, height: 260))
        positionNearNotch()

        _ = GlobalHotkeyManager.shared.registerHotkey(keyCode: 45, modifiers: UInt32(optionKey | shiftKey)) { [weak self] in // ⌥⇧N
            self?.togglePanel()
        }
    }

    private func positionNearNotch() {
        guard let panel, let screen = NSScreen.main else { return }
        let screenFrame = screen.frame
        let x = screenFrame.midX - panel.frame.width / 2
        let y = screenFrame.maxY - panel.frame.height - 6
        panel.setFrameOrigin(NSPoint(x: x, y: y))
    }

    @objc func togglePanel() {
        panel?.toggleHUD()
        if panel?.isVisible == true {
            positionNearNotch()
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
