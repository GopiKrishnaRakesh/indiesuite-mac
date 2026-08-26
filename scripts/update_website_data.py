#!/usr/bin/env python3
import json
import os

all_formatted_apps = [
    {
        "id": "01-whispertap",
        "slug": "whispertap",
        "name": "WhisperTap",
        "cat": "AI & Voice",
        "price": "$19",
        "priceNum": 19,
        "hotkey": "\u2325 Space",
        "desc": "Global push-to-talk AI dictation into any text field via Apple Silicon MLX WhisperKit.",
        "pitch": "Stop typing repetitive emails, docs, and Slack messages. WhisperTap brings local OpenAI Whisper dictation to every single text input on macOS with zero latency, zero cloud API fees, and 100% offline privacy.",
        "use_cases": [
            "Dictate long architectural RFCs, GitHub PR descriptions, and Notion documents 4x faster than typing.",
            "Reply to Slack threads and customer emails in seconds with instant automatic clipboard pasting.",
            "Private dictation in HIPAA, SOC2, and confidential enterprise environments where cloud audio streaming is prohibited."
        ],
        "how_it_works": "Registers a global Carbon Hotkey (\u2325 Space). On press, AVFoundation captures 16kHz mono audio into a ring buffer. On release, audio is processed through a local WhisperKit CoreML model running on the Apple Silicon Neural Engine (ANE). The resulting transcript is formatted and pasted directly into the active app using CGEventPost.",
        "features": [
            "100% Offline CoreML / Apple Silicon Neural Engine inference",
            "Auto-paste into focused app text fields",
            "Dev Mode: Formats camelCase, snake_case, and markdown",
            "Custom vocabulary booster for jargon and acronyms",
            "Zero cloud API fees or audio telemetry"
        ]
    },
    {
        "id": "02-tokenwatch",
        "slug": "tokenwatch",
        "name": "TokenWatch",
        "cat": "AI & Dev",
        "price": "$16",
        "priceNum": 16,
        "hotkey": "Menu Bar",
        "desc": "Menu bar real-time LLM API spend & rate-limit monitor for OpenAI, Anthropic, Gemini & Groq.",
        "pitch": "Never get surprised by a $500 monthly OpenAI or Anthropic bill again. TokenWatch sits right in your menu bar, tracking your real-time API spend, token consumption rates, and rate limit ceilings across every LLM provider.",
        "use_cases": [
            "Monitor live cost spikes when running automated AI agent loops, batch embedding jobs, or LangChain pipelines.",
            "Track multiple client API keys with separate budget thresholds and automatic emergency cutoff alerts.",
            "Audit cost-per-prompt efficiency across GPT-4o, Claude 3.5 Sonnet, Gemini 1.5 Pro, and Groq."
        ],
        "how_it_works": "Runs an async background polling daemon using URLSession that securely queries usage endpoints for OpenAI, Anthropic, Google Gemini, Groq, and OpenRouter every 60 seconds using keys stored in macOS Keychain. Computes delta velocity ($/minute and tokens/sec). If usage velocity breaches a user-defined threshold, it triggers an NSUserNotification and updates the NSStatusItem title with a flashing warning badge.",
        "features": [
            "Live status bar cost ticker (e.g. '$12.45 today \u2022 42k t/m')",
            "Multi-provider aggregation: OpenAI, Anthropic, Gemini, Groq, OpenRouter",
            "Custom budget alarms with sound notifications",
            "Per-project API key grouping and monthly exportable CSV reports",
            "Keychain-encrypted local key storage"
        ]
    },
    {
        "id": "03-locallens-ocr",
        "slug": "locallens-ocr",
        "name": "LocalLens OCR",
        "cat": "AI & Vision",
        "price": "$16",
        "priceNum": 16,
        "hotkey": "\u2318 \u21e7 2",
        "desc": "Instant screen-to-code, JSON, LaTeX, and table extractor with regex formatting.",
        "pitch": "Extract clean code, JSON, formatted tables, and math equations from videos, zoom calls, images, and unselectable PDFs in 0.2 seconds. No cloud upload, no broken line-wraps.",
        "use_cases": [
            "Instantly copy code snippets from YouTube tutorials, conference livestreams, and Loom recordings.",
            "Grab unselectable tabular data from legacy web apps and paste directly into Google Sheets/Excel as clean CSV.",
            "Extract LaTeX mathematical formulas directly from academic PDF papers."
        ],
        "how_it_works": "Activates an interactive screen marquee selection overlay using an NSWindow with a transparent tracking view. Captures the selected CGWindowList pixel buffer and dispatches it directly to Apple's VNRecognizeTextRequest (Vision Framework) with recognitionLevel = .accurate. Passes recognized text blocks through a regex AST cleaner that strips spurious line breaks, fixes indentation tabs, and formats JSON/code before copying to NSPasteboard.",
        "features": [
            "Vision Neural Engine OCR with sub-200ms recognition speed",
            "Code Mode: Preserves 2/4-space indentation and brackets",
            "Table Mode: Converts visual column grids into CSV / Markdown tables",
            "LaTeX Math Mode: Converts screen formulas into equation markup",
            "Floating history tray storing your last 50 text captures"
        ]
    },
    {
        "id": "04-portsentry",
        "slug": "portsentry",
        "name": "PortSentry",
        "cat": "Developer",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Menu Bar",
        "desc": "Active port & zombie process killer. Shows listening ports, process PIDs, and 1-click kill.",
        "pitch": "Kill stubborn 'Error: listen EADDRINUSE :::3000' bugs in 1 second. PortSentry monitors all listening local network ports, reveals rogue zombie node/python processes, and kills them with a single click.",
        "use_cases": [
            "Instantly free up occupied ports (3000, 8080, 5173, 8000) when dev servers crash in the background.",
            "Inspect memory footprint and launch command of every local listening web server.",
            "1-click browser preview of any active localhost service."
        ],
        "how_it_works": "Executes BSD socket inspection using libproc and lsof commands in a non-blocking background thread. Maps active listening sockets (IPv4 & IPv6) to process identifiers (PIDs), process executable names, memory consumption, and runtime uptime. NSStatusItem popover displays interactive list with a direct SIGTERM / SIGKILL button that calls kill(pid, SIGKILL) via standard POSIX APIs.",
        "features": [
            "Real-time port monitor (Ports 80, 3000, 5000, 5173, 8000, 8080, etc.)",
            "1-Click 'Kill Process' button that instantly reclaims the port",
            "1-Click 'Open in Browser' (http://localhost:PORT)",
            "PID, process path, and memory usage inspection",
            "Auto-notification when a port is unexpectedly occupied"
        ]
    },
    {
        "id": "05-shrinkmedia",
        "slug": "shrinkmedia",
        "name": "ShrinkMedia",
        "cat": "Creative & Design",
        "price": "$12",
        "priceNum": 12,
        "hotkey": "Drag & Drop",
        "desc": "Fast drag-and-drop batch video/audio/image compressor using hardware VideoToolbox.",
        "pitch": "Compress massive 4K screen recordings, MP4 videos, and audio files by up to 88% in seconds without quality loss using Apple Silicon hardware VideoToolbox.",
        "use_cases": [
            "Shrink 500MB Loom recordings into 25MB MP4 files for instant Slack/Discord sharing.",
            "Batch compress entire folders of product demo videos for website hero sections.",
            "Convert bulky screen recordings into lightweight animated GIFs."
        ],
        "how_it_works": "Reads dropped video/audio URLs and initializes an AVAssetReader / AVAssetWriter pipeline with VTCompressionSession using hardware-accelerated HEVC / H.264 encoders on Apple Silicon VideoToolbox. Applies adaptive two-pass bitrate optimization based on frame complexity, ensuring maximum visual fidelity at a fraction of the file size.",
        "features": [
            "Hardware VideoToolbox acceleration (M1/M2/M3/M4 optimized)",
            "Presets for Discord (25MB), Slack (50MB), Email (10MB), and Web Hero",
            "Batch drag-and-drop support for 100+ files simultaneously",
            "Lossless GIF, MP4, WebM, and ProRes conversion",
            "Side-by-side visual quality comparison slider before exporting"
        ]
    },
    {
        "id": "06-colorforge",
        "slug": "colorforge",
        "name": "ColorForge",
        "cat": "Creative & Design",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "\u2318 \u21e7 C",
        "desc": "Native eyedropper, palette builder, and WCAG 2.2 AAA contrast compliance checker.",
        "pitch": "The ultimate macOS color eyedropper and palette studio. Inspect any pixel with 16x zoom magnifier, verify WCAG 2.2 AAA accessibility contrast ratios, and copy in SwiftUI, CSS, Hex, HSL, or NSColor in 1 click.",
        "use_cases": [
            "Inspect design tokens and colors directly from Figma, websites, and native apps.",
            "Verify compliance with international accessibility standards (WCAG AAA/AA).",
            "Export color palettes directly into Swift Color asset catalogs and CSS variables."
        ],
        "how_it_works": "Creates an NSWindow crosshair loupe tracking NSEvent.mouseLocation. Captures a 32x32 pixel matrix from the display framebuffer using CGWindowListCreateImage. Computes RGB, HSL, and sRGB color coordinates in real time. Calculates relative luminance and contrast ratios between foreground and background according to W3C WCAG 2.2 formulas.",
        "features": [
            "16x precision pixel magnifier loupe with grid coordinates",
            "Instant 1-click format copy (Hex, RGB, HSL, SwiftUI Color, NSColor, CSS var)",
            "Live WCAG 2.2 AA & AAA contrast compliance validator",
            "Palette Builder: Save, name, and categorize custom project color swatches",
            "Color Blindness Simulator: Preview palettes under Protanopia, Deuteranopia, and Tritanopia"
        ]
    },
    {
        "id": "07-notchshelf",
        "slug": "notchshelf",
        "name": "NotchShelf",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Top Bezel",
        "desc": "Smart drop-zone & staging area hidden inside the MacBook notch for files, links & screenshots.",
        "pitch": "Turn your useless MacBook notch into a powerful productivity staging area. Drag files, links, code snippets, and screenshots directly into the top bezel to stash them, then drop them into Slack, Terminal, or email in seconds.",
        "use_cases": [
            "Stash 10 screenshots and files while researching before composing a Slack message.",
            "Keep temporary git diffs and code snippets accessible across multiple desktop spaces.",
            "AirDrop files by simply tossing them to the top of your screen."
        ],
        "how_it_works": "Creates an invisible tracking NSWindow positioned precisely over the hardware display notch using NSScreen.auxiliaryTopLeftArea and auxiliaryTopRightArea frame bounds. Listens for drag-enter events using NSDraggingDestination protocol. On mouse hover or file drag over the notch, smoothly animates an NSPanel dropdown tray using Spring physics with CoreAnimation.",
        "features": [
            "Hardware Notch detection & non-notch menu bar fallback",
            "Multi-file drop shelf with quick thumbnail previews",
            "1-Click copy or drag-out to any app",
            "Auto-clear on successful paste",
            "Zero memory overhead (<8MB RAM)"
        ]
    },
    {
        "id": "08-audiomix",
        "slug": "audiomix",
        "name": "AudioMix",
        "cat": "Utilities & System",
        "price": "$12",
        "priceNum": 12,
        "hotkey": "Menu Bar",
        "desc": "Per-app volume mixer & independent audio output routing without virtual cables.",
        "pitch": "True per-application volume sliders for macOS. Turn down Spotify while keeping Zoom loud, mute annoying browser tabs, and route audio to headphones independently without virtual cables.",
        "use_cases": [
            "Balance game/music audio during Discord voice calls without opening web settings.",
            "Mute background audio from Chrome tabs while watching video tutorials.",
            "Route Zoom audio to headphones while Spotify plays on external speakers."
        ],
        "how_it_works": "Interfaces with macOS CoreAudio HAL (Hardware Abstraction Layer) and AudioServerPlugIn to tap per-process audio output streams. Intercepts audio buffers to apply software gain multiplication (0.0 to 2.0x volume boost) in real time before passing to the default audio output device.",
        "features": [
            "Per-app volume sliders for all active audio sources",
            "1-Click app mute & 200% volume booster",
            "Independent output device routing (AirPods vs Speakers)",
            "Zero latency hardware audio processing",
            "Keyboard hotkeys for quick master volume ducks"
        ]
    },
    {
        "id": "09-micmute-hud",
        "slug": "micmute-hud",
        "name": "MicMute HUD",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2318 \u21e7 M",
        "desc": "Universal hardware mic mute & camera blackout indicator with on-screen dynamic pill.",
        "pitch": "Supercharge your macOS workflow with MicMute HUD. Universal hardware mic mute & camera blackout indicator with on-screen dynamic pill.",
        "use_cases": [
            "Seamlessly access MicMute HUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "10-promptdock",
        "slug": "promptdock",
        "name": "PromptDock",
        "cat": "AI & Voice",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 P",
        "desc": "Global floating prompt HUD and snippet palette with dynamic variable interpolation.",
        "pitch": "Supercharge your macOS workflow with PromptDock. Global floating prompt HUD and snippet palette with dynamic variable interpolation.",
        "use_cases": [
            "Seamlessly access PromptDock from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "11-snaptile",
        "slug": "snaptile",
        "name": "SnapTile",
        "cat": "Focus & Flow",
        "price": "$8",
        "priceNum": 8,
        "hotkey": "\u2303 \u2325 Arrows",
        "desc": "Hyper-lightweight, zero-latency keyboard & edge window tiling manager with grid layouts.",
        "pitch": "Hyper-lightweight keyboard and gesture window manager for macOS. Snap windows into halves, thirds, quarters, or custom grids instantly without sluggish animations or battery drain.",
        "use_cases": [
            "Organize two coding windows side-by-side with \u2318\u2325Left and \u2318\u2325Right.",
            "Arrange a 3-column layout (IDE, Browser, Terminal) on ultra-wide monitors in 1 second.",
            "Center and focus a single window with distraction-free inner padding."
        ],
        "how_it_works": "Utilizes the macOS Accessibility API (AXUIElement) to query and set kAXPositionAttribute and kAXSizeAttribute on the focused window. Computes optimal sub-pixel frames taking into account multi-monitor screen bounds, menu bar height, dock placement, and user-configured inner/outer padding gaps.",
        "features": [
            "Zero-latency keyboard snapping (Halves, Thirds, Corners, Fullscreen)",
            "Multi-monitor smart edge jumping",
            "Customizable inner & outer window padding",
            "Drag-to-edge magnetic snap zones",
            "Uses <0.1% CPU and <5MB RAM"
        ]
    },
    {
        "id": "12-purgeapp",
        "slug": "purgeapp",
        "name": "PurgeApp",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Drag & Drop",
        "desc": "Deep uninstaller that tracks and cleans hidden caches, plists, launch agents, and containers.",
        "pitch": "Supercharge your macOS workflow with PurgeApp. Deep uninstaller that tracks and cleans hidden caches, plists, launch agents, and containers.",
        "use_cases": [
            "Seamlessly access PurgeApp from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "13-chargeguard",
        "slug": "chargeguard",
        "name": "ChargeGuard",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Battery health optimizer, custom 80% charge limiter, and real-time wattage telemetry.",
        "pitch": "Extend your MacBook battery lifespan by years. ChargeGuard allows you to set an 80% charging threshold limit, monitor real-time battery wattage, and track chemistry cycle degradation curves.",
        "use_cases": [
            "Prevent MacBook battery swelling when plugged into desk monitors 24/7.",
            "Monitor live charging wattage and discharge rates to spot battery-draining apps.",
            "Track battery cycle count and health percentage degradation over time."
        ],
        "how_it_works": "Communicates directly with Apple Silicon SMC (System Management Controller) and IOKit IOPMPowerSource to manage battery charging state. Disables battery charging at target percentage (e.g. 80%) while maintaining AC wall power pass-through to power the Mac directly.",
        "features": [
            "Custom charge limit (50% to 100% threshold)",
            "Real-time wattage & charging rate telemetry",
            "Battery cycle count & health percentage tracker",
            "High-temperature charging safety cutoff",
            "Discharge rate alerts when rogue apps drain battery"
        ]
    },
    {
        "id": "14-envvault",
        "slug": "envvault",
        "name": "EnvVault",
        "cat": "Developer",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Menu Bar",
        "desc": "Secure .env & API key workspace manager with quick paste, encryption, and zero-leak validation.",
        "pitch": "Supercharge your macOS workflow with EnvVault. Secure .env & API key workspace manager with quick paste, encryption, and zero-leak validation.",
        "use_cases": [
            "Seamlessly access EnvVault from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "15-devtunnel-hud",
        "slug": "devtunnel-hud",
        "name": "DevTunnel HUD",
        "cat": "Developer",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Menu Bar",
        "desc": "Menu bar manager & traffic inspector for Cloudflare Tunnels, Ngrok, and Localtunnel.",
        "pitch": "Supercharge your macOS workflow with DevTunnel HUD. Menu bar manager & traffic inspector for Cloudflare Tunnels, Ngrok, and Localtunnel.",
        "use_cases": [
            "Seamlessly access DevTunnel HUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "16-gitpulse",
        "slug": "gitpulse",
        "name": "GitPulse",
        "cat": "Developer",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Menu Bar",
        "desc": "Multi-repo status bar tracker for 50+ git repos: uncommitted changes, sync, and PRs.",
        "pitch": "Supercharge your Git workflow. Multi-repo status bar monitors, AI commit message generators from staged diffs, and instant branch synchronizers tailored for high-output engineering teams.",
        "use_cases": [
            "Generate clean Conventional Commits ('feat(auth): add OAuth2 token refresh') from git diff in 1 click.",
            "Monitor 50+ local repos simultaneously for uncommitted files and unpushed commits.",
            "1-click sync and branch cleanups across all microservice directories."
        ],
        "how_it_works": "Executes non-blocking libgit2 / git CLI sub-processes via Foundation.Process to inspect staged changes. Sends diff hunks through local LLM or heuristics to draft commit messages according to Conventional Commits specifications, and commits via git commit -m.",
        "features": [
            "AI Conventional Commit generator from staged diffs",
            "Multi-repo dirty-file status bar radar",
            "1-Click Stash, Pull, and Push shortcuts",
            "Interactive visual branch switcher",
            "Works 100% offline with local regex or CoreML models"
        ]
    },
    {
        "id": "17-regexforge",
        "slug": "regexforge",
        "name": "RegexForge",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "HUD",
        "desc": "Native Swift live regex debugger & visual tester with instant multi-language code export.",
        "pitch": "Supercharge your macOS workflow with RegexForge. Native Swift live regex debugger & visual tester with instant multi-language code export.",
        "use_cases": [
            "Seamlessly access RegexForge from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "18-svgoptim",
        "slug": "svgoptim",
        "name": "SVGOptim",
        "cat": "Creative & Design",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Drag & Drop",
        "desc": "Zero-bloat SVG optimizer, cleaner, and SVG-to-SwiftUI / React component converter.",
        "pitch": "Supercharge your macOS workflow with SVGOptim. Zero-bloat SVG optimizer, cleaner, and SVG-to-SwiftUI / React component converter.",
        "use_cases": [
            "Seamlessly access SVGOptim from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "19-fontinspect",
        "slug": "fontinspect",
        "name": "FontInspect",
        "cat": "Creative & Design",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Local font viewer, glyph explorer, variable font axis tester, and typography comparer.",
        "pitch": "Supercharge your macOS workflow with FontInspect. Local font viewer, glyph explorer, variable font axis tester, and typography comparer.",
        "use_cases": [
            "Seamlessly access FontInspect from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "20-presentercam",
        "slug": "presentercam",
        "name": "PresenterCam",
        "cat": "Social & Creator",
        "price": "$12",
        "priceNum": 12,
        "hotkey": "\u2318 \u21e7 P",
        "desc": "Floating camera overlay with background blur, zoom, pointer spotlight, and drawing canvas.",
        "pitch": "Supercharge your macOS workflow with PresenterCam. Floating camera overlay with background blur, zoom, pointer spotlight, and drawing canvas.",
        "use_cases": [
            "Seamlessly access PresenterCam from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "21-cleandesk-pro",
        "slug": "cleandesk-pro",
        "name": "CleanDesk Pro",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "1-Click",
        "desc": "1-click presentation mode: hides desktop icons, silences notifications, sets clean background.",
        "pitch": "Supercharge your macOS workflow with CleanDesk Pro. 1-click presentation mode: hides desktop icons, silences notifications, sets clean background.",
        "use_cases": [
            "Seamlessly access CleanDesk Pro from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "22-screenruler",
        "slug": "screenruler",
        "name": "ScreenRuler",
        "cat": "Creative & Design",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Crosshair",
        "desc": "Precision on-screen pixel measurement ruler, alignment crosshair, and padding inspector.",
        "pitch": "Dim your Mac screen below macOS minimum brightness for late-night deep work. Eliminates eye strain and applies custom amber blue-light filtering across all connected external monitors.",
        "use_cases": [
            "Late-night coding and writing in dark rooms without eye fatigue.",
            "Dim external secondary monitors that lack hardware brightness controls via DDC/CI.",
            "Apply warm circadian color temperatures for better melatonin and sleep hygiene."
        ],
        "how_it_works": "Creates transparent borderless NSWindow overlays spanning each active NSScreen with windowLevel = .screenSaver. Applies GPU-accelerated CoreImage color matrices and gamma lookup curves to darken pixels and tint color temperatures in real time.",
        "features": [
            "Ultra-low brightness (down to 5% of hardware minimum)",
            "Multi-monitor independent dimming controls",
            "Warm circadian blue-light color filter",
            "Scheduled sunset/sunrise auto-activation",
            "Global brightness hotkeys"
        ]
    },
    {
        "id": "23-apphop",
        "slug": "apphop",
        "name": "AppHop",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 `",
        "desc": "Quick-switch popup that lets you jump between open windows of ONLY the active app.",
        "pitch": "Supercharge your macOS workflow with AppHop. Quick-switch popup that lets you jump between open windows of ONLY the active app.",
        "use_cases": [
            "Seamlessly access AppHop from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "24-scratchpad-hud",
        "slug": "scratchpad-hud",
        "name": "ScratchPad HUD",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 N",
        "desc": "Always-on-top markdown scratchpad with instant cloud/local file export and quick-hide shortcut.",
        "pitch": "Supercharge your macOS workflow with ScratchPad HUD. Always-on-top markdown scratchpad with instant cloud/local file export and quick-hide shortcut.",
        "use_cases": [
            "Seamlessly access ScratchPad HUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "25-timebridge",
        "slug": "timebridge",
        "name": "TimeBridge",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Visual timezone slider and meeting overlap calculator in the menu bar with world clocks.",
        "pitch": "Supercharge your macOS workflow with TimeBridge. Visual timezone slider and meeting overlap calculator in the menu bar with world clocks.",
        "use_cases": [
            "Seamlessly access TimeBridge from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "26-menucleaner",
        "slug": "menucleaner",
        "name": "MenuCleaner",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Lightweight menu bar icon manager that auto-hides overflow items behind a smooth divider.",
        "pitch": "Supercharge your macOS workflow with MenuCleaner. Lightweight menu bar icon manager that auto-hides overflow items behind a smooth divider.",
        "use_cases": [
            "Seamlessly access MenuCleaner from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "27-metascrub",
        "slug": "metascrub",
        "name": "MetaScrub",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Drag & Drop",
        "desc": "Instant drag-and-drop EXIF, GPS location, and privacy metadata stripper for photos & PDFs.",
        "pitch": "Supercharge your macOS workflow with MetaScrub. Instant drag-and-drop EXIF, GPS location, and privacy metadata stripper for photos & PDFs.",
        "use_cases": [
            "Seamlessly access MetaScrub from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "28-bandwidthradar",
        "slug": "bandwidthradar",
        "name": "BandwidthRadar",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Real-time per-app network download/upload traffic monitor in the menu bar with rogue alerts.",
        "pitch": "Supercharge your macOS workflow with BandwidthRadar. Real-time per-app network download/upload traffic monitor in the menu bar with rogue alerts.",
        "use_cases": [
            "Seamlessly access BandwidthRadar from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "29-bluetoothautohop",
        "slug": "bluetoothautohop",
        "name": "BluetoothAutoHop",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Automated",
        "desc": "Smart Bluetooth manager that auto-disconnects on sleep, auto-reconnects on wake, shows battery.",
        "pitch": "Supercharge your macOS workflow with BluetoothAutoHop. Smart Bluetooth manager that auto-disconnects on sleep, auto-reconnects on wake, shows battery.",
        "use_cases": [
            "Seamlessly access BluetoothAutoHop from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "30-privatellm-bar",
        "slug": "privatellm-bar",
        "name": "PrivateLLM Bar",
        "cat": "AI & Voice",
        "price": "$19",
        "priceNum": 19,
        "hotkey": "Menu Bar",
        "desc": "Ultra-lightweight menu bar local model runner using MLX / llama.cpp for instant offline AI.",
        "pitch": "Supercharge your macOS workflow with PrivateLLM Bar. Ultra-lightweight menu bar local model runner using MLX / llama.cpp for instant offline AI.",
        "use_cases": [
            "Seamlessly access PrivateLLM Bar from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "31-petpals-desktop",
        "slug": "petpals-desktop",
        "name": "PetPalsDesktop",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "On Desktop",
        "desc": "Interactive desktop pet that walks on windows, sleeps during focus sessions, and nudges hydration.",
        "pitch": "Supercharge your macOS workflow with PetPalsDesktop. Interactive desktop pet that walks on windows, sleeps during focus sessions, and nudges hydration.",
        "use_cases": [
            "Seamlessly access PetPalsDesktop from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "32-bonsaigrow",
        "slug": "bonsaigrow",
        "name": "BonsaiGrow",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Menu Bar",
        "desc": "Virtual Zen Bonsai tree that grows lush leaves with completed focus sessions and withers if distracted.",
        "pitch": "Grow a serene, procedural Japanese Bonsai tree right in your menu bar. Every focused Pomodoro sprint nurtures new branches, flowers, and leaves. Neglect it, and the leaves slowly wilt.",
        "use_cases": [
            "Visual mindfulness anchor during deep coding sessions.",
            "Gamify 25-minute Pomodoro focus blocks into living botanical art.",
            "Track daily deep-work hours as tree rings and branching complexity."
        ],
        "how_it_works": "Uses a procedural recursive L-System (Lindenmayer System) rendering engine on SwiftUI Canvas / Metal. Branch growth angles, leaf foliage, and blossom density are calculated based on cumulative focus seconds stored in a local SQLite datastore. When timer is running, CoreAnimation smoothly unfurls new branch nodes.",
        "features": [
            "Procedural L-System botanical generation (every tree is 100% unique)",
            "4 Season cycles (Spring Cherry Blossom, Summer Lush, Autumn Amber, Winter Snow)",
            "Pomodoro timer integration with chime sounds",
            "Tree export as high-res PNG / SVG",
            "Pruning mode to shape your tree aesthetics"
        ]
    },
    {
        "id": "33-deskfish-aquarium",
        "slug": "deskfish-aquarium",
        "name": "DeskFishAquarium",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Floating HUD",
        "desc": "Floating translucent mini-aquarium HUD with fish whose health depends on daily habit streaks.",
        "pitch": "Supercharge your macOS workflow with DeskFishAquarium. Floating translucent mini-aquarium HUD with fish whose health depends on daily habit streaks.",
        "use_cases": [
            "Seamlessly access DeskFishAquarium from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "34-pomodorodragon",
        "slug": "pomodorodragon",
        "name": "PomodoroDragon",
        "cat": "Pets & Habits",
        "price": "$8",
        "priceNum": 8,
        "hotkey": "25m Cycle",
        "desc": "RPG Pomodoro egg that hatches into unique elemental dragons as you complete 25-minute focus cycles.",
        "pitch": "Hatch a tiny pixel art dragon that breathes fire when you maintain long productivity streaks! Level up your dragon from an egg to an ancient mythical beast as you complete work sprints.",
        "use_cases": [
            "Motivation engine for writers, developers, and students tackling heavy project workloads.",
            "Visual flame-burst reward animations when finishing sprint milestones.",
            "Desktop mascot that sleeps during break times and wakes up for study blocks."
        ],
        "how_it_works": "Implements a gamified XP level curve in Swift. Monitors user-defined Pomodoro session timers. Upon streak completion, triggers a sprite particle fire-breath animation using SpriteKit / Metal embedded within a transparent floating NSWindow. Manages dragon hunger and stamina through persistent JSON state.",
        "features": [
            "Dragon evolution from Egg to Hatchling to Wyvern to Ancient Drake",
            "SpriteKit particle fire-breathing animation engine",
            "Streak multipliers with rare elemental skins (Frost, Shadow, Gold)",
            "Sound synthesis via AudioToolbox",
            "Exportable daily habit summary cards"
        ]
    },
    {
        "id": "35-codecat",
        "slug": "codecat",
        "name": "CodeCat",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Window Edge",
        "desc": "Animated cat sitting on your active terminal or Xcode window edge, purring on Git commits and test passes.",
        "pitch": "A curious feline desktop companion that naps on top of your active windows, bats at your mouse cursor, and purrs through your Mac speakers when you type steadily.",
        "use_cases": [
            "Bring soothing companion warmth to solitary remote working environments.",
            "Cursor tracker toy that follows your mouse during breaks.",
            "Audio purr generator providing gentle white noise for deep focus."
        ],
        "how_it_works": "Tracks the active window bounds using CGWindowListCopyWindowInfo and positions the sprite on the top titlebar of the focused application. Monitors CGEvent.mouseLocation to trigger playful pounce animations when the cursor nears the cat. Generates continuous procedural purring soundscapes using AVAudioEngine.",
        "features": [
            "Window-aware climbing physics (sits on your active VS Code / Safari window)",
            "Cursor following and mouse-batting animations",
            "Generative purring audio engine with volume slider",
            "Multiple cat breeds (Calico, Tuxedo, Tabby, Void Black)",
            "Nap mode during idle periods"
        ]
    },
    {
        "id": "36-deepflow-blocker",
        "slug": "deepflow-blocker",
        "name": "DeepFlowBlocker",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 F",
        "desc": "Host and process-level distraction website & social app killer with emergency unblock math friction puzzles.",
        "pitch": "Supercharge your macOS workflow with DeepFlowBlocker. Host and process-level distraction website & social app killer with emergency unblock math friction puzzles.",
        "use_cases": [
            "Seamlessly access DeepFlowBlocker from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "37-zenaudio-ambience",
        "slug": "zenaudio-ambience",
        "name": "ZenAudioAmbience",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Binaural beats, brown noise, lo-fi coffee shop, and rain generator with 432Hz focus frequencies.",
        "pitch": "Supercharge your macOS workflow with ZenAudioAmbience. Binaural beats, brown noise, lo-fi coffee shop, and rain generator with 432Hz focus frequencies.",
        "use_cases": [
            "Seamlessly access ZenAudioAmbience from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "38-screendimmer-focus",
        "slug": "screendimmer-focus",
        "name": "ScreenDimmerFocus",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 D",
        "desc": "Spotlights your active window and dims/blurs background windows on all connected displays.",
        "pitch": "Dim your Mac screen below macOS minimum brightness for late-night deep work. Eliminates eye strain and applies custom amber blue-light filtering across all connected external monitors.",
        "use_cases": [
            "Late-night coding and writing in dark rooms without eye fatigue.",
            "Dim external secondary monitors that lack hardware brightness controls via DDC/CI.",
            "Apply warm circadian color temperatures for better melatonin and sleep hygiene."
        ],
        "how_it_works": "Creates transparent borderless NSWindow overlays spanning each active NSScreen with windowLevel = .screenSaver. Applies GPU-accelerated CoreImage color matrices and gamma lookup curves to darken pixels and tint color temperatures in real time.",
        "features": [
            "Ultra-low brightness (down to 5% of hardware minimum)",
            "Multi-monitor independent dimming controls",
            "Warm circadian blue-light color filter",
            "Scheduled sunset/sunrise auto-activation",
            "Global brightness hotkeys"
        ]
    },
    {
        "id": "39-breakreminder",
        "slug": "breakreminder",
        "name": "BreakReminder",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Timer",
        "desc": "20-20-20 eye strain rule & ergonomic stretch coach with screen fade micro-pauses.",
        "pitch": "Supercharge your macOS workflow with BreakReminder. 20-20-20 eye strain rule & ergonomic stretch coach with screen fade micro-pauses.",
        "use_cases": [
            "Seamlessly access BreakReminder from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "40-monospace-flow",
        "slug": "monospace-flow",
        "name": "MonoSpaceFlow",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 T",
        "desc": "Full-screen minimalist typewriter mode with mechanical keyboard audio feedback.",
        "pitch": "Supercharge your macOS workflow with MonoSpaceFlow. Full-screen minimalist typewriter mode with mechanical keyboard audio feedback.",
        "use_cases": [
            "Seamlessly access MonoSpaceFlow from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "41-habitgrid",
        "slug": "habitgrid",
        "name": "HabitGrid",
        "cat": "Routine & Wellness",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Menu Bar",
        "desc": "GitHub-style 365-day contribution heatmaps for personal daily habits in the menu bar.",
        "pitch": "Supercharge your macOS workflow with HabitGrid. GitHub-style 365-day contribution heatmaps for personal daily habits in the menu bar.",
        "use_cases": [
            "Seamlessly access HabitGrid from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "42-waterdrop-hud",
        "slug": "waterdrop-hud",
        "name": "WaterDropHUD",
        "cat": "Routine & Wellness",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "1-Click",
        "desc": "Smart hydration tracker with 1-click water logging, reminders, and daily goal telemetry.",
        "pitch": "Supercharge your macOS workflow with WaterDropHUD. Smart hydration tracker with 1-click water logging, reminders, and daily goal telemetry.",
        "use_cases": [
            "Seamlessly access WaterDropHUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "43-postureguard",
        "slug": "postureguard",
        "name": "PostureGuard",
        "cat": "Routine & Wellness",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Camera",
        "desc": "Uses local Apple Vision pose estimation to alert when slouching without storing or streaming any video.",
        "pitch": "Supercharge your macOS workflow with PostureGuard. Uses local Apple Vision pose estimation to alert when slouching without storing or streaming any video.",
        "use_cases": [
            "Seamlessly access PostureGuard from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "44-standup-timer",
        "slug": "standup-timer",
        "name": "StandUpTimer",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Timer",
        "desc": "Standing desk timer with posture intervals and smart desk Bluetooth auto-sync.",
        "pitch": "Supercharge your macOS workflow with StandUpTimer. Standing desk timer with posture intervals and smart desk Bluetooth auto-sync.",
        "use_cases": [
            "Seamlessly access StandUpTimer from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "45-dayplanner-notch",
        "slug": "dayplanner-notch",
        "name": "DayPlannerNotch",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Notch",
        "desc": "Visual timeline of today's calendar events & time-blocks rendered directly in the MacBook notch.",
        "pitch": "Supercharge your macOS workflow with DayPlannerNotch. Visual timeline of today's calendar events & time-blocks rendered directly in the MacBook notch.",
        "use_cases": [
            "Seamlessly access DayPlannerNotch from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "46-statussync",
        "slug": "statussync",
        "name": "StatusSync",
        "cat": "Social & Creator",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Auto",
        "desc": "Auto-syncs Slack, Discord, and Teams status based on active app or calendar event.",
        "pitch": "Supercharge your macOS workflow with StatusSync. Auto-syncs Slack, Discord, and Teams status based on active app or calendar event.",
        "use_cases": [
            "Seamlessly access StatusSync from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "47-quicktweet-x",
        "slug": "quicktweet-x",
        "name": "QuickTweetX",
        "cat": "Social & Creator",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "\u2325 X",
        "desc": "Floating HUD to draft and schedule posts to X, Bluesky, Threads, and Mastodon in one shot.",
        "pitch": "Supercharge your macOS workflow with QuickTweetX. Floating HUD to draft and schedule posts to X, Bluesky, Threads, and Mastodon in one shot.",
        "use_cases": [
            "Seamlessly access QuickTweetX from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "48-dminbox-unified",
        "slug": "dminbox-unified",
        "name": "DMInboxUnified",
        "cat": "Social & Creator",
        "price": "$8",
        "priceNum": 8,
        "hotkey": "Menu Bar",
        "desc": "Unified menu bar badge & preview for Slack, Discord, Telegram, and WhatsApp messages.",
        "pitch": "Supercharge your macOS workflow with DMInboxUnified. Unified menu bar badge & preview for Slack, Discord, Telegram, and WhatsApp messages.",
        "use_cases": [
            "Seamlessly access DMInboxUnified from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "49-streamerbanner",
        "slug": "streamerbanner",
        "name": "StreamerBanner",
        "cat": "Social & Creator",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "HUD",
        "desc": "Animated lower-thirds, watermark, and ticker for screen recordings and live streaming.",
        "pitch": "Supercharge your macOS workflow with StreamerBanner. Animated lower-thirds, watermark, and ticker for screen recordings and live streaming.",
        "use_cases": [
            "Seamlessly access StreamerBanner from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "50-emojiforge",
        "slug": "emojiforge",
        "name": "EmojiForge",
        "cat": "Social & Creator",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "\u2318 .",
        "desc": "Floating emoji & kaomoji picker with custom Slack/Discord emoji batch uploader & resizer.",
        "pitch": "Supercharge your macOS workflow with EmojiForge. Floating emoji & kaomoji picker with custom Slack/Discord emoji batch uploader & resizer.",
        "use_cases": [
            "Seamlessly access EmojiForge from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "51-pdfwhisper-ai",
        "slug": "pdfwhisper-ai",
        "name": "PDFWhisperAI",
        "cat": "AI & Vision",
        "price": "$16",
        "priceNum": 16,
        "hotkey": "Drop PDF",
        "desc": "Instant local Q&A with PDFs via Apple Silicon embeddings & CoreML (100% offline).",
        "pitch": "Stop typing repetitive emails, docs, and Slack messages. WhisperTap brings local OpenAI Whisper dictation to every single text input on macOS with zero latency, zero cloud API fees, and 100% offline privacy.",
        "use_cases": [
            "Dictate long architectural RFCs, GitHub PR descriptions, and Notion documents 4x faster than typing.",
            "Reply to Slack threads and customer emails in seconds with instant automatic clipboard pasting.",
            "Private dictation in HIPAA, SOC2, and confidential enterprise environments where cloud audio streaming is prohibited."
        ],
        "how_it_works": "Registers a global Carbon Hotkey (\u2325 Space). On press, AVFoundation captures 16kHz mono audio into a ring buffer. On release, audio is processed through a local WhisperKit CoreML model running on the Apple Silicon Neural Engine (ANE). The resulting transcript is formatted and pasted directly into the active app using CGEventPost.",
        "features": [
            "100% Offline CoreML / Apple Silicon Neural Engine inference",
            "Auto-paste into focused app text fields",
            "Dev Mode: Formats camelCase, snake_case, and markdown",
            "Custom vocabulary booster for jargon and acronyms",
            "Zero cloud API fees or audio telemetry"
        ]
    },
    {
        "id": "52-gitcommit-ai",
        "slug": "gitcommit-ai",
        "name": "GitCommitAI",
        "cat": "AI & Dev",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 C",
        "desc": "1-click conventional git commit message generator from active unstaged/staged diffs.",
        "pitch": "Supercharge your Git workflow. Multi-repo status bar monitors, AI commit message generators from staged diffs, and instant branch synchronizers tailored for high-output engineering teams.",
        "use_cases": [
            "Generate clean Conventional Commits ('feat(auth): add OAuth2 token refresh') from git diff in 1 click.",
            "Monitor 50+ local repos simultaneously for uncommitted files and unpushed commits.",
            "1-click sync and branch cleanups across all microservice directories."
        ],
        "how_it_works": "Executes non-blocking libgit2 / git CLI sub-processes via Foundation.Process to inspect staged changes. Sends diff hunks through local LLM or heuristics to draft commit messages according to Conventional Commits specifications, and commits via git commit -m.",
        "features": [
            "AI Conventional Commit generator from staged diffs",
            "Multi-repo dirty-file status bar radar",
            "1-Click Stash, Pull, and Push shortcuts",
            "Interactive visual branch switcher",
            "Works 100% offline with local regex or CoreML models"
        ]
    },
    {
        "id": "53-codeexplainer-hud",
        "slug": "codeexplainer-hud",
        "name": "CodeExplainerHUD",
        "cat": "AI & Dev",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Highlight",
        "desc": "Highlight any cryptic code, regex, or error on screen and get an instant plain-English breakdown.",
        "pitch": "Supercharge your macOS workflow with CodeExplainerHUD. Highlight any cryptic code, regex, or error on screen and get an instant plain-English breakdown.",
        "use_cases": [
            "Seamlessly access CodeExplainerHUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "54-voicetranscribe-batch",
        "slug": "voicetranscribe-batch",
        "name": "VoiceTranscribeBatch",
        "cat": "AI & Voice",
        "price": "$16",
        "priceNum": 16,
        "hotkey": "Drop Audio",
        "desc": "Drop long-form podcasts and meetings to generate speaker-diarized timestamped transcripts.",
        "pitch": "Supercharge your macOS workflow with VoiceTranscribeBatch. Drop long-form podcasts and meetings to generate speaker-diarized timestamped transcripts.",
        "use_cases": [
            "Seamlessly access VoiceTranscribeBatch from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "55-aiwallpaper-generator",
        "slug": "aiwallpaper-generator",
        "name": "AIWallpaperGenerator",
        "cat": "AI & Creative",
        "price": "$16",
        "priceNum": 16,
        "hotkey": "4K Gen",
        "desc": "Generates 4K dynamic desktop wallpapers using local Stable Diffusion / CoreML models.",
        "pitch": "Supercharge your macOS workflow with AIWallpaperGenerator. Generates 4K dynamic desktop wallpapers using local Stable Diffusion / CoreML models.",
        "use_cases": [
            "Seamlessly access AIWallpaperGenerator from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "56-jsonmaster-pro",
        "slug": "jsonmaster-pro",
        "name": "JSONMasterPro",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "HUD",
        "desc": "Instant JSON/YAML/TOML viewer, formatter, path extractor, and TypeScript type generator.",
        "pitch": "Supercharge your macOS workflow with JSONMasterPro. Instant JSON/YAML/TOML viewer, formatter, path extractor, and TypeScript type generator.",
        "use_cases": [
            "Seamlessly access JSONMasterPro from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "57-cronvisualizer",
        "slug": "cronvisualizer",
        "name": "CronVisualizer",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Visual cron expression builder, human-readable explainer, and next-runs schedule debugger.",
        "pitch": "Supercharge your macOS workflow with CronVisualizer. Visual cron expression builder, human-readable explainer, and next-runs schedule debugger.",
        "use_cases": [
            "Seamlessly access CronVisualizer from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "58-dockerquick-hud",
        "slug": "dockerquick-hud",
        "name": "DockerQuickHUD",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Lightweight container viewer, start/stop/restart, log stream, and volume cleanup.",
        "pitch": "Control Docker Desktop and OrbStack directly from your menu bar. View running containers, inspect RAM/CPU usage, restart containers, and clean dangling images in 1 click.",
        "use_cases": [
            "Stop heavy Docker containers draining your battery when switching to battery power.",
            "1-click restart crashed Postgres or Redis containers.",
            "Reclaim 20GB+ of disk space by pruning orphaned layers and dangling images."
        ],
        "how_it_works": "Communicates directly with /var/run/docker.sock UNIX domain socket using async HTTP over UNIX sockets in Swift. Queries /containers/json and /system/df endpoints to display real-time container metrics without launching heavy web dashboards.",
        "features": [
            "UNIX socket integration with zero API overhead",
            "Container start, stop, pause, and restart controls",
            "Live CPU and Memory telemetry per container",
            "1-Click system prune to reclaim gigabytes of disk",
            "Container log viewer with search and auto-scroll"
        ]
    },
    {
        "id": "59-hostsmanager",
        "slug": "hostsmanager",
        "name": "HostsManager",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "1-click /etc/hosts profile switcher for staging, dev, testing, and production domains.",
        "pitch": "Supercharge your macOS workflow with HostsManager. 1-click /etc/hosts profile switcher for staging, dev, testing, and production domains.",
        "use_cases": [
            "Seamlessly access HostsManager from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "60-certsentry",
        "slug": "certsentry",
        "name": "CertSentry",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "SSL/TLS certificate expiration tracker for your domains with 30/14/7-day alerts.",
        "pitch": "Supercharge your macOS workflow with CertSentry. SSL/TLS certificate expiration tracker for your domains with 30/14/7-day alerts.",
        "use_cases": [
            "Seamlessly access CertSentry from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "61-keychainquick",
        "slug": "keychainquick",
        "name": "KeyChainQuick",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 K",
        "desc": "Fast search and copy for developer SSH keys, GPG fingerprints, and access tokens.",
        "pitch": "Supercharge your macOS workflow with KeyChainQuick. Fast search and copy for developer SSH keys, GPG fingerprints, and access tokens.",
        "use_cases": [
            "Seamlessly access KeyChainQuick from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "62-curlcraft",
        "slug": "curlcraft",
        "name": "CurlCraft",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Convert",
        "desc": "Converts network cURL commands to Swift, Python, Node, Go, Rust code snippets instantly.",
        "pitch": "Supercharge your macOS workflow with CurlCraft. Converts network cURL commands to Swift, Python, Node, Go, Rust code snippets instantly.",
        "use_cases": [
            "Seamlessly access CurlCraft from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "63-sqlitelens",
        "slug": "sqlitelens",
        "name": "SqliteLens",
        "cat": "Developer",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Drop .db",
        "desc": "Instant SQLite database file inspector, query runner, and table exporter.",
        "pitch": "Instant SQLite database inspector in your menu bar. Drag and drop any .sqlite, .db, or CoreData store to run queries, inspect tables, and export data in 1 second.",
        "use_cases": [
            "Inspect iOS app CoreData stores, Chrome history databases, or local SQLite caches.",
            "Run ad-hoc SQL queries with syntax highlighting and instant CSV export.",
            "Inspect schema table structures, foreign keys, and index efficiency."
        ],
        "how_it_works": "Wraps libsqlite3 native C-bindings directly in Swift. Opens files in read-only immutable mode to prevent corruption. Executes queries asynchronously and displays results in an optimized virtualized SwiftUI Table view capable of rendering 100,000+ rows smoothly.",
        "features": [
            "Direct libsqlite3 C-engine integration for blazing query speeds",
            "Drag-and-drop file inspection (.sqlite, .db, .sqlite3)",
            "Interactive SQL query console with auto-completion",
            "Export query results to CSV, JSON, and Markdown",
            "Schema diagram and index visualizer"
        ]
    },
    {
        "id": "64-npmoutdated-hud",
        "slug": "npmoutdated-hud",
        "name": "NpmOutdatedHUD",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Watches package.json across local repos and alerts when dependencies have security patches.",
        "pitch": "Supercharge your macOS workflow with NpmOutdatedHUD. Watches package.json across local repos and alerts when dependencies have security patches.",
        "use_cases": [
            "Seamlessly access NpmOutdatedHUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "65-taillogs",
        "slug": "taillogs",
        "name": "TailLogs",
        "cat": "Developer",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Tail -f",
        "desc": "Menu bar multi-file live log tailer with regex color highlighting.",
        "pitch": "Supercharge your macOS workflow with TailLogs. Menu bar multi-file live log tailer with regex color highlighting.",
        "use_cases": [
            "Seamlessly access TailLogs from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "66-mockupsnap",
        "slug": "mockupsnap",
        "name": "MockupSnap",
        "cat": "Creative & Design",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "1-Click",
        "desc": "1-click wraps screenshots inside realistic 3D MacBook Pro, iPhone, and iPad frames.",
        "pitch": "Supercharge your macOS workflow with MockupSnap. 1-click wraps screenshots inside realistic 3D MacBook Pro, iPhone, and iPad frames.",
        "use_cases": [
            "Seamlessly access MockupSnap from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "67-appiconforge",
        "slug": "appiconforge",
        "name": "AppIconForge",
        "cat": "Creative & Design",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Drop PNG",
        "desc": "Drag a 1024x1024 PNG to automatically generate all iOS, macOS, watchOS, and Web icon sizes.",
        "pitch": "Supercharge your macOS workflow with AppIconForge. Drag a 1024x1024 PNG to automatically generate all iOS, macOS, watchOS, and Web icon sizes.",
        "use_cases": [
            "Seamlessly access AppIconForge from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "68-lottiepreview",
        "slug": "lottiepreview",
        "name": "LottiePreview",
        "cat": "Creative & Design",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Scrubber",
        "desc": "Native dotLottie and JSON animation player, frame scrubber, and GIF/MP4 exporter.",
        "pitch": "Supercharge your macOS workflow with LottiePreview. Native dotLottie and JSON animation player, frame scrubber, and GIF/MP4 exporter.",
        "use_cases": [
            "Seamlessly access LottiePreview from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "69-aspectratio-calc",
        "slug": "aspectratio-calc",
        "name": "AspectRatioCalc",
        "cat": "Creative & Design",
        "price": "$3",
        "priceNum": 3,
        "hotkey": "Calc",
        "desc": "Instant aspect ratio, DPI, points-to-pixels, and responsive viewport sizing calculator.",
        "pitch": "Supercharge your macOS workflow with AspectRatioCalc. Instant aspect ratio, DPI, points-to-pixels, and responsive viewport sizing calculator.",
        "use_cases": [
            "Seamlessly access AspectRatioCalc from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "70-shadowstudio",
        "slug": "shadowstudio",
        "name": "ShadowStudio",
        "cat": "Creative & Design",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "CSS/SwiftUI",
        "desc": "Visual realistic multi-layer shadow designer with CSS box-shadow and SwiftUI code export.",
        "pitch": "Supercharge your macOS workflow with ShadowStudio. Visual realistic multi-layer shadow designer with CSS box-shadow and SwiftUI code export.",
        "use_cases": [
            "Seamlessly access ShadowStudio from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "71-duplicatefinder",
        "slug": "duplicatefinder",
        "name": "DuplicateFinder",
        "cat": "Utilities & System",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Scan",
        "desc": "Blazing-fast hashing-based duplicate file scanner to reclaim disk space.",
        "pitch": "A curious feline desktop companion that naps on top of your active windows, bats at your mouse cursor, and purrs through your Mac speakers when you type steadily.",
        "use_cases": [
            "Bring soothing companion warmth to solitary remote working environments.",
            "Cursor tracker toy that follows your mouse during breaks.",
            "Audio purr generator providing gentle white noise for deep focus."
        ],
        "how_it_works": "Tracks the active window bounds using CGWindowListCopyWindowInfo and positions the sprite on the top titlebar of the focused application. Monitors CGEvent.mouseLocation to trigger playful pounce animations when the cursor nears the cat. Generates continuous procedural purring soundscapes using AVAudioEngine.",
        "features": [
            "Window-aware climbing physics (sits on your active VS Code / Safari window)",
            "Cursor following and mouse-batting animations",
            "Generative purring audio engine with volume slider",
            "Multiple cat breeds (Calico, Tuxedo, Tabby, Void Black)",
            "Nap mode during idle periods"
        ]
    },
    {
        "id": "72-caffeinebar",
        "slug": "caffeinebar",
        "name": "CaffeineBar",
        "cat": "Utilities & System",
        "price": "$3",
        "priceNum": 3,
        "hotkey": "1-Click",
        "desc": "Keeps Mac awake indefinitely or on a timer with custom display sleep rules.",
        "pitch": "Keep your Mac awake during long rendering, downloads, or presentations with 1 click. Custom timers, display sleep prevention, and automated battery threshold shutoffs.",
        "use_cases": [
            "Prevent your Mac from sleeping while downloading massive 50GB datasets or rendering 3D scenes.",
            "Keep screen awake during client presentations and keynote speeches.",
            "Auto-deactivate when battery drops below 20% to prevent unexpected shutdowns."
        ],
        "how_it_works": "Invokes macOS IOKit power management assertions using IOPMAssertionCreateWithName with kIOPMAssertionTypePreventUserIdleSystemSleep and kIOPMAssertionTypePreventUserIdleDisplaySleep. Manages assertion lifecycle with automatic timer deallocation.",
        "features": [
            "1-Click Menu Bar toggle (Awake vs Sleep)",
            "Timed sessions (15m, 30m, 1h, 2h, 4h, Indefinite)",
            "Display sleep vs System sleep granular controls",
            "Low battery auto-release safety guard",
            "Custom animated status bar icons (Coffee mug, Flame, Lightning)"
        ]
    },
    {
        "id": "73-hiddenfiles-toggle",
        "slug": "hiddenfiles-toggle",
        "name": "HiddenFilesToggle",
        "cat": "Utilities & System",
        "price": "$3",
        "priceNum": 3,
        "hotkey": "\u2318 \u21e7 .",
        "desc": "1-click menu bar toggle to show/hide hidden dotfiles and system files in Finder.",
        "pitch": "Supercharge your macOS workflow with HiddenFilesToggle. 1-click menu bar toggle to show/hide hidden dotfiles and system files in Finder.",
        "use_cases": [
            "Seamlessly access HiddenFilesToggle from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "74-archiveextractor",
        "slug": "archiveextractor",
        "name": "ArchiveExtractor",
        "cat": "Utilities & System",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Drop Zip",
        "desc": "Ultra-fast unarchiver supporting 7z, RAR, TAR, GZ, ISO with auto-delete zip option.",
        "pitch": "Supercharge your macOS workflow with ArchiveExtractor. Ultra-fast unarchiver supporting 7z, RAR, TAR, GZ, ISO with auto-delete zip option.",
        "use_cases": [
            "Seamlessly access ArchiveExtractor from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "75-clipboarddiff",
        "slug": "clipboarddiff",
        "name": "ClipboardDiff",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 V",
        "desc": "Compares current clipboard with previous clipboard and shows a visual side-by-side git diff.",
        "pitch": "Supercharge your macOS workflow with ClipboardDiff. Compares current clipboard with previous clipboard and shows a visual side-by-side git diff.",
        "use_cases": [
            "Seamlessly access ClipboardDiff from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "76-apppermission-auditor",
        "slug": "apppermission-auditor",
        "name": "AppPermissionAuditor",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Audit",
        "desc": "Inspects all apps granted Camera, Mic, Accessibility, Screen Recording, or Full Disk permissions.",
        "pitch": "Supercharge your macOS workflow with AppPermissionAuditor. Inspects all apps granted Camera, Mic, Accessibility, Screen Recording, or Full Disk permissions.",
        "use_cases": [
            "Seamlessly access AppPermissionAuditor from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "77-wifiradar",
        "slug": "wifiradar",
        "name": "WiFiRadar",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "Displays channel congestion, signal RSSI, interference, and speed test directly in the menu bar.",
        "pitch": "Supercharge your macOS workflow with WiFiRadar. Displays channel congestion, signal RSSI, interference, and speed test directly in the menu bar.",
        "use_cases": [
            "Seamlessly access WiFiRadar from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "78-quickshare-local",
        "slug": "quickshare-local",
        "name": "QuickShareLocal",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "P2P Drop",
        "desc": "AirDrop-like local network file dropper between Macs and PCs via browser URL.",
        "pitch": "Supercharge your macOS workflow with QuickShareLocal. AirDrop-like local network file dropper between Macs and PCs via browser URL.",
        "use_cases": [
            "Seamlessly access QuickShareLocal from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "79-audiorecord-hud",
        "slug": "audiorecord-hud",
        "name": "AudioRecordHUD",
        "cat": "Utilities & System",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "1-Click",
        "desc": "1-click system audio + microphone recorder with instant MP3/M4A export.",
        "pitch": "Supercharge your macOS workflow with AudioRecordHUD. 1-click system audio + microphone recorder with instant MP3/M4A export.",
        "use_cases": [
            "Seamlessly access AudioRecordHUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "80-memorypurge-pro",
        "slug": "memorypurge-pro",
        "name": "MemoryPurgePro",
        "cat": "Utilities & System",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Purge",
        "desc": "Visual RAM pressure monitor with 1-click inactive memory purge and cache optimization.",
        "pitch": "Supercharge your macOS workflow with MemoryPurgePro. Visual RAM pressure monitor with 1-click inactive memory purge and cache optimization.",
        "use_cases": [
            "Seamlessly access MemoryPurgePro from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "81-pixelhamster-desktop",
        "slug": "pixelhamster-desktop",
        "name": "PixelHamsterDesktop",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Menu Bar",
        "desc": "Animated pixel hamster running on a wheel in your menu bar, speeding up with typing and commits.",
        "pitch": "Turn typing and software development into an addictive workout for your virtual pet. PixelHamster sits atop your screen or menu bar, spinning his exercise wheel faster as your WPM typing speed and compilation tasks accelerate!",
        "use_cases": [
            "Gamify coding sprints, essays, and typing sessions with visual speed feedback.",
            "Track daily distance run (e.g. 5.4 km) as a proxy for your keyboard activity and flow state.",
            "Display an adorable interactive desktop companion that rewards focus streaks with golden seeds."
        ],
        "how_it_works": "Captures global keyboard velocity via CGEventTap / IOHIDManager with eventMask = [.keyDown]. Maintains an exponentially decaying moving average of keystrokes per minute (WPM). Translates WPM into sprite animation framerate (30fps -> 120fps) and wheel RPM on an NSPanel floating borderless transparent window with .canJoinAllSpaces and .floating level. Distance traveled is calculated via wheel circumference physics and persisted to UserDefaults.",
        "features": [
            "Dynamic sprite animation reacting to live WPM typing speed",
            "Menu bar RPM ticker and distance odometer",
            "Custom hamster skins (Golden, Robo, Panda, Cyber)",
            "Interactive feeding with seeds and treats",
            "Zero CPU overhead (<0.5% CPU when idle)"
        ]
    },
    {
        "id": "82-cybergochi",
        "slug": "cybergochi",
        "name": "CyberGochi",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Menu Bar",
        "desc": "Retro Tamagotchi virtual pet that eats completed to-do items and evolves through productivity streaks.",
        "pitch": "The nostalgic 90s handheld virtual pet reborn natively on macOS. CyberGochi lives in your menu bar and desktop, growing as you check off tasks, and demanding snacks when you procrastinate.",
        "use_cases": [
            "Replace boring to-do lists with a living Tamagotchi pet that evolves with your daily productivity.",
            "Take mindful 2-minute play breaks to feed and pet your creature during intense work sessions.",
            "Enjoy retro pixel art aesthetics floating unobtrusively on your modern Mac display."
        ],
        "how_it_works": "Maintains a persistent state machine tracking Hunger, Happiness, Discipline, and Energy levels using an async background timer (DispatchSourceTimer). Integrates with EventKit / NSUserActivity to reward completed tasks with evolution XP. Renders sharp pixel art using SwiftUI Canvas / CoreGraphics with .interpolation(.none) on a floating borderless HUD.",
        "features": [
            "4-stage pet evolution system (Egg -> Baby -> Teen -> Cyber Beast)",
            "Hunger & Happiness decay algorithms with notch notifications",
            "Retro 8-bit sound effects using AudioToolbox SystemSoundID",
            "Discipline & mini-games to boost creature stats",
            "Offline local SQLite database for lifelong pet history"
        ]
    },
    {
        "id": "83-deskduck",
        "slug": "deskduck",
        "name": "DeskDuck",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "\u2325 D",
        "desc": "Floating rubber duck debugger that asks Socratic prompts when you're stuck coding or writing.",
        "pitch": "The ultimate Socratic debugging companion for software engineers. DeskDuck floats on your screen, ready for you to explain tricky bugs, offering helpful prompts and tracking your 'aha!' breakthrough moments.",
        "use_cases": [
            "Talk through complex algorithms, concurrency deadlocks, and system design trade-offs.",
            "Log your debugging hypotheses and track root-cause resolution times.",
            "Quickly quack for inspiration when stuck on an elusive bug."
        ],
        "how_it_works": "Built on SwiftUI and AppKit with an always-on-top NSPanel that stays keyable without stealing focus from your IDE (styleMask: [.nonactivatingPanel]). Features an interactive Socratic dialogue engine with pre-loaded cognitive debugging frameworks. Tracks debugging session duration and logs resolved tickets to local markdown scratchpads.",
        "features": [
            "Interactive Rubber Duck with animated quacks and thought bubbles",
            "Socratic prompting engine ('What assumptions are you making?', 'Where does state change?')",
            "Debugging session timer and breakthrough counter",
            "Custom duck outfits (Wizard, Detective, Astronaut)",
            "Markdown notes auto-export for team bug postmortems"
        ]
    },
    {
        "id": "84-plantnursery-hud",
        "slug": "plantnursery-hud",
        "name": "PlantNurseryHUD",
        "cat": "Pets & Habits",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "HUD",
        "desc": "Virtual greenhouse where rare succulents grow based on your hydration and focus check-ins.",
        "pitch": "Supercharge your macOS workflow with PlantNurseryHUD. Virtual greenhouse where rare succulents grow based on your hydration and focus check-ins.",
        "use_cases": [
            "Seamlessly access PlantNurseryHUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "85-focussloth",
        "slug": "focussloth",
        "name": "FocusSloth",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Notch",
        "desc": "Animated sloth climbing a branch in the notch during continuous deep focus time.",
        "pitch": "Supercharge your macOS workflow with FocusSloth. Animated sloth climbing a branch in the notch during continuous deep focus time.",
        "use_cases": [
            "Seamlessly access FocusSloth from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "86-zenpanda",
        "slug": "zenpanda",
        "name": "ZenPanda",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Breathe",
        "desc": "Meditating panda companion guiding 60-second box-breathing exercises between meetings.",
        "pitch": "Supercharge your macOS workflow with ZenPanda. Meditating panda companion guiding 60-second box-breathing exercises between meetings.",
        "use_cases": [
            "Seamlessly access ZenPanda from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "87-codeotter",
        "slug": "codeotter",
        "name": "CodeOtter",
        "cat": "Pets & Habits",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Window Edge",
        "desc": "Playful otter swimming along window edges, catching fish on successful test runs.",
        "pitch": "Supercharge your macOS workflow with CodeOtter. Playful otter swimming along window edges, catching fish on successful test runs.",
        "use_cases": [
            "Seamlessly access CodeOtter from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "88-brainwave-sync",
        "slug": "brainwave-sync",
        "name": "BrainWaveSync",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Audio",
        "desc": "Binaural 40Hz Gamma and Alpha wave generator for memory consolidation and hyper-focus.",
        "pitch": "Supercharge your macOS workflow with BrainWaveSync. Binaural 40Hz Gamma and Alpha wave generator for memory consolidation and hyper-focus.",
        "use_cases": [
            "Seamlessly access BrainWaveSync from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "89-singletask-spotlight",
        "slug": "singletask-spotlight",
        "name": "SingleTaskSpotlight",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 S",
        "desc": "Forces 1 single active window, completely hiding dock and menu bar until current task is checked off.",
        "pitch": "Supercharge your macOS workflow with SingleTaskSpotlight. Forces 1 single active window, completely hiding dock and menu bar until current task is checked off.",
        "use_cases": [
            "Seamlessly access SingleTaskSpotlight from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "90-antiprocrastinate-friction",
        "slug": "antiprocrastinate-friction",
        "name": "AntiProcrastinateFriction",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Auto",
        "desc": "Adds a 10-second deliberate breathing countdown before opening selected addictive URLs/apps.",
        "pitch": "Supercharge your macOS workflow with AntiProcrastinateFriction. Adds a 10-second deliberate breathing countdown before opening selected addictive URLs/apps.",
        "use_cases": [
            "Seamlessly access AntiProcrastinateFriction from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "91-whitenoise-mixer",
        "slug": "whitenoise-mixer",
        "name": "WhiteNoiseMixer",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Audio",
        "desc": "Multi-track customizable soundscape mixer (Rain + Campfire + Ocean Waves + Wind Chimes).",
        "pitch": "Supercharge your macOS workflow with WhiteNoiseMixer. Multi-track customizable soundscape mixer (Rain + Campfire + Ocean Waves + Wind Chimes).",
        "use_cases": [
            "Seamlessly access WhiteNoiseMixer from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "92-tablimiter-pro",
        "slug": "tablimiter-pro",
        "name": "TabLimiterPro",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Safari/Chrome",
        "desc": "Restricts open tabs to max 5 per window, auto-archiving overflowing tabs to a reading list.",
        "pitch": "Supercharge your macOS workflow with TabLimiterPro. Restricts open tabs to max 5 per window, auto-archiving overflowing tabs to a reading list.",
        "use_cases": [
            "Seamlessly access TabLimiterPro from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "93-eyeblink-coach",
        "slug": "eyeblink-coach",
        "name": "EyeBlinkCoach",
        "cat": "Focus & Flow",
        "price": "$3",
        "priceNum": 3,
        "hotkey": "Subtle Pulse",
        "desc": "Subtly flashes a soft screen border halo every 15 seconds to remind power users to blink.",
        "pitch": "Supercharge your macOS workflow with EyeBlinkCoach. Subtly flashes a soft screen border halo every 15 seconds to remind power users to blink.",
        "use_cases": [
            "Seamlessly access EyeBlinkCoach from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "94-focusheatmap",
        "slug": "focusheatmap",
        "name": "FocusHeatmap",
        "cat": "Focus & Flow",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Overlay",
        "desc": "Live visual heatmap overlay showing which apps and windows consumed your attention today.",
        "pitch": "Supercharge your macOS workflow with FocusHeatmap. Live visual heatmap overlay showing which apps and windows consumed your attention today.",
        "use_cases": [
            "Seamlessly access FocusHeatmap from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "95-morningkickoff-hud",
        "slug": "morningkickoff-hud",
        "name": "MorningKickoffHUD",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "9:00 AM",
        "desc": "3-minute morning launchpad popup showing today's top 3 MITs, calendar, and weather overview.",
        "pitch": "Supercharge your macOS workflow with MorningKickoffHUD. 3-minute morning launchpad popup showing today's top 3 MITs, calendar, and weather overview.",
        "use_cases": [
            "Seamlessly access MorningKickoffHUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "96-microjournal-bar",
        "slug": "microjournal-bar",
        "name": "MicroJournalBar",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "desc": "1-line micro-journaling in the menu bar to log quick thoughts, gratitude, and wins.",
        "pitch": "Supercharge your macOS workflow with MicroJournalBar. 1-line micro-journaling in the menu bar to log quick thoughts, gratitude, and wins.",
        "use_cases": [
            "Seamlessly access MicroJournalBar from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "97-sugar-fasting-tracker",
        "slug": "sugar-fasting-tracker",
        "name": "SugarFastingTracker",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Status Bar",
        "desc": "Visual intermittent fasting timer in status bar with ketosis stage and metabolic alerts.",
        "pitch": "Supercharge your macOS workflow with SugarFastingTracker. Visual intermittent fasting timer in status bar with ketosis stage and metabolic alerts.",
        "use_cases": [
            "Seamlessly access SugarFastingTracker from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "98-sleephygiene-nudge",
        "slug": "sleephygiene-nudge",
        "name": "SleepHygieneNudge",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Night Shift",
        "desc": "Automatically warms screen temperature and locks distraction apps 1 hour before scheduled bedtime.",
        "pitch": "Supercharge your macOS workflow with SleepHygieneNudge. Automatically warms screen temperature and locks distraction apps 1 hour before scheduled bedtime.",
        "use_cases": [
            "Seamlessly access SleepHygieneNudge from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "99-meetingprep-countdown",
        "slug": "meetingprep-countdown",
        "name": "MeetingPrepCountdown",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Pre-Alarm",
        "desc": "Popover chime 2 minutes before Google Meet/Zoom calls with direct 1-click join link.",
        "pitch": "Supercharge your macOS workflow with MeetingPrepCountdown. Popover chime 2 minutes before Google Meet/Zoom calls with direct 1-click join link.",
        "use_cases": [
            "Seamlessly access MeetingPrepCountdown from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "100-stepcounter-sync",
        "slug": "stepcounter-sync",
        "name": "StepCounterSync",
        "cat": "Routine & Wellness",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Health Sync",
        "desc": "Apple Watch / Health synced step counter progress bar right in the menu bar.",
        "pitch": "Supercharge your macOS workflow with StepCounterSync. Apple Watch / Health synced step counter progress bar right in the menu bar.",
        "use_cases": [
            "Seamlessly access StepCounterSync from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "101-caffeinedecay-curve",
        "slug": "caffeinedecay-curve",
        "name": "CaffeineDecayCurve",
        "cat": "Routine & Wellness",
        "price": "$3",
        "priceNum": 3,
        "hotkey": "Decay Model",
        "desc": "Calculates and plots active caffeine in bloodstream with sleep cutoff time warnings.",
        "pitch": "Keep your Mac awake during long rendering, downloads, or presentations with 1 click. Custom timers, display sleep prevention, and automated battery threshold shutoffs.",
        "use_cases": [
            "Prevent your Mac from sleeping while downloading massive 50GB datasets or rendering 3D scenes.",
            "Keep screen awake during client presentations and keynote speeches.",
            "Auto-deactivate when battery drops below 20% to prevent unexpected shutdowns."
        ],
        "how_it_works": "Invokes macOS IOKit power management assertions using IOPMAssertionCreateWithName with kIOPMAssertionTypePreventUserIdleSystemSleep and kIOPMAssertionTypePreventUserIdleDisplaySleep. Manages assertion lifecycle with automatic timer deallocation.",
        "features": [
            "1-Click Menu Bar toggle (Awake vs Sleep)",
            "Timed sessions (15m, 30m, 1h, 2h, 4h, Indefinite)",
            "Display sleep vs System sleep granular controls",
            "Low battery auto-release safety guard",
            "Custom animated status bar icons (Coffee mug, Flame, Lightning)"
        ]
    },
    {
        "id": "102-cliptomarkdown-thread",
        "slug": "cliptomarkdown-thread",
        "name": "ClipToMarkdownThread",
        "cat": "Social & Creator",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "1-Click",
        "desc": "Converts X, Reddit, and LinkedIn posts into clean Obsidian/Notion markdown.",
        "pitch": "Supercharge your macOS workflow with ClipToMarkdownThread. Converts X, Reddit, and LinkedIn posts into clean Obsidian/Notion markdown.",
        "use_cases": [
            "Seamlessly access ClipToMarkdownThread from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "103-podcastchapter-marker",
        "slug": "podcastchapter-marker",
        "name": "PodcastChapterMarker",
        "cat": "Social & Creator",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "ID3 Tags",
        "desc": "Audio waveform scrubber to drop timestamped chapter markers and export ID3 tags.",
        "pitch": "Supercharge your macOS workflow with PodcastChapterMarker. Audio waveform scrubber to drop timestamped chapter markers and export ID3 tags.",
        "use_cases": [
            "Seamlessly access PodcastChapterMarker from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "104-teleprompter-hud",
        "slug": "teleprompter-hud",
        "name": "TeleprompterHUD",
        "cat": "Social & Creator",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Transparent",
        "desc": "Translucent scrolling teleprompter for presentations and recorded video.",
        "pitch": "Supercharge your macOS workflow with TeleprompterHUD. Translucent scrolling teleprompter for presentations and recorded video.",
        "use_cases": [
            "Seamlessly access TeleprompterHUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "105-quickpoll-creator",
        "slug": "quickpoll-creator",
        "name": "QuickPollCreator",
        "cat": "Social & Creator",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "HUD",
        "desc": "Generates formatted poll layouts for Twitter, LinkedIn, and Slack with 1-click copy.",
        "pitch": "Supercharge your macOS workflow with QuickPollCreator. Generates formatted poll layouts for Twitter, LinkedIn, and Slack with 1-click copy.",
        "use_cases": [
            "Seamlessly access QuickPollCreator from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "106-videothumbnail-tester",
        "slug": "videothumbnail-tester",
        "name": "VideoThumbnailTester",
        "cat": "Social & Creator",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Preview",
        "desc": "Previews YouTube and Twitter thumbnails on light/dark mode social feed mocks.",
        "pitch": "Supercharge your macOS workflow with VideoThumbnailTester. Previews YouTube and Twitter thumbnails on light/dark mode social feed mocks.",
        "use_cases": [
            "Seamlessly access VideoThumbnailTester from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "107-discordrole-autoping",
        "slug": "discordrole-autoping",
        "name": "DiscordRoleAutoPing",
        "cat": "Social & Creator",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Embed",
        "desc": "Quick organizer for Discord markdown formatting, roles, and embed payloads.",
        "pitch": "Supercharge your macOS workflow with DiscordRoleAutoPing. Quick organizer for Discord markdown formatting, roles, and embed payloads.",
        "use_cases": [
            "Seamlessly access DiscordRoleAutoPing from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "108-watermarkmaster",
        "slug": "watermarkmaster",
        "name": "WatermarkMaster",
        "cat": "Social & Creator",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "Batch",
        "desc": "Applies customizable dynamic logos and watermarks to batches of images.",
        "pitch": "Supercharge your macOS workflow with WatermarkMaster. Applies customizable dynamic logos and watermarks to batches of images.",
        "use_cases": [
            "Seamlessly access WatermarkMaster from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "109-whispersubtitles-srt",
        "slug": "whispersubtitles-srt",
        "name": "WhisperSubtitlesSRT",
        "cat": "AI & Voice",
        "price": "$16",
        "priceNum": 16,
        "hotkey": "WhisperKit",
        "desc": "Generates timestamped .srt and .vtt subtitles locally via WhisperKit in seconds.",
        "pitch": "Stop typing repetitive emails, docs, and Slack messages. WhisperTap brings local OpenAI Whisper dictation to every single text input on macOS with zero latency, zero cloud API fees, and 100% offline privacy.",
        "use_cases": [
            "Dictate long architectural RFCs, GitHub PR descriptions, and Notion documents 4x faster than typing.",
            "Reply to Slack threads and customer emails in seconds with instant automatic clipboard pasting.",
            "Private dictation in HIPAA, SOC2, and confidential enterprise environments where cloud audio streaming is prohibited."
        ],
        "how_it_works": "Registers a global Carbon Hotkey (\u2325 Space). On press, AVFoundation captures 16kHz mono audio into a ring buffer. On release, audio is processed through a local WhisperKit CoreML model running on the Apple Silicon Neural Engine (ANE). The resulting transcript is formatted and pasted directly into the active app using CGEventPost.",
        "features": [
            "100% Offline CoreML / Apple Silicon Neural Engine inference",
            "Auto-paste into focused app text fields",
            "Dev Mode: Formats camelCase, snake_case, and markdown",
            "Custom vocabulary booster for jargon and acronyms",
            "Zero cloud API fees or audio telemetry"
        ]
    },
    {
        "id": "110-summarizeurl-ai",
        "slug": "summarizeurl-ai",
        "name": "SummarizeURLAI",
        "cat": "AI & Voice",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 U",
        "desc": "Offline webpage and article summarizer with 3 bullet takeaways.",
        "pitch": "Supercharge your macOS workflow with SummarizeURLAI. Offline webpage and article summarizer with 3 bullet takeaways.",
        "use_cases": [
            "Seamlessly access SummarizeURLAI from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "111-sqlquery-ai",
        "slug": "sqlquery-ai",
        "name": "SqlQueryAI",
        "cat": "AI & Dev",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Natural Lang",
        "desc": "Translates plain English requests into optimized SQL queries.",
        "pitch": "Instant SQLite database inspector in your menu bar. Drag and drop any .sqlite, .db, or CoreData store to run queries, inspect tables, and export data in 1 second.",
        "use_cases": [
            "Inspect iOS app CoreData stores, Chrome history databases, or local SQLite caches.",
            "Run ad-hoc SQL queries with syntax highlighting and instant CSV export.",
            "Inspect schema table structures, foreign keys, and index efficiency."
        ],
        "how_it_works": "Wraps libsqlite3 native C-bindings directly in Swift. Opens files in read-only immutable mode to prevent corruption. Executes queries asynchronously and displays results in an optimized virtualized SwiftUI Table view capable of rendering 100,000+ rows smoothly.",
        "features": [
            "Direct libsqlite3 C-engine integration for blazing query speeds",
            "Drag-and-drop file inspection (.sqlite, .db, .sqlite3)",
            "Interactive SQL query console with auto-completion",
            "Export query results to CSV, JSON, and Markdown",
            "Schema diagram and index visualizer"
        ]
    },
    {
        "id": "112-localembeddings-search",
        "slug": "localembeddings-search",
        "name": "LocalEmbeddingsSearch",
        "cat": "AI & Dev",
        "price": "$16",
        "priceNum": 16,
        "hotkey": "Semantic",
        "desc": "Semantic vector search across local folders using local CoreML embeddings.",
        "pitch": "Supercharge your macOS workflow with LocalEmbeddingsSearch. Semantic vector search across local folders using local CoreML embeddings.",
        "use_cases": [
            "Seamlessly access LocalEmbeddingsSearch from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "113-diffexplainer-ai",
        "slug": "diffexplainer-ai",
        "name": "DiffExplainerAI",
        "cat": "AI & Dev",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Changelog",
        "desc": "Analyzes git diffs to generate clean release notes and changelogs.",
        "pitch": "Supercharge your macOS workflow with DiffExplainerAI. Analyzes git diffs to generate clean release notes and changelogs.",
        "use_cases": [
            "Seamlessly access DiffExplainerAI from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "114-readaloud-tts",
        "slug": "readaloud-tts",
        "name": "ReadAloudTTS",
        "cat": "AI & Voice",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Speech",
        "desc": "Ultra-natural text-to-speech voice reader for selected articles and code comments.",
        "pitch": "Supercharge your macOS workflow with ReadAloudTTS. Ultra-natural text-to-speech voice reader for selected articles and code comments.",
        "use_cases": [
            "Seamlessly access ReadAloudTTS from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "115-regexgenerator-ai",
        "slug": "regexgenerator-ai",
        "name": "RegexGeneratorAI",
        "cat": "AI & Dev",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "AI Gen",
        "desc": "Converts plain English descriptions into tested, production-ready regular expressions.",
        "pitch": "Supercharge your macOS workflow with RegexGeneratorAI. Converts plain English descriptions into tested, production-ready regular expressions.",
        "use_cases": [
            "Seamlessly access RegexGeneratorAI from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "116-kubecluster-quick",
        "slug": "kubecluster-quick",
        "name": "KubeClusterQuick",
        "cat": "Developer",
        "price": "$16",
        "priceNum": 16,
        "hotkey": "Menu Bar",
        "desc": "Minimalist Kubernetes cluster status watcher with 1-click pod log viewing.",
        "pitch": "Manage Kubernetes clusters without terminal bloat. KubeCluster Quick provides an instant menu-bar HUD to monitor pod health, stream logs, switch contexts, and restart crashing deployments in 1 click.",
        "use_cases": [
            "Instantly switch between dev, staging, and prod kube contexts without running `kubectl config use-context`.",
            "Detect crashing CrashLoopBackOff pods with instant red status bar badges.",
            "1-click tail logs from failing microservices during incident response."
        ],
        "how_it_works": "Parses ~/.kube/config to load clusters and namespaces. Executes lightweight non-blocking JSON queries against the active cluster endpoint. Renders pod health, CPU/Memory telemetry, and deployment rollouts in a SwiftUI liquid glass HUD. Provides 1-click `kubectl rollout restart` triggers.",
        "features": [
            "Instant Context & Namespace switcher in menu bar",
            "Live Pod health monitor with CrashLoopBackOff alerts",
            "1-Click Pod Log Streamer & JSON Inspector",
            "Restart deployment and port-forwarding shortcuts",
            "Zero background battery drain"
        ]
    },
    {
        "id": "117-redislens",
        "slug": "redislens",
        "name": "RedisLens",
        "cat": "Developer",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Menu Bar",
        "desc": "Menu bar Redis key-value browser, TTL inspector, and memory analyzer.",
        "pitch": "Ultra-fast Redis & KeyDB database explorer in your menu bar. View active keys, inspect TTL expirations, edit JSON/strings, and monitor live operations/sec without heavy Electron memory pigs.",
        "use_cases": [
            "Flush cache keys or inspect session tokens during local web backend testing.",
            "Monitor live memory fragmentation and ops/sec telemetry.",
            "Search millions of keys with instant SCAN pattern matching."
        ],
        "how_it_works": "Implements a lightweight asynchronous RESP (REdis Serialization Protocol) socket client in native Swift using Network.framework. Queries INFO, SCAN, and TTL commands without blocking the main thread. Renders key hierarchies in a SwiftUI tree view.",
        "features": [
            "Ultra-fast native RESP protocol client",
            "Live Memory, Hit Rate, and Ops/sec gauges",
            "Key browser with String, Hash, List, Set, and JSON editors",
            "1-Click FlushDB / FlushAll with confirmation guard",
            "SSH Tunnel & TLS connection support"
        ]
    },
    {
        "id": "118-gitstash-manager",
        "slug": "gitstash-manager",
        "name": "GitStashManager",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325 S",
        "desc": "Visual UI for viewing, comparing, applying, and dropping local git stashes.",
        "pitch": "Supercharge your Git workflow. Multi-repo status bar monitors, AI commit message generators from staged diffs, and instant branch synchronizers tailored for high-output engineering teams.",
        "use_cases": [
            "Generate clean Conventional Commits ('feat(auth): add OAuth2 token refresh') from git diff in 1 click.",
            "Monitor 50+ local repos simultaneously for uncommitted files and unpushed commits.",
            "1-click sync and branch cleanups across all microservice directories."
        ],
        "how_it_works": "Executes non-blocking libgit2 / git CLI sub-processes via Foundation.Process to inspect staged changes. Sends diff hunks through local LLM or heuristics to draft commit messages according to Conventional Commits specifications, and commits via git commit -m.",
        "features": [
            "AI Conventional Commit generator from staged diffs",
            "Multi-repo dirty-file status bar radar",
            "1-Click Stash, Pull, and Push shortcuts",
            "Interactive visual branch switcher",
            "Works 100% offline with local regex or CoreML models"
        ]
    },
    {
        "id": "119-portforwarder-pro",
        "slug": "portforwarder-pro",
        "name": "PortForwarderPro",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Tunnel",
        "desc": "SSH tunnel and local port forwarding manager with auto-reconnect.",
        "pitch": "Supercharge your macOS workflow with PortForwarderPro. SSH tunnel and local port forwarding manager with auto-reconnect.",
        "use_cases": [
            "Seamlessly access PortForwarderPro from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "120-apimock-server",
        "slug": "apimock-server",
        "name": "ApiMockServer",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": ":4000",
        "desc": "1-click local mock HTTP server with custom latency and status simulation.",
        "pitch": "Supercharge your macOS workflow with ApiMockServer. 1-click local mock HTTP server with custom latency and status simulation.",
        "use_cases": [
            "Seamlessly access ApiMockServer from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "121-dotenv-diff",
        "slug": "dotenv-diff",
        "name": "DotEnvDiff",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Verify",
        "desc": "Compares .env.example against actual .env and flags missing keys before push.",
        "pitch": "Supercharge your macOS workflow with DotEnvDiff. Compares .env.example against actual .env and flags missing keys before push.",
        "use_cases": [
            "Seamlessly access DotEnvDiff from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "122-dnslookup-hud",
        "slug": "dnslookup-hud",
        "name": "DnsLookupHUD",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "DNS",
        "desc": "Instant DNS record inspector (A, CNAME, MX, TXT) with global node propagation test.",
        "pitch": "Supercharge your macOS workflow with DnsLookupHUD. Instant DNS record inspector (A, CNAME, MX, TXT) with global node propagation test.",
        "use_cases": [
            "Seamlessly access DnsLookupHUD from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "123-httpheader-inspector",
        "slug": "httpheader-inspector",
        "name": "HttpHeaderInspector",
        "cat": "Developer",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "CORS/SSL",
        "desc": "Tests HTTP/HTTPS response headers, CORS policies, and SSL handshakes.",
        "pitch": "Supercharge your macOS workflow with HttpHeaderInspector. Tests HTTP/HTTPS response headers, CORS policies, and SSL handshakes.",
        "use_cases": [
            "Seamlessly access HttpHeaderInspector from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "124-icongrid-overlay",
        "slug": "icongrid-overlay",
        "name": "IconGridOverlay",
        "cat": "Creative & Design",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Grid",
        "desc": "Pixel-perfect icon grid overlay for designing 512x512 and 1024x1024 app icons.",
        "pitch": "Supercharge your macOS workflow with IconGridOverlay. Pixel-perfect icon grid overlay for designing 512x512 and 1024x1024 app icons.",
        "use_cases": [
            "Seamlessly access IconGridOverlay from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "125-contrastpalette-studio",
        "slug": "contrastpalette-studio",
        "name": "ContrastPaletteStudio",
        "cat": "Creative & Design",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "WCAG AAA",
        "desc": "Creates accessible, harmonious color systems meeting WCAG AAA requirements.",
        "pitch": "Supercharge your macOS workflow with ContrastPaletteStudio. Creates accessible, harmonious color systems meeting WCAG AAA requirements.",
        "use_cases": [
            "Seamlessly access ContrastPaletteStudio from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "126-gradientmesh-maker",
        "slug": "gradientmesh-maker",
        "name": "GradientMeshMaker",
        "cat": "Creative & Design",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Mesh",
        "desc": "Visual multi-point gradient mesh generator with real-time SwiftUI curve export.",
        "pitch": "Supercharge your macOS workflow with GradientMeshMaker. Visual multi-point gradient mesh generator with real-time SwiftUI curve export.",
        "use_cases": [
            "Seamlessly access GradientMeshMaker from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "127-diskscleaner-mini",
        "slug": "diskscleaner-mini",
        "name": "DisksCleanerMini",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Scan",
        "desc": "Visualizes large downloads, node_modules, and cache folders for selective 1-click purge.",
        "pitch": "Supercharge your macOS workflow with DisksCleanerMini. Visualizes large downloads, node_modules, and cache folders for selective 1-click purge.",
        "use_cases": [
            "Seamlessly access DisksCleanerMini from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "128-bluetoothsignal-radar",
        "slug": "bluetoothsignal-radar",
        "name": "BluetoothSignalRadar",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "RSSI",
        "desc": "Signal strength (RSSI) monitor for AirPods and mice with disconnect alerts.",
        "pitch": "Supercharge your macOS workflow with BluetoothSignalRadar. Signal strength (RSSI) monitor for AirPods and mice with disconnect alerts.",
        "use_cases": [
            "Seamlessly access BluetoothSignalRadar from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "129-batterycycle-telemetry",
        "slug": "batterycycle-telemetry",
        "name": "BatteryCycleTelemetry",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "SMC",
        "desc": "Deep SMC battery analytics: degradation curve, wattage telemetry, and cycles.",
        "pitch": "Supercharge your macOS workflow with BatteryCycleTelemetry. Deep SMC battery analytics: degradation curve, wattage telemetry, and cycles.",
        "use_cases": [
            "Seamlessly access BatteryCycleTelemetry from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    },
    {
        "id": "130-appquarantine-inspector",
        "slug": "appquarantine-inspector",
        "name": "AppQuarantineInspector",
        "cat": "Utilities & System",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Gatekeeper",
        "desc": "Lists quarantine attributes (com.apple.quarantine) with 1-click override.",
        "pitch": "Supercharge your macOS workflow with AppQuarantineInspector. Lists quarantine attributes (com.apple.quarantine) with 1-click override.",
        "use_cases": [
            "Seamlessly access AppQuarantineInspector from your menu bar or global shortcut to eliminate daily friction.",
            "Automate repetitive manual operations with instant native Apple Silicon execution.",
            "Maintain 100% offline security, zero cloud telemetry, and zero background battery drain."
        ],
        "how_it_works": "Engineered natively in Swift 6 and SwiftUI, leveraging modern macOS AppKit lifecycle APIs (NSStatusItem, NSPanel, or Background daemons). Utilizes low-level system frameworks with zero Electron bloat, maintaining a memory footprint of under 15MB and near-zero CPU usage.",
        "features": [
            "100% Native Swift 6 & SwiftUI architecture",
            "Apple Silicon M1/M2/M3/M4 hardware acceleration",
            "Global customizable keyboard shortcuts",
            "Liquid glass aesthetic with dark/light mode support",
            "Offline HMAC cryptographic license verification for up to 5 Macs"
        ]
    }
]

js_content = f'''// MacUpgraded.com - Complete Catalog & Multi-App Cart Engine
const apps = {json.dumps(all_formatted_apps, indent=4)};

// State
let activeCategory = "all";
let searchTerm = "";
let currentSelectedApp = null;
let cart = JSON.parse(localStorage.getItem("macupgraded_cart") || "[]");

// DOM Elements
const appsGrid = document.getElementById("appsGrid");
const searchInput = document.getElementById("appSearchInput");
const categoryPills = document.querySelectorAll(".pill");
const paymentModal = document.getElementById("paymentModal");
const cartModal = document.getElementById("cartModal");

// Floating Cart Elements
const floatingCartBtn = document.getElementById("floatingCartBtn");
const floatingCartCount = document.getElementById("floatingCartCount");
const floatingCartTotal = document.getElementById("floatingCartTotal");
const navCartCountElements = document.querySelectorAll(".nav-cart-count");

// Single App Modal Elements
const modalAppName = document.getElementById("modalAppName");
const modalAppPrice = document.getElementById("modalAppPrice");
const modalAppDesc = document.getElementById("modalAppDesc");
const checkoutEmail = document.getElementById("checkoutEmail");
const payAppleBtn = document.getElementById("payAppleBtn");
const payCardBtn = document.getElementById("payCardBtn");
const payPaypalBtn = document.getElementById("payPaypalBtn");
const checkoutStep1 = document.getElementById("checkoutStep1");
const checkoutStep2 = document.getElementById("checkoutStep2");
const licenseKeyDisplay = document.getElementById("licenseKeyDisplay");
const downloadLinkBtn = document.getElementById("downloadLinkBtn");
const copyLicenseBtn = document.getElementById("copyLicenseBtn");

// Cart Modal Elements
const cartItemsContainer = document.getElementById("cartItemsContainer");
const cartItemsCountText = document.getElementById("cartItemsCountText");
const cartSubtotalVal = document.getElementById("cartSubtotalVal");
const cartTotalVal = document.getElementById("cartTotalVal");
const cartCheckoutEmail = document.getElementById("cartCheckoutEmail");

function saveCart() {
    localStorage.setItem("macupgraded_cart", JSON.stringify(cart));
    updateCartUI();
}

function updateCartUI() {
    const totalCount = cart.length;
    const totalPrice = cart.reduce((sum, item) => sum + item.price, 0);

    navCartCountElements.forEach(el => el.textContent = totalCount);
    
    if (floatingCartBtn) {
        if (totalCount > 0) {
            floatingCartBtn.style.display = "flex";
            floatingCartCount.textContent = totalCount;
            floatingCartTotal.textContent = "$" + totalPrice;
        } else {
            floatingCartBtn.style.display = "none";
        }
    }

    renderCartItems();
}

function renderApps() {
    const filtered = apps.filter(app => {
        const matchesCategory = activeCategory === "all" || app.cat === activeCategory || app.id.includes(activeCategory);
        const matchesSearch = searchTerm === "" || 
            app.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.desc.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.pitch.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.cat.toLowerCase().includes(searchTerm.toLowerCase());
        return matchesCategory && matchesSearch;
    });

    if (filtered.length === 0) {
        appsGrid.innerHTML = `
            <div style="grid-column: 1/-1; text-align: center; padding: 60px 20px; color: var(--text-muted);">
                <h3>No apps match "${searchTerm}"</h3>
                <p>Try searching for "Whisper", "Hamster", "Bonsai", "Duck", "Focus", "Water", "Git", "SQL", or "Docker"</p>
            </div>
        `;
        return;
    }

    appsGrid.innerHTML = filtered.map(app => {
        const inCart = cart.some(item => item.slug === app.slug);
        return `
            <div class="app-card" data-category="${app.cat}">
                <div>
                    <div class="app-card-top">
                        <img src="assets/icons/${app.id}.svg" alt="${app.name}" class="app-vector-icon" loading="lazy" onerror="this.src='assets/icons/01-whispertap.svg'"/>
                        <div class="app-meta">
                            <div class="app-title-row">
                                <h3 class="app-name">${app.name}</h3>
                                <span class="app-cat-badge">${app.cat}</span>
                            </div>
                            <div class="app-hotkey">${app.hotkey}</div>
                        </div>
                    </div>

                    <p class="app-desc">${app.desc}</p>

                    <ul class="app-features">
                        ${app.features.slice(0, 3).map(f => `<li>${f}</li>`).join("")}
                    </ul>
                </div>

                <div class="app-card-footer">
                    <div class="app-price-tag">
                        <span class="price-val">${app.price}</span>
                        <span class="price-type">one-time</span>
                    </div>
                    <div class="card-actions">
                        <button class="btn btn-cart btn-sm" onclick="toggleCartItem('${app.slug}')">
                            ${inCart ? '✓ In Cart' : '+ Cart'}
                        </button>
                        <button class="btn btn-primary btn-sm" onclick="openCheckoutModal('${app.slug}')">
                            Buy Now
                        </button>
                    </div>
                </div>
            </div>
        `;
    }).join("");
}

// Add / Remove from Cart
window.toggleCartItem = function(slug) {
    const app = apps.find(a => a.slug === slug);
    if (!app) return;

    const idx = cart.findIndex(i => i.slug === slug);
    if (idx >= 0) {
        cart.splice(idx, 1);
    } else {
        cart.push({
            slug: app.slug,
            id: app.id,
            name: app.name,
            price: app.priceNum
        });
    }
    saveCart();
    renderApps();
};

window.removeFromCart = function(slug) {
    cart = cart.filter(i => i.slug !== slug);
    saveCart();
    renderApps();
};

// Render Cart Drawer
function renderCartItems() {
    if (!cartItemsContainer) return;

    if (cart.length === 0) {
        cartItemsContainer.innerHTML = `
            <div style="text-align: center; padding: 32px 10px; color: var(--text-muted);">
                <p style="font-size: 1.1rem; margin-bottom: 6px;">Your cart is empty</p>
                <p style="font-size: 0.85rem;">Click "+ Cart" on any app to bundle utilities together.</p>
            </div>
        `;
        cartItemsCountText.textContent = "0 apps selected";
        cartSubtotalVal.textContent = "$0";
        cartTotalVal.textContent = "$0";
        return;
    }

    const total = cart.reduce((sum, item) => sum + item.price, 0);

    cartItemsContainer.innerHTML = cart.map(item => `
        <div class="cart-item-row">
            <div class="cart-item-info">
                <img src="assets/icons/${item.id || ('01-' + item.slug)}.svg" class="cart-item-icon" onerror="this.src='assets/icons/01-whispertap.svg'"/>
                <div>
                    <div class="cart-item-name">${item.name}</div>
                    <div class="cart-item-price">$${item.price}</div>
                </div>
            </div>
            <button class="cart-item-remove" onclick="removeFromCart('${item.slug}')" title="Remove">&times;</button>
        </div>
    `).join("");

    cartItemsCountText.textContent = `${cart.length} app(s) in cart`;
    cartSubtotalVal.textContent = `$${total}`;
    cartTotalVal.textContent = `$${total}`;
}

// Open & Close Cart Modal
window.openCartModal = function() {
    updateCartUI();
    cartModal.classList.remove("hidden");
};

window.closeCartModal = function() {
    cartModal.classList.add("hidden");
};

// Open Single App Checkout Modal
window.openCheckoutModal = function(appSlug) {
    if (appSlug === "all-access") {
        currentSelectedApp = {
            slug: "all-access",
            name: "All-Access 130-App Lifetime Pass (Special Promo)",
            price: "$129",
            priceNum: 129,
            desc: "Instant lifetime access to ALL 130 native macOS applications + Universal Master License Key for up to 5 Macs (90% OFF regular $1,290+ value)."
        };
    } else {
        currentSelectedApp = apps.find(a => a.slug === appSlug);
    }

    if (!currentSelectedApp) return;

    modalAppName.textContent = currentSelectedApp.name;
    modalAppPrice.textContent = currentSelectedApp.price;
    modalAppDesc.innerHTML = `<strong>${currentSelectedApp.desc}</strong><br><br>${currentSelectedApp.pitch || ""}`;
    
    checkoutStep1.classList.remove("hidden");
    checkoutStep2.classList.add("hidden");
    paymentModal.classList.remove("hidden");
};

window.closePaymentModal = function() {
    paymentModal.classList.add("hidden");
};

// Checkout Multi-App Cart
window.checkoutCart = async function(paymentMethod) {
    if (cart.length === 0) {
        alert("Your cart is empty. Please add apps before checking out.");
        return;
    }

    const email = cartCheckoutEmail.value.trim();
    if (!email || !email.includes("@")) {
        alert("Please enter a valid email address for license key delivery.");
        cartCheckoutEmail.focus();
        return;
    }

    const btn = paymentMethod === "Apple Pay" ? document.getElementById("cartPayAppleBtn") : document.getElementById("cartPayCardBtn");
    const origText = btn.innerHTML;
    btn.innerHTML = "Connecting to Secure Gateway...";
    btn.disabled = true;

    try {
        const response = await fetch("api/create_stripe_checkout.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                email: email,
                items: cart
            })
        });

        const result = await response.json();

        if (result.success && result.checkoutUrl) {
            window.location.href = result.checkoutUrl;
        } else if (result.requires_config) {
            alert("⚠️ Payment Setup Required:\n\n" + result.error + "\n\nPaste your live Stripe API key into website/config.php on your Hostinger server.");
        } else {
            alert("Payment Gateway Error: " + (result.error || "Unable to initiate checkout session."));
        }
    } catch (e) {
        alert("⚠️ Backend Gateway Notice:\n\nTo process real payments, your website must be uploaded to your Hostinger server (macupgraded.com) with PHP support.");
    } finally {
        btn.innerHTML = origText;
        btn.disabled = false;
    }
};

// Process Single App Payment
async function processPayment(paymentMethod) {
    const email = checkoutEmail.value.trim();
    if (!email || !email.includes("@")) {
        alert("Please enter a valid email address so we can deliver your license key.");
        checkoutEmail.focus();
        return;
    }
    
    const activeBtn = paymentMethod === "Apple Pay" ? payAppleBtn : (paymentMethod === "PayPal" ? payPaypalBtn : payCardBtn);
    const origText = activeBtn.innerHTML;
    activeBtn.innerHTML = "Connecting to Secure Gateway...";
    activeBtn.disabled = true;

    try {
        const response = await fetch("api/create_stripe_checkout.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                email: email,
                app: currentSelectedApp.slug,
                tier: currentSelectedApp.slug === "all-access" ? "ALL_ACCESS" : "INDIVIDUAL",
                name: currentSelectedApp.name,
                price: currentSelectedApp.priceNum
            })
        });

        const result = await response.json();

        if (result.success && result.checkoutUrl) {
            window.location.href = result.checkoutUrl;
        } else if (result.requires_config) {
            alert("⚠️ Payment Setup Required:\n\n" + result.error + "\n\nTo accept real payments into your bank account, simply paste your live Stripe API key into website/config.php on your Hostinger server.");
        } else {
            alert("Payment Gateway Error: " + (result.error || "Unable to initiate checkout session. Please try again."));
        }
    } catch (e) {
        alert("⚠️ Backend Gateway Notice:\n\nTo process real payments, your website must be uploaded to your Hostinger server (macupgraded.com) with PHP support.");
    } finally {
        activeBtn.innerHTML = origText;
        activeBtn.disabled = false;
    }
}

payAppleBtn.addEventListener("click", () => processPayment("Apple Pay"));
payCardBtn.addEventListener("click", () => processPayment("Credit/Debit Card (Stripe)"));
payPaypalBtn.addEventListener("click", () => processPayment("PayPal"));

if (copyLicenseBtn) {
    copyLicenseBtn.addEventListener("click", () => {
        navigator.clipboard.writeText(licenseKeyDisplay.textContent).then(() => {
            copyLicenseBtn.textContent = "✓ Copied!";
            setTimeout(() => { copyLicenseBtn.textContent = "Copy Key"; }, 1500);
        });
    });
}

// Category filter
categoryPills.forEach(pill => {
    pill.addEventListener("click", () => {
        categoryPills.forEach(p => p.classList.remove("active"));
        pill.classList.add("active");
        activeCategory = pill.getAttribute("data-category");
        renderApps();
    });
});

// Search filter with debounce
let debounceTimer;
searchInput.addEventListener("input", (e) => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {
        searchTerm = e.target.value.trim();
        renderApps();
    }, 150);
});

// Hero Liquid Dock Quick Search
window.searchAppHero = function(term) {
    document.querySelectorAll(".dock-item").forEach(btn => {
        if (btn.textContent.includes(term)) {
            btn.classList.add("active");
        } else {
            btn.classList.remove("active");
        }
    });

    if (searchInput) {
        searchInput.value = term;
        searchTerm = term;
        renderApps();
        document.getElementById("apps")?.scrollIntoView({ behavior: "smooth" });
    }
};

// Initialize
renderApps();
updateCartUI();
'''

with open("website/app.js", "w") as f:
    f.write(js_content)

print("✅ Generated website/app.js with rich product descriptions for all 130 apps!")
