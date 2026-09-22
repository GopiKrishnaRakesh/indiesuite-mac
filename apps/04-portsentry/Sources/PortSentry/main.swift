import SwiftUI
import AppKit
import Combine
import DesignSystem
import AppKitKit
import Licensing

struct ListeningPort: Identifiable, Equatable {
    let id: String
    let port: Int
    let processName: String
    let pid: Int32
    let user: String
}

enum PortScanner {
    /// Runs `lsof -iTCP -sTCP:LISTEN -n -P` and parses real listening TCP ports.
    static func scan() -> [ListeningPort] {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/sbin/lsof")
        process.arguments = ["-iTCP", "-sTCP:LISTEN", "-n", "-P"]

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = Pipe()

        do {
            try process.run()
        } catch {
            return []
        }
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else { return [] }

        var results: [ListeningPort] = []
        var seen = Set<String>()

        for line in output.split(separator: "\n").dropFirst() {
            let cols = line.split(separator: " ", omittingEmptySubsequences: true).map(String.init)
            guard cols.count >= 9 else { continue }
            let command = cols[0]
            guard let pid = Int32(cols[1]) else { continue }
            let user = cols[2]
            let name = cols[8] // e.g. *:5432 or 127.0.0.1:3000

            guard let colonIdx = name.lastIndex(of: ":") else { continue }
            let portString = name[name.index(after: colonIdx)...]
            guard let port = Int(portString) else { continue }

            let key = "\(pid)-\(port)"
            if seen.contains(key) { continue }
            seen.insert(key)

            results.append(ListeningPort(id: key, port: port, processName: command, pid: pid, user: user))
        }

        return results.sorted { $0.port < $1.port }
    }
}

class PortSentryState: ObservableObject {
    @Published var activePorts: [ListeningPort] = []
    @Published var searchQuery: String = ""
    @Published var lastError: String = ""

    init() {
        refresh()
    }

    func refresh() {
        let results = PortScanner.scan()
        DispatchQueue.main.async {
            self.activePorts = results
        }
    }

    func killProcess(pid: Int32) {
        let result = kill(pid, SIGTERM)
        if result == 0 {
            lastError = ""
        } else {
            lastError = String(cString: strerror(errno))
        }
        // Give the process a moment to exit, then re-scan for real state.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.refresh()
        }
    }

    func openBrowser(port: Int) {
        if let url = URL(string: "http://localhost:\(port)") {
            NSWorkspace.shared.open(url)
        }
    }
}

struct PortSentryView: View {
    @StateObject private var state = PortSentryState()
    @StateObject private var license = LicenseManager.shared
    let refreshTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    var filteredPorts: [ListeningPort] {
        if state.searchQuery.isEmpty {
            return state.activePorts
        } else {
            return state.activePorts.filter {
                "\($0.port)".contains(state.searchQuery) ||
                $0.processName.localizedCaseInsensitiveContains(state.searchQuery)
            }
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "network")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("PortSentry")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.activePorts.count) Listening")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.orange.opacity(0.15))
                    .foregroundColor(.orange)
                    .cornerRadius(4)
            }

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.system(size: 11))
                TextField("Filter port or process...", text: $state.searchQuery)
                    .textFieldStyle(.plain)
                    .font(.system(size: 11))
            }
            .padding(6)
            .glassCard(cornerRadius: 6)

            VStack(alignment: .leading, spacing: 6) {
                ScrollView {
                    VStack(spacing: 6) {
                        if filteredPorts.isEmpty {
                            Text(state.activePorts.isEmpty ? "No TCP ports currently listening" : "No matches")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                                .padding(10)
                        }
                        ForEach(filteredPorts) { item in
                            HStack {
                                Text(":\(item.port)")
                                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                                    .foregroundColor(.primary)
                                    .frame(width: 56, alignment: .leading)

                                VStack(alignment: .leading, spacing: 1) {
                                    Text(item.processName)
                                        .font(.system(size: 11, weight: .semibold))
                                        .lineLimit(1)
                                    Text("PID \(item.pid) • \(item.user)")
                                        .font(.system(size: 9, design: .monospaced))
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                Button(action: { state.openBrowser(port: item.port) }) {
                                    Image(systemName: "safari")
                                        .font(.system(size: 11))
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(.plain)
                                .help("Open in Browser")

                                Button(action: { state.killProcess(pid: item.pid) }) {
                                    HStack(spacing: 2) {
                                        Image(systemName: "xmark.circle.fill")
                                        Text("Kill")
                                    }
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(Color.red.opacity(0.85))
                                    .cornerRadius(4)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(8)
                            .background(Color.primary.opacity(0.03))
                            .cornerRadius(8)
                        }
                    }
                }
                .frame(maxHeight: 280)
            }

            HStack {
                Button("Refresh Ports") { state.refresh() }
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.accentColor)

                if !state.lastError.isEmpty {
                    Text(state.lastError)
                        .font(.system(size: 9))
                        .foregroundColor(.red)
                }

                Spacer()

                Button("Quit") { NSApp.terminate(nil) }
                    .buttonStyle(.plain)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 360, height: 440)
        .onReceive(refreshTimer) { _ in state.refresh() }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<PortSentryView>?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PortSentryView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "network",
            titleText: nil,
            contentWidth: 360,
            contentHeight: 440
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
