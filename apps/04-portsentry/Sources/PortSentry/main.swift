import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PortSentryState: ObservableObject {
    @Published var activePorts: [ListeningPort] = [
        ListeningPort(port: 3000, processName: "node (Next.js)", pid: 48219, memory: "184 MB", isFavorite: true),
        ListeningPort(port: 8000, processName: "uvicorn (FastAPI)", pid: 51042, memory: "78 MB", isFavorite: true),
        ListeningPort(port: 5432, processName: "postgres", pid: 1042, memory: "45 MB", isFavorite: false),
        ListeningPort(port: 8080, processName: "java (Spring Boot)", pid: 63891, memory: "340 MB", isFavorite: false),
        ListeningPort(port: 27017, processName: "mongod", pid: 1420, memory: "92 MB", isFavorite: false)
    ]
    
    @Published var searchQuery: String = ""
    
    struct ListeningPort: Identifiable {
        let id = UUID()
        let port: Int
        let processName: String
        let pid: Int
        let memory: String
        var isFavorite: Bool
    }
    
    func killProcess(pid: Int) {
        activePorts.removeAll { $0.pid == pid }
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
    
    var filteredPorts: [PortSentryState.ListeningPort] {
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
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "network")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("PortSentry")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                Text("\(state.activePorts.count) Active Ports")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.orange.opacity(0.15))
                    .foregroundColor(.orange)
                    .cornerRadius(4)
            }
            
            // Search / Filter
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
            
            // Port List
            VStack(alignment: .leading, spacing: 6) {
                ScrollView {
                    VStack(spacing: 6) {
                        ForEach(filteredPorts) { item in
                            HStack {
                                Text(":\(item.port)")
                                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                                    .foregroundColor(.primary)
                                    .frame(width: 52, alignment: .leading)
                                
                                VStack(alignment: .leading, spacing: 1) {
                                    Text(item.processName)
                                        .font(.system(size: 11, weight: .semibold))
                                        .lineLimit(1)
                                    Text("PID \(item.pid) • \(item.memory)")
                                        .font(.system(size: 9, design: .monospaced))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    state.openBrowser(port: item.port)
                                }) {
                                    Image(systemName: "safari")
                                        .font(.system(size: 11))
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(.plain)
                                .help("Open in Browser")
                                
                                Button(action: {
                                    state.killProcess(pid: item.pid)
                                }) {
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
            
            // Footer
            HStack {
                Button("Refresh Ports") {}
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.accentColor)
                
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
        .frame(width: 350, height: 440)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<PortSentryView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PortSentryView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "network",
            titleText: "Ports (5)",
            contentWidth: 350,
            contentHeight: 440
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
