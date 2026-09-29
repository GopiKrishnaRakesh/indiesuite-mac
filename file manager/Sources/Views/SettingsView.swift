import SwiftUI

/// Standard macOS Settings dialog (Cmd+,).
/// Adheres strictly to macOS Human Interface Guidelines (HIG) with tabbed navigation and native controls.
struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralSettingsTab()
                .tabItem {
                    Label("General", systemImage: "gearshape")
                }
                .tag(0)

            AppearanceSettingsTab()
                .tabItem {
                    Label("Appearance", systemImage: "macwindow")
                }
                .tag(1)

            AdvancedSettingsTab()
                .tabItem {
                    Label("Advanced", systemImage: "slider.horizontal.3")
                }
                .tag(2)
        }
        .padding(20)
        .frame(width: 480, height: 320)
    }
}

struct GeneralSettingsTab: View {
    @AppStorage("restoreLastOpenedFolder") private var restoreLastOpenedFolder = true
    @AppStorage("foldersFirst") private var foldersFirst = true
    @AppStorage("calculateFolderSizes") private var calculateFolderSizes = true
    @AppStorage("showHidden") private var showHidden = false

    var body: some View {
        Form {
            Section {
                Toggle("Restore last active folder on launch", isOn: $restoreLastOpenedFolder)
                Toggle("Keep folders on top when sorting", isOn: $foldersFirst)
                Toggle("Calculate folder sizes in list view", isOn: $calculateFolderSizes)
                Toggle("Show hidden files and dotfiles", isOn: $showHidden)
            } header: {
                Text("File Browsing")
            }
        }
        .formStyle(.grouped)
    }
}

struct AppearanceSettingsTab: View {
    @AppStorage("viewMode") private var viewModeRaw = "details"
    @AppStorage("showPathBar") private var showPathBar = true
    @AppStorage("showPreview") private var showPreview = false
    @AppStorage("iconSize") private var iconSize = 64.0

    var body: some View {
        Form {
            Section {
                Picker("Default view:", selection: $viewModeRaw) {
                    Text("Details (Table)").tag("details")
                    Text("Icons").tag("icons")
                    Text("Tiles").tag("tiles")
                    Text("Columns").tag("columns")
                }

                Slider(value: $iconSize, in: 32...128, step: 16) {
                    Text("Icon size: \(Int(iconSize))px")
                }

                Toggle("Show bottom Path Bar", isOn: $showPathBar)
                Toggle("Show right Preview & Inspector Pane", isOn: $showPreview)
            } header: {
                Text("Layout & Views")
            }
        }
        .formStyle(.grouped)
    }
}

struct AdvancedSettingsTab: View {
    @State private var cliInstalled = false
    @State private var fdaGranted = false

    var body: some View {
        Form {
            Section {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Terminal Command (pathway)")
                            .font(.body)
                        Text("Launch Pathway from terminal: pathway /path/to/folder")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button("Install Tool") {
                        AppInstallHelper.installCommandLineTool()
                    }
                }

                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Full Disk Access")
                            .font(.body)
                        Text("Bypass individual folder permission prompts")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button("Open Settings…") {
                        PermissionManager.shared.openFullDiskAccessSettings()
                    }
                }

                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Move to Applications")
                            .font(.body)
                        Text(AppInstallHelper.isRunningFromApplications ? "Running from /Applications" : "Currently running outside Applications")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if !AppInstallHelper.isRunningFromApplications {
                        Button("Move Now") {
                            AppInstallHelper.moveToApplications()
                        }
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }
                }
            } header: {
                Text("System Integration")
            }
        }
        .formStyle(.grouped)
    }
}
