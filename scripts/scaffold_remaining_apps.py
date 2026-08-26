#!/usr/bin/env python3
import os

apps_metadata = [
    {
        "dir": "15-devtunnel-hud",
        "name": "DevTunnelHUD",
        "icon": "point.3.connected.trianglepath.dotted",
        "desc": "DevTunnel HUD",
        "title": "Tunnels (2)",
        "gradient": "DSTheme.cyanGradient",
        "state_vars": """
    @Published var activeTunnels: [TunnelInfo] = [
        TunnelInfo(provider: "Cloudflare", localPort: 3000, publicUrl: "https://indie-preview.trycloudflare.com", status: "Online", requests: 142),
        TunnelInfo(provider: "Ngrok", localPort: 8000, publicUrl: "https://9b41-2a02.ngrok-free.app", status: "Online", requests: 38)
    ]
    struct TunnelInfo: Identifiable {
        let id = UUID()
        let provider: String
        let localPort: Int
        let publicUrl: String
        let status: String
        let requests: Int
    }
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "point.3.connected.trianglepath.dotted")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("DevTunnel HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("2 Tunnels Active")
                    .font(.system(size: 10, weight: .bold))
                    .padding(4)
                    .background(Color.cyan.opacity(0.15))
                    .cornerRadius(4)
            }
            
            VStack(spacing: 8) {
                ForEach(state.activeTunnels) { t in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(t.provider)
                                .font(.system(size: 11, weight: .bold))
                            Spacer()
                            Text(":\(t.localPort)")
                                .font(.system(size: 10, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                        Text(t.publicUrl)
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundColor(.blue)
                    }
                    .padding(8)
                    .glassCard(cornerRadius: 8)
                }
            }
"""
    },
    {
        "dir": "16-gitpulse",
        "name": "GitPulse",
        "icon": "arrow.triangle.branch",
        "desc": "GitPulse",
        "title": "Git (3)",
        "gradient": "DSTheme.amberGradient",
        "state_vars": """
    @Published var repos: [RepoStatus] = [
        RepoStatus(name: "web-storefront", branch: "main", dirtyFiles: 2, behind: 0, ahead: 1),
        RepoStatus(name: "shared-core", branch: "feature/sparkle", dirtyFiles: 0, behind: 2, ahead: 0),
        RepoStatus(name: "api-backend", branch: "master", dirtyFiles: 0, behind: 0, ahead: 0)
    ]
    struct RepoStatus: Identifiable {
        let id = UUID()
        let name: String
        let branch: String
        let dirtyFiles: Int
        let behind: Int
        let ahead: Int
    }
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.branch")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("GitPulse")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Multi-Repo Watcher")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 6) {
                ForEach(state.repos) { r in
                    HStack {
                        VStack(alignment: .leading, spacing: 1) {
                            Text(r.name)
                                .font(.system(size: 11, weight: .bold))
                            Text(r.branch)
                                .font(.system(size: 9, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if r.dirtyFiles > 0 {
                            Text("\(r.dirtyFiles) dirty")
                                .font(.system(size: 9, weight: .bold))
                                .padding(3)
                                .background(Color.orange.opacity(0.15))
                                .foregroundColor(.orange)
                                .cornerRadius(3)
                        } else {
                            Text("Clean")
                                .font(.system(size: 9))
                                .foregroundColor(.green)
                        }
                    }
                    .padding(6)
                    .glassCard(cornerRadius: 6)
                }
            }
"""
    },
    {
        "dir": "17-regexforge",
        "name": "RegexForge",
        "icon": "character.cursor.ibeam",
        "desc": "RegexForge",
        "title": "RegexForge",
        "gradient": "DSTheme.primaryGradient",
        "state_vars": """
    @Published var pattern: String = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\\\.[a-zA-Z]{2,}"
    @Published var testInput: String = "Contact team at support@indiesuite.app or founder@macsuite.io"
    @Published var matchCount: Int = 2
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("RegexForge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.matchCount) Matches")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Pattern")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                TextField("Regex", text: $state.pattern)
                    .textFieldStyle(.plain)
                    .font(.system(size: 11, design: .monospaced))
                    .padding(6)
                    .glassCard(cornerRadius: 6)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Test String")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                TextEditor(text: $state.testInput)
                    .font(.system(size: 10, design: .monospaced))
                    .frame(height: 80)
                    .padding(4)
                    .glassCard(cornerRadius: 6)
            }
"""
    },
    {
        "dir": "18-svgoptim",
        "name": "SVGOptim",
        "icon": "sparkles.square.filled.on.square",
        "desc": "SVGOptim",
        "title": "SVGOptim",
        "gradient": "DSTheme.roseGradient",
        "state_vars": """
    @Published var totalSavings: String = "64.2%"
    @Published var rawSvgSize: String = "28.4 KB"
    @Published var optimizedSvgSize: String = "10.2 KB"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles.square.filled.on.square")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("SVGOptim")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("-\(state.totalSavings)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(spacing: 6) {
                Image(systemName: "arrow.triangle.2.circlepath.doc.on.clipboard")
                    .font(.system(size: 24))
                    .foregroundStyle(DSTheme.roseGradient)
                Text("Drop SVG for Clean Path & SwiftUI Export")
                    .font(.system(size: 11, weight: .semibold))
                Text("Removes metadata, unused defs, and formats precision")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "19-fontinspect",
        "name": "FontInspect",
        "icon": "textformat",
        "desc": "FontInspect",
        "title": "FontInspect",
        "gradient": "DSTheme.primaryGradient",
        "state_vars": """
    @Published var sampleText: String = "The quick brown fox jumps over the lazy dog"
    @Published var fontSize: Double = 16.0
    @Published var selectedFont: String = "SF Pro Display"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "textformat")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("FontInspect")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.selectedFont)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            Text(state.sampleText)
                .font(.system(size: CGFloat(state.fontSize), design: .rounded))
                .padding(10)
                .frame(maxWidth: .infinity, minHeight: 60)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "20-presentercam",
        "name": "PresenterCam",
        "icon": "camera.circle.fill",
        "desc": "PresenterCam",
        "title": "PresenterCam",
        "gradient": "DSTheme.emeraldGradient",
        "state_vars": """
    @Published var shape: String = "Circle"
    @Published var blurBackground: Bool = true
    @Published var spotlightPointer: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "camera.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("PresenterCam")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌘ ⇧ P")
            }
            
            VStack(spacing: 8) {
                Toggle("Virtual Background Blur", isOn: $state.blurBackground)
                    .font(.system(size: 11))
                Toggle("Spotlight Pointer Tracking", isOn: $state.spotlightPointer)
                    .font(.system(size: 11))
            }
            .padding(10)
            .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "21-cleandesk-pro",
        "name": "CleanDeskPro",
        "icon": "sparkles",
        "desc": "CleanDesk Pro",
        "title": "CleanDesk",
        "gradient": "DSTheme.cyanGradient",
        "state_vars": """
    @Published var hideDesktopIcons: Bool = true
    @Published var muteNotifications: Bool = true
    @Published var presentationWallpaper: Bool = false
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("CleanDesk Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1-Click Presentation")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 8) {
                Toggle("Hide all Desktop icons", isOn: $state.hideDesktopIcons)
                    .font(.system(size: 11))
                Toggle("Do Not Disturb (Silence alerts)", isOn: $state.muteNotifications)
                    .font(.system(size: 11))
            }
            .padding(10)
            .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "22-screenruler",
        "name": "ScreenRuler",
        "icon": "ruler.fill",
        "desc": "ScreenRuler",
        "title": "Ruler",
        "gradient": "DSTheme.amberGradient",
        "state_vars": """
    @Published var pixelDistance: Int = 144
    @Published var showCrosshair: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "ruler.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("ScreenRuler")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.pixelDistance) px")
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                    .foregroundColor(.orange)
            }
            
            Toggle("Show Dynamic Crosshairs", isOn: $state.showCrosshair)
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "23-apphop",
        "name": "AppHop",
        "icon": "arrow.triangle.2.circlepath",
        "desc": "AppHop",
        "title": "AppHop",
        "gradient": "DSTheme.primaryGradient",
        "state_vars": """
    @Published var activeAppWindows: [String] = ["Xcode - ContentView.swift", "Xcode - Project Settings", "Xcode - Debugger"]
""",
        "body_content": """
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
                ForEach(Array(state.activeAppWindows.enumerated()), id: \\.offset) { idx, win in
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
"""
    },
    {
        "dir": "24-scratchpad-hud",
        "name": "ScratchPadHUD",
        "icon": "note.text",
        "desc": "ScratchPad HUD",
        "title": "Notes",
        "gradient": "DSTheme.emeraldGradient",
        "state_vars": """
    @Published var noteContent: String = "## Daily Sprint Notes\\n- Deploy 30 macOS Apps via Website\\n- Setup LemonSqueezy Checkout Webhook\\n- Test Sparkle auto-updater appcasts"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "note.text")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ScratchPad HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌥ N")
            }
            
            TextEditor(text: $state.noteContent)
                .font(.system(size: 11, design: .monospaced))
                .frame(height: 140)
                .padding(4)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "25-timebridge",
        "name": "TimeBridge",
        "icon": "clock.badge.checkmark.fill",
        "desc": "TimeBridge",
        "title": "Timezones",
        "gradient": "DSTheme.cyanGradient",
        "state_vars": """
    @Published var zones: [ZoneTime] = [
        ZoneTime(city: "San Francisco", code: "PST", time: "16:30", diff: "-8h"),
        ZoneTime(city: "London", code: "GMT", time: "00:30", diff: "0h"),
        ZoneTime(city: "Tokyo", code: "JST", time: "09:30", diff: "+9h")
    ]
    struct ZoneTime: Identifiable {
        let id = UUID()
        let city: String
        let code: String
        let time: String
        let diff: String
    }
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "clock.badge.checkmark.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("TimeBridge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Meeting Overlap Finder")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 4) {
                ForEach(state.zones) { z in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(z.city)
                                .font(.system(size: 11, weight: .bold))
                            Text(z.code)
                                .font(.system(size: 9))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text(z.time)
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                        Text(z.diff)
                            .font(.system(size: 9, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                    .padding(6)
                    .glassCard(cornerRadius: 6)
                }
            }
"""
    },
    {
        "dir": "26-menucleaner",
        "name": "MenuCleaner",
        "icon": "chevron.left.2",
        "desc": "MenuCleaner",
        "title": "<|",
        "gradient": "DSTheme.primaryGradient",
        "state_vars": """
    @Published var isHidden: Bool = false
    @Published var autoHideSeconds: Int = 10
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left.2")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("MenuCleaner")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Menu Bar Organizer")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            Toggle("Collapse Inactive Icons Behind Divider", isOn: $state.isHidden)
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "27-metascrub",
        "name": "MetaScrub",
        "icon": "eye.slash.circle.fill",
        "desc": "MetaScrub",
        "title": "MetaScrub",
        "gradient": "DSTheme.roseGradient",
        "state_vars": """
    @Published var scrubbedCount: Int = 18
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "eye.slash.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("MetaScrub")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.scrubbedCount) Files Scrubbed")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(spacing: 6) {
                Image(systemName: "shield.lefthalf.filled")
                    .font(.system(size: 22))
                    .foregroundStyle(DSTheme.roseGradient)
                Text("Drag Photos or PDFs to Strip EXIF & GPS")
                    .font(.system(size: 11, weight: .semibold))
                Text("Removes camera serials, location metadata, and device tags")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "28-bandwidthradar",
        "name": "BandwidthRadar",
        "icon": "antenna.radiowaves.left.and.right",
        "desc": "BandwidthRadar",
        "title": "↓ 2.4 MB/s",
        "gradient": "DSTheme.emeraldGradient",
        "state_vars": """
    @Published var downSpeed: String = "2.4 MB/s"
    @Published var upSpeed: String = "480 KB/s"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("BandwidthRadar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Live Monitor")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 8) {
                MetricBadge(title: "Download", value: state.downSpeed, icon: "arrow.down", tint: .green)
                MetricBadge(title: "Upload", value: state.upSpeed, icon: "arrow.up", tint: .blue)
            }
"""
    },
    {
        "dir": "29-bluetoothautohop",
        "name": "BluetoothAutoHop",
        "icon": "headphones",
        "desc": "BluetoothAutoHop",
        "title": "AirPods (85%)",
        "gradient": "DSTheme.cyanGradient",
        "state_vars": """
    @Published var connectedDevice: String = "AirPods Pro (2nd Gen)"
    @Published var batteryLevel: Int = 85
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "headphones")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("BluetoothAutoHop")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.batteryLevel)%")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(state.connectedDevice)
                    .font(.system(size: 12, weight: .bold))
                Text("Auto-disconnect on system sleep • Auto-reconnect on wake")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            .padding(8)
            .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "30-privatellm-bar",
        "name": "PrivateLLMBar",
        "icon": "brain.head.profile",
        "desc": "PrivateLLM Bar",
        "title": "LocalAI",
        "gradient": "DSTheme.primaryGradient",
        "state_vars": """
    @Published var selectedModel: String = "Llama-3.2-3B-Instruct (MLX 4-bit)"
    @Published var promptInput: String = "Summarize this log file:"
    @Published var responseOutput: String = "Offline Apple Silicon MLX inference ready. 100% private, 0 cloud dependency."
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PrivateLLM Bar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("100% Offline")
                    .font(.system(size: 9, weight: .bold))
                    .padding(3)
                    .background(Color.purple.opacity(0.15))
                    .foregroundColor(.purple)
                    .cornerRadius(3)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Prompt")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                TextField("Prompt", text: $state.promptInput)
                    .textFieldStyle(.plain)
                    .font(.system(size: 11))
                    .padding(6)
                    .glassCard(cornerRadius: 6)
            }
            
            Text(state.responseOutput)
                .font(.system(size: 10, design: .rounded))
                .foregroundColor(.secondary)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassCard(cornerRadius: 8)
"""
    }
]

for app in apps_metadata:
    app_dir = f"apps/{app['dir']}"
    src_dir = f"{app_dir}/Sources/{app['name']}"
    os.makedirs(src_dir, exist_ok=True)
    
    # Write Package.swift
    pkg_content = f"""// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "{app['name']}",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "{app['name']}", targets: ["{app['name']}"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "{app['name']}",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/{app['name']}"
        )
    ]
)
"""
    with open(f"{app_dir}/Package.swift", "w") as f:
        f.write(pkg_content)
        
    # Write main.swift
    main_content = f"""import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class {app['name']}State: ObservableObject {{
{app['state_vars']}
}}

struct {app['name']}View: View {{
    @StateObject private var state = {app['name']}State()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {{
        VStack(spacing: 12) {{
{app['body_content']}
            
            HStack {{
                Text("Indie Suite Pro Ready")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                Spacer()
                Button("Quit") {{
                    NSApp.terminate(nil)
                }}
                .buttonStyle(.plain)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
            }}
        }}
        .padding(14)
        .frame(width: 340, height: 360)
    }}
}}

class AppDelegate: NSObject, NSApplicationDelegate {{
    var menuBarController: MenuBarController<{app['name']}View>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {{
        let contentView = {app['name']}View()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "{app['icon']}",
            titleText: "{app['title']}",
            contentWidth: 340,
            contentHeight: 360
        )
    }}
}}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
"""
    with open(f"{src_dir}/main.swift", "w") as f:
        f.write(main_content)

print("Scaffolded all remaining 16 apps successfully!")
