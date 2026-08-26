import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class EnvVaultState: ObservableObject {
    @Published var activeProject: String = "SaaS Platform (Prod)"
    @Published var isMasked: Bool = true
    
    @Published var envVariables: [EnvEntry] = [
        EnvEntry(key: "DATABASE_URL", value: "postgresql://postgres:secret_pass@aws.rds.com:5432/main", isSecret: true),
        EnvEntry(key: "STRIPE_SECRET_KEY", value: "sk_live_51NABC1234567890XYZ", isSecret: true),
        EnvEntry(key: "NEXT_PUBLIC_APP_URL", value: "https://indiesuite.app", isSecret: false),
        EnvEntry(key: "ANTHROPIC_API_KEY", value: "sk-ant-api03-abcdef123456", isSecret: true)
    ]
    
    struct EnvEntry: Identifiable {
        let id = UUID()
        let key: String
        let value: String
        let isSecret: Bool
    }
    
    func copyEnvToClipboard() {
        let formatted = envVariables.map { "\($0.key)=\($0.value)" }.joined(separator: "\n")
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(formatted, forType: .string)
    }
}

struct EnvVaultView: View {
    @StateObject private var state = EnvVaultState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("EnvVault")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                Button(action: {
                    state.isMasked.toggle()
                }) {
                    Image(systemName: state.isMasked ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
                .help("Toggle Mask Secrets")
            }
            
            // Project Selector & Quick Actions
            HStack {
                Text(state.activeProject)
                    .font(.system(size: 12, weight: .bold))
                Spacer()
                Button("Copy .env") {
                    state.copyEnvToClipboard()
                }
                .buttonStyle(.plain)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(DSTheme.amberGradient)
                .cornerRadius(4)
            }
            .padding(8)
            .glassCard(cornerRadius: 8)
            
            // Env Variables List
            ScrollView {
                VStack(spacing: 6) {
                    ForEach(state.envVariables) { entry in
                        HStack {
                            Text(entry.key)
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(.accentColor)
                                .frame(width: 130, alignment: .leading)
                            
                            Text(state.isMasked && entry.isSecret ? "••••••••••••••••••••" : entry.value)
                                .font(.system(size: 10, design: .monospaced))
                                .lineLimit(1)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Button(action: {
                                NSPasteboard.general.clearContents()
                                NSPasteboard.general.setString(entry.value, forType: .string)
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .font(.system(size: 10))
                                    .foregroundColor(.secondary)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(6)
                        .background(Color.primary.opacity(0.03))
                        .cornerRadius(6)
                    }
                }
            }
            .frame(maxHeight: 220)
            
            // Footer
            HStack {
                Text("Zero-Leak Git Guard Active")
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
        .frame(width: 350, height: 380)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<EnvVaultView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = EnvVaultView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "lock.shield",
            titleText: "EnvVault",
            contentWidth: 350,
            contentHeight: 380
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
