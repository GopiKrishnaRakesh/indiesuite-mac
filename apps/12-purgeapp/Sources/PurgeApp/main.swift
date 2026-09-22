import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing
import UniformTypeIdentifiers

struct ResidualItem: Identifiable {
    let id = UUID()
    let url: URL
    let displaySize: String
    let sizeBytes: Int64
    let category: String
    var isChecked: Bool
}

enum ResidualScanner {
    /// Real disk usage via `du -sk`, in kilobytes.
    static func sizeInBytes(of url: URL) -> Int64 {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/du")
        process.arguments = ["-sk", url.path]
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = Pipe()
        do { try process.run() } catch { return 0 }
        process.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8),
              let firstField = output.split(separator: "\t").first,
              let kb = Int64(firstField.trimmingCharacters(in: .whitespaces)) else { return 0 }
        return kb * 1024
    }

    static func formatSize(_ bytes: Int64) -> String {
        if bytes > 1_000_000_000 { return String(format: "%.2f GB", Double(bytes) / 1_000_000_000) }
        if bytes > 1_000_000 { return String(format: "%.1f MB", Double(bytes) / 1_000_000) }
        if bytes > 1_000 { return String(format: "%.0f KB", Double(bytes) / 1_000) }
        return "\(bytes) B"
    }

    /// Scans the real, standard leftover locations macOS apps write to.
    static func scan(appURL: URL) -> [ResidualItem] {
        let fm = FileManager.default
        let home = fm.homeDirectoryForCurrentUser
        let bundle = Bundle(url: appURL)
        let bundleID = bundle?.bundleIdentifier ?? ""
        let appName = appURL.deletingPathExtension().lastPathComponent

        guard !bundleID.isEmpty else { return [] }

        var candidates: [(URL, String)] = [
            (appURL, "Application Bundle"),
            (home.appendingPathComponent("Library/Application Support/\(appName)"), "App Support & Data"),
            (home.appendingPathComponent("Library/Caches/\(bundleID)"), "Caches"),
            (home.appendingPathComponent("Library/Preferences/\(bundleID).plist"), "Preferences"),
            (home.appendingPathComponent("Library/Saved Application State/\(bundleID).savedState"), "Saved State"),
            (home.appendingPathComponent("Library/Logs/\(appName)"), "Logs"),
            (home.appendingPathComponent("Library/HTTPStorages/\(bundleID)"), "HTTP Storage"),
            (home.appendingPathComponent("Library/WebKit/\(bundleID)"), "WebKit Data"),
            (home.appendingPathComponent("Library/Containers/\(bundleID)"), "Sandbox Container"),
        ]

        // LaunchAgents matching the bundle id (globbed, since filenames vary).
        let launchAgentsDir = home.appendingPathComponent("Library/LaunchAgents")
        if let items = try? fm.contentsOfDirectory(at: launchAgentsDir, includingPropertiesForKeys: nil) {
            for item in items where item.lastPathComponent.contains(bundleID) {
                candidates.append((item, "Launch Agent"))
            }
        }

        var results: [ResidualItem] = []
        for (url, category) in candidates {
            guard fm.fileExists(atPath: url.path) else { continue }
            let bytes = sizeInBytes(of: url)
            results.append(ResidualItem(url: url, displaySize: formatSize(bytes), sizeBytes: bytes, category: category, isChecked: true))
        }
        return results
    }
}

class PurgeAppState: ObservableObject {
    @Published var selectedAppURL: URL?
    @Published var selectedAppName: String = "No app selected"
    @Published var isScanning: Bool = false
    @Published var residuals: [ResidualItem] = []
    @Published var statusMessage: String = ""

    var totalReclaimableBytes: Int64 {
        residuals.filter { $0.isChecked }.reduce(0) { $0 + $1.sizeBytes }
    }

    func pickApp() {
        let panel = NSOpenPanel()
        panel.directoryURL = URL(fileURLWithPath: "/Applications")
        panel.allowedContentTypes = [UTType.application]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        if panel.runModal() == .OK, let url = panel.url {
            selectedAppURL = url
            selectedAppName = url.deletingPathExtension().lastPathComponent
            rescan()
        }
    }

    func rescan() {
        guard let url = selectedAppURL else { return }
        isScanning = true
        statusMessage = ""
        DispatchQueue.global(qos: .userInitiated).async {
            let found = ResidualScanner.scan(appURL: url)
            DispatchQueue.main.async {
                self.residuals = found
                self.isScanning = false
            }
        }
    }

    func purgeSelected() {
        let fm = FileManager.default
        var failed = 0
        for item in residuals where item.isChecked {
            do {
                try fm.trashItem(at: item.url, resultingItemURL: nil)
            } catch {
                failed += 1
            }
        }
        statusMessage = failed == 0 ? "Moved \(residuals.filter { $0.isChecked }.count) items to Trash" : "\(failed) item(s) could not be trashed"
        residuals.removeAll { $0.isChecked }
    }
}

struct PurgeAppView: View {
    @StateObject private var state = PurgeAppState()
    @StateObject private var license = LicenseManager.shared

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "trash.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("PurgeApp")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(ResidualScanner.formatSize(state.totalReclaimableBytes) + " Found")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.red.opacity(0.15))
                    .foregroundColor(.red)
                    .cornerRadius(4)
            }

            Button(action: { state.pickApp() }) {
                VStack(spacing: 6) {
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text(state.selectedAppURL == nil ? "Choose an app for Deep Uninstall" : state.selectedAppName)
                        .font(.system(size: 11, weight: .semibold))
                    Text("Finds real caches, plists, saved state & containers")
                        .font(.system(size: 9))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.primary.opacity(0.02))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [4]))
                        .foregroundColor(Color.primary.opacity(0.15))
                )
                .cornerRadius(8)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text("Found Files")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)

                ScrollView {
                    VStack(spacing: 4) {
                        if state.isScanning {
                            Text("Scanning disk...")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                                .padding(10)
                        } else if state.residuals.isEmpty {
                            Text(state.selectedAppURL == nil ? "Pick an app above to scan" : "No leftover files found")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                                .padding(10)
                        }
                        ForEach($state.residuals) { $item in
                            HStack {
                                Toggle("", isOn: $item.isChecked).labelsHidden()
                                VStack(alignment: .leading, spacing: 1) {
                                    Text(item.category)
                                        .font(.system(size: 10, weight: .semibold))
                                    Text(item.url.path.replacingOccurrences(of: NSHomeDirectory(), with: "~"))
                                        .font(.system(size: 9, design: .monospaced))
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                                Spacer()
                                Text(item.displaySize)
                                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                            }
                            .padding(6)
                            .background(Color.primary.opacity(0.03))
                            .cornerRadius(6)
                        }
                    }
                }
                .frame(maxHeight: 170)
            }

            Button(action: { state.purgeSelected() }) {
                HStack {
                    Image(systemName: "trash.fill")
                    Text("Move Selected to Trash")
                }
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(state.totalReclaimableBytes > 0 ? Color.red.opacity(0.9) : Color.gray.opacity(0.5))
                .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .disabled(state.totalReclaimableBytes == 0)

            HStack {
                Text(state.statusMessage.isEmpty ? "Trash is recoverable — nothing is deleted permanently" : state.statusMessage)
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Spacer()
                Button("Quit") { NSApp.terminate(nil) }
                    .buttonStyle(.plain)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 360, height: 480)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<PurgeAppView>?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PurgeAppView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "trash.circle",
            titleText: nil,
            contentWidth: 360,
            contentHeight: 480
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
