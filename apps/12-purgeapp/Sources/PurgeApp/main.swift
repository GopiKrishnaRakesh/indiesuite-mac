import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class PurgeAppState: ObservableObject {
    @Published var selectedApp: String = "Slack.app"
    @Published var isScanning: Bool = false
    @Published var totalReclaimableMB: Double = 1248.5
    
    @Published var appResiduals: [ResidualItem] = [
        ResidualItem(path: "/Applications/Slack.app", size: "284 MB", category: "Application Bundle", isChecked: true),
        ResidualItem(path: "~/Library/Application Support/Slack", size: "640 MB", category: "App Support & Data", isChecked: true),
        ResidualItem(path: "~/Library/Caches/com.tinyspeck.slackmacgap", size: "312 MB", category: "Caches", isChecked: true),
        ResidualItem(path: "~/Library/Preferences/com.tinyspeck.slackmacgap.plist", size: "12 KB", category: "Preferences", isChecked: true),
        ResidualItem(path: "~/Library/Saved Application State/com.tinyspeck.slackmacgap.savedState", size: "12.4 MB", category: "State", isChecked: true)
    ]
    
    struct ResidualItem: Identifiable {
        let id = UUID()
        let path: String
        let size: String
        let category: String
        var isChecked: Bool
    }
    
    func purgeSelected() {
        appResiduals.removeAll { $0.isChecked }
        totalReclaimableMB = 0.0
    }
}

struct PurgeAppView: View {
    @StateObject private var state = PurgeAppState()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "trash.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("PurgeApp")
                        .font(.system(size: 15, weight: .bold))
                }
                
                Spacer()
                
                Text(String(format: "%.1f MB Residue", state.totalReclaimableMB))
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.red.opacity(0.15))
                    .foregroundColor(.red)
                    .cornerRadius(4)
            }
            
            // Drop target
            VStack(spacing: 6) {
                Image(systemName: "square.and.arrow.down.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(DSTheme.roseGradient)
                Text("Drop any .app here for Deep Uninstall")
                    .font(.system(size: 11, weight: .semibold))
                Text("Finds hidden plists, caches, daemon agents & containers")
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
            
            // Files to purge
            VStack(alignment: .leading, spacing: 4) {
                Text("Associated Files for \(state.selectedApp)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.secondary)
                
                ScrollView {
                    VStack(spacing: 4) {
                        ForEach($state.appResiduals) { $item in
                            HStack {
                                Toggle("", isOn: $item.isChecked)
                                    .labelsHidden()
                                
                                VStack(alignment: .leading, spacing: 1) {
                                    Text(item.category)
                                        .font(.system(size: 10, weight: .semibold))
                                    Text(item.path)
                                        .font(.system(size: 9, design: .monospaced))
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                                
                                Spacer()
                                
                                Text(item.size)
                                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                            }
                            .padding(6)
                            .background(Color.primary.opacity(0.03))
                            .cornerRadius(6)
                        }
                    }
                }
                .frame(maxHeight: 180)
            }
            
            // Action Button
            Button(action: {
                state.purgeSelected()
            }) {
                HStack {
                    Image(systemName: "trash.fill")
                    Text("Deep Purge & Move to Trash")
                }
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(state.totalReclaimableMB > 0 ? Color.red.opacity(0.9) : Color.gray.opacity(0.5))
                .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .disabled(state.totalReclaimableMB == 0)
            
            // Footer
            HStack {
                Text("Safe Trash Recovery Enabled")
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
        .frame(width: 350, height: 450)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarController: MenuBarController<PurgeAppView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = PurgeAppView()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "trash.circle",
            titleText: "PurgeApp",
            contentWidth: 350,
            contentHeight: 450
        )
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
