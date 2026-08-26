// Complete Catalog for all 130 Native macOS Apps
const apps = [
    {
        "id": "01-whispertap",
        "name": "WhisperTap",
        "cat": "ai",
        "catName": "AI & Voice",
        "icon": "\ud83c\udf99\ufe0f",
        "hotkey": "\u2325 Space",
        "desc": "Global push-to-talk AI dictation into any text field via Apple Silicon MLX WhisperKit.",
        "features": [
            "100% Offline & Private",
            "Auto-paste into focused app",
            "Code & Dev mode cleanup"
        ],
        "brew": "brew install --cask whispertap",
        "dmg": "downloads/whispertap-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "02-tokenwatch",
        "name": "TokenWatch",
        "cat": "ai",
        "catName": "AI & Dev",
        "icon": "\ud83d\udcb3",
        "hotkey": "Menu Bar",
        "desc": "Menu bar real-time LLM API spend & rate-limit monitor for OpenAI, Anthropic, Gemini & Groq.",
        "features": [
            "Live status bar cost ticker",
            "Budget limit alerts",
            "Per-project token tracking"
        ],
        "brew": "brew install --cask tokenwatch",
        "dmg": "downloads/tokenwatch-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "03-locallens-ocr",
        "name": "LocalLens OCR",
        "cat": "ai",
        "catName": "AI & Vision",
        "icon": "\ud83d\udd0d",
        "hotkey": "\u2318 \u21e7 2",
        "desc": "Instant screen-to-code, JSON, LaTeX, and table extractor with regex formatting.",
        "features": [
            "Vision Neural Engine OCR",
            "Code syntax formatting",
            "Zero line-wrap distortion"
        ],
        "brew": "brew install --cask locallens-ocr",
        "dmg": "downloads/locallens-ocr-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "04-portsentry",
        "name": "PortSentry",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\ud83c\udf10",
        "hotkey": "Menu Bar",
        "desc": "Active port & zombie process killer. Shows listening ports, process PIDs, and 1-click kill.",
        "features": [
            "Instant port release",
            "PID & memory inspector",
            "1-click browser preview"
        ],
        "brew": "brew install --cask portsentry",
        "dmg": "downloads/portsentry-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "05-shrinkmedia",
        "name": "ShrinkMedia",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\ud83d\udddc\ufe0f",
        "hotkey": "Drag & Drop",
        "desc": "Fast drag-and-drop batch video/audio/image compressor using hardware VideoToolbox.",
        "features": [
            "Up to 88% size reduction",
            "Lossless GIF & MP4 export",
            "Apple Silicon HW encoder"
        ],
        "brew": "brew install --cask shrinkmedia",
        "dmg": "downloads/shrinkmedia-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "06-colorforge",
        "name": "ColorForge",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\ud83c\udfa8",
        "hotkey": "\u2318 \u21e7 C",
        "desc": "Native eyedropper, palette builder, and WCAG 2.2 AAA contrast compliance checker.",
        "features": [
            "1-click SwiftUI/CSS/Hex export",
            "Global screen magnifier",
            "Palette history sync"
        ],
        "brew": "brew install --cask colorforge",
        "dmg": "downloads/colorforge-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "07-notchshelf",
        "name": "NotchShelf",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\ud83d\udce5",
        "hotkey": "Top Bezel",
        "desc": "Smart drop-zone & staging area hidden inside the MacBook notch for files, links & screenshots.",
        "features": [
            "Zero desktop clutter",
            "Smooth hover reveal",
            "Drag-to-Slack/Terminal"
        ],
        "brew": "brew install --cask notchshelf",
        "dmg": "downloads/notchshelf-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "08-audiomix",
        "name": "AudioMix",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\ud83c\udf9a\ufe0f",
        "hotkey": "Menu Bar",
        "desc": "Per-app volume mixer & independent audio output routing without virtual cables.",
        "features": [
            "Per-application sliders",
            "Zero latency CoreAudio",
            "Quick device routing"
        ],
        "brew": "brew install --cask audiomix",
        "dmg": "downloads/audiomix-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "09-micmute-hud",
        "name": "MicMute HUD",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\ud83d\udd07",
        "hotkey": "\u2318 \u21e7 M",
        "desc": "Universal hardware mic mute & camera blackout indicator with on-screen dynamic pill.",
        "features": [
            "Works across Zoom/Meet/Teams",
            "Audio feedback cues",
            "Always-on-top pill"
        ],
        "brew": "brew install --cask micmute-hud",
        "dmg": "downloads/micmute-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "10-promptdock",
        "name": "PromptDock",
        "cat": "ai",
        "catName": "AI & Voice",
        "icon": "\u2728",
        "hotkey": "\u2325 P",
        "desc": "Global floating prompt HUD and snippet palette with dynamic variable interpolation.",
        "features": [
            "Instant clipboard injection",
            "Dynamic {{variables}}",
            "Categorized prompt library"
        ],
        "brew": "brew install --cask promptdock",
        "dmg": "downloads/promptdock-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "11-snaptile",
        "name": "SnapTile",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\ud83e\ude9f",
        "hotkey": "\u2303 \u2325 Arrows",
        "desc": "Hyper-lightweight, zero-latency keyboard & edge window tiling manager with grid layouts.",
        "features": [
            "Zero battery drain",
            "Custom inner gaps",
            "Multi-monitor smart snapping"
        ],
        "brew": "brew install --cask snaptile",
        "dmg": "downloads/snaptile-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "12-purgeapp",
        "name": "PurgeApp",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\ud83d\uddd1\ufe0f",
        "hotkey": "Drag & Drop",
        "desc": "Deep uninstaller that tracks and cleans hidden caches, plists, launch agents, and containers.",
        "features": [
            "Finds orphaned residue",
            "Reclaims GBs of disk space",
            "Safe trash rollback"
        ],
        "brew": "brew install --cask purgeapp",
        "dmg": "downloads/purgeapp-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "13-chargeguard",
        "name": "ChargeGuard",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "\ud83d\udd0b",
        "hotkey": "Menu Bar",
        "desc": "Battery health optimizer, custom 80% charge limiter, and real-time wattage telemetry.",
        "features": [
            "Extends battery lifespan",
            "Real-time cycle counter",
            "SMC hardware control"
        ],
        "brew": "brew install --cask chargeguard",
        "dmg": "downloads/chargeguard-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "14-envvault",
        "name": "EnvVault",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\ud83d\udd10",
        "hotkey": "Menu Bar",
        "desc": "Secure .env & API key workspace manager with quick paste, encryption, and zero-leak validation.",
        "features": [
            "Dev/Staging/Prod profiles",
            "Masked secret viewer",
            "1-click .env clipboard copy"
        ],
        "brew": "brew install --cask envvault",
        "dmg": "downloads/envvault-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "15-devtunnel-hud",
        "name": "DevTunnel HUD",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\ud83d\ude87",
        "hotkey": "Menu Bar",
        "desc": "Menu bar manager & traffic inspector for Cloudflare Tunnels, Ngrok, and Localtunnel.",
        "features": [
            "Live request inspector",
            "1-click public URL copy",
            "Webhook payload replay"
        ],
        "brew": "brew install --cask devtunnel-hud",
        "dmg": "downloads/devtunnel-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "16-gitpulse",
        "name": "GitPulse",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\ud83c\udf3f",
        "hotkey": "Menu Bar",
        "desc": "Multi-repo status bar tracker for 50+ git repos: uncommitted changes, sync, and PRs.",
        "features": [
            "Scans local projects",
            "Dirty file notifications",
            "1-click pull/stash"
        ],
        "brew": "brew install --cask gitpulse",
        "dmg": "downloads/gitpulse-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "17-regexforge",
        "name": "RegexForge",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\ud83d\udd23",
        "hotkey": "HUD",
        "desc": "Native Swift live regex debugger & visual tester with instant multi-language code export.",
        "features": [
            "Live match highlighting",
            "Swift/Python/JS generators",
            "Preset pattern library"
        ],
        "brew": "brew install --cask regexforge",
        "dmg": "downloads/regexforge-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "18-svgoptim",
        "name": "SVGOptim",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\ud83d\udcd0",
        "hotkey": "Drag & Drop",
        "desc": "Zero-bloat SVG optimizer, cleaner, and SVG-to-SwiftUI / React component converter.",
        "features": [
            "60%+ SVG size reduction",
            "SwiftUI Shape generation",
            "Clean JSX component output"
        ],
        "brew": "brew install --cask svgoptim",
        "dmg": "downloads/svgoptim-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "19-fontinspect",
        "name": "FontInspect",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\ud83d\udd24",
        "hotkey": "Menu Bar",
        "desc": "Local font viewer, glyph explorer, variable font axis tester, and typography comparer.",
        "features": [
            "Variable font sliders",
            "Glyph unicode inspector",
            "Side-by-side pairing preview"
        ],
        "brew": "brew install --cask fontinspect",
        "dmg": "downloads/fontinspect-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "20-presentercam",
        "name": "PresenterCam",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\ud83d\udcf7",
        "hotkey": "\u2318 \u21e7 P",
        "desc": "Floating camera overlay with background blur, zoom, pointer spotlight, and drawing canvas.",
        "features": [
            "Loom/Demo ready",
            "Neural blur & circular mask",
            "Cursor spotlight tracker"
        ],
        "brew": "brew install --cask presentercam",
        "dmg": "downloads/presentercam-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "21-cleandesk-pro",
        "name": "CleanDesk Pro",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u2728",
        "hotkey": "1-Click",
        "desc": "1-click presentation mode: hides desktop icons, silences notifications, sets clean background.",
        "features": [
            "Instant screen privacy",
            "DND auto-activation",
            "Restores setup in 1 click"
        ],
        "brew": "brew install --cask cleandesk-pro",
        "dmg": "downloads/cleandesk-pro-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "22-screenruler",
        "name": "ScreenRuler",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\ud83d\udccf",
        "hotkey": "Crosshair",
        "desc": "Precision on-screen pixel measurement ruler, alignment crosshair, and padding inspector.",
        "features": [
            "Sub-pixel measurement",
            "Guides and snap lines",
            "Instant hex color on hover"
        ],
        "brew": "brew install --cask screenruler",
        "dmg": "downloads/screenruler-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "23-apphop",
        "name": "AppHop",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 `",
        "desc": "Quick-switch popup that lets you jump between open windows of ONLY the active app.",
        "features": [
            "Number key switching",
            "Zero lag window focus",
            "Works across spaces"
        ],
        "brew": "brew install --cask apphop",
        "dmg": "downloads/apphop-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "24-scratchpad-hud",
        "name": "ScratchPad HUD",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\ud83d\udcdd",
        "hotkey": "\u2325 N",
        "desc": "Always-on-top markdown scratchpad with instant cloud/local file export and quick-hide shortcut.",
        "features": [
            "Markdown preview",
            "Persistent auto-save",
            "Global popup anywhere"
        ],
        "brew": "brew install --cask scratchpad-hud",
        "dmg": "downloads/scratchpad-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "25-timebridge",
        "name": "TimeBridge",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "\ud83d\udd52",
        "hotkey": "Menu Bar",
        "desc": "Visual timezone slider and meeting overlap calculator in the menu bar with world clocks.",
        "features": [
            "Interactive time scrub bar",
            "Team availability overlap",
            "Copy scheduled slot"
        ],
        "brew": "brew install --cask timebridge",
        "dmg": "downloads/timebridge-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "26-menucleaner",
        "name": "MenuCleaner",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\ud83c\udf71",
        "hotkey": "Menu Bar",
        "desc": "Lightweight menu bar icon manager that auto-hides overflow items behind a smooth divider.",
        "features": [
            "Reclaims notch space",
            "Auto-hide timer",
            "Drag to organize"
        ],
        "brew": "brew install --cask menucleaner",
        "dmg": "downloads/menucleaner-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "27-metascrub",
        "name": "MetaScrub",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\ud83d\udee1\ufe0f",
        "hotkey": "Drag & Drop",
        "desc": "Instant drag-and-drop EXIF, GPS location, and privacy metadata stripper for photos & PDFs.",
        "features": [
            "Strips camera serials & GPS",
            "Lossless image rewrite",
            "Batch folder processing"
        ],
        "brew": "brew install --cask metascrub",
        "dmg": "downloads/metascrub-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "28-bandwidthradar",
        "name": "BandwidthRadar",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\ud83d\udce1",
        "hotkey": "Menu Bar",
        "desc": "Real-time per-app network download/upload traffic monitor in the menu bar with rogue alerts.",
        "features": [
            "Live KB/s & MB/s in status bar",
            "Per-process data usage",
            "Bandwidth hog alerts"
        ],
        "brew": "brew install --cask bandwidthradar",
        "dmg": "downloads/bandwidthradar-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "29-bluetoothautohop",
        "name": "BluetoothAutoHop",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\ud83c\udfa7",
        "hotkey": "Automated",
        "desc": "Smart Bluetooth manager that auto-disconnects on sleep, auto-reconnects on wake, shows battery.",
        "features": [
            "No more sleep battery drain",
            "Instant AirPods switch",
            "Menu bar battery levels"
        ],
        "brew": "brew install --cask bluetoothautohop",
        "dmg": "downloads/bluetoothautohop-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "30-privatellm-bar",
        "name": "PrivateLLM Bar",
        "cat": "ai",
        "catName": "AI & Voice",
        "icon": "\ud83e\udde0",
        "hotkey": "Menu Bar",
        "desc": "Ultra-lightweight menu bar local model runner using MLX / llama.cpp for instant offline AI.",
        "features": [
            "100% Offline & Private",
            "Zero cloud API fees",
            "Apple Silicon Metal accelerated"
        ],
        "brew": "brew install --cask privatellm-bar",
        "dmg": "downloads/privatellm-bar-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "31-petpals-desktop",
        "name": "PetPalsDesktop",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "PetPal",
        "hotkey": "On Desktop",
        "desc": "Interactive desktop pet that walks on windows, sleeps during focus sessions, and nudges hydration.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask petpals-desktop",
        "dmg": "downloads/petpals-desktop-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "32-bonsaigrow",
        "name": "BonsaiGrow",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "Bonsai",
        "hotkey": "Menu Bar",
        "desc": "Virtual Zen Bonsai tree that grows lush leaves with completed focus sessions and withers if distracted.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask bonsaigrow",
        "dmg": "downloads/bonsaigrow-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "33-deskfish-aquarium",
        "name": "DeskFishAquarium",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "Aquarium",
        "hotkey": "Floating HUD",
        "desc": "Floating translucent mini-aquarium HUD with fish whose health depends on daily habit streaks.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask deskfish-aquarium",
        "dmg": "downloads/deskfish-aquarium-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "34-pomodorodragon",
        "name": "PomodoroDragon",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "Dragon",
        "hotkey": "25m Cycle",
        "desc": "RPG Pomodoro egg that hatches into unique elemental dragons as you complete 25-minute focus cycles.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask pomodorodragon",
        "dmg": "downloads/pomodorodragon-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "35-codecat",
        "name": "CodeCat",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "CodeCat",
        "hotkey": "Window Edge",
        "desc": "Animated cat sitting on your active terminal or Xcode window edge, purring on Git commits and test passes.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask codecat",
        "dmg": "downloads/codecat-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "36-deepflow-blocker",
        "name": "DeepFlowBlocker",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "Shield",
        "hotkey": "\u2325 F",
        "desc": "Host and process-level distraction website & social app killer with emergency unblock math friction puzzles.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask deepflow-blocker",
        "dmg": "downloads/deepflow-blocker-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "37-zenaudio-ambience",
        "name": "ZenAudioAmbience",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "Zen",
        "hotkey": "Menu Bar",
        "desc": "Binaural beats, brown noise, lo-fi coffee shop, and rain generator with 432Hz focus frequencies.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask zenaudio-ambience",
        "dmg": "downloads/zenaudio-ambience-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "38-screendimmer-focus",
        "name": "ScreenDimmerFocus",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 D",
        "desc": "Spotlights your active window and dims/blurs background windows on all connected displays.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask screendimmer-focus",
        "dmg": "downloads/screendimmer-focus-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "39-breakreminder",
        "name": "BreakReminder",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "20-20-20",
        "hotkey": "Timer",
        "desc": "20-20-20 eye strain rule & ergonomic stretch coach with screen fade micro-pauses.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask breakreminder",
        "dmg": "downloads/breakreminder-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "40-monospace-flow",
        "name": "MonoSpaceFlow",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 T",
        "desc": "Full-screen minimalist typewriter mode with mechanical keyboard audio feedback.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask monospace-flow",
        "dmg": "downloads/monospace-flow-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "41-habitgrid",
        "name": "HabitGrid",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "Habits",
        "hotkey": "Menu Bar",
        "desc": "GitHub-style 365-day contribution heatmaps for personal daily habits in the menu bar.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask habitgrid",
        "dmg": "downloads/habitgrid-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "42-waterdrop-hud",
        "name": "WaterDropHUD",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "\u26a1\ufe0f",
        "hotkey": "1-Click",
        "desc": "Smart hydration tracker with 1-click water logging, reminders, and daily goal telemetry.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask waterdrop-hud",
        "dmg": "downloads/waterdrop-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "43-postureguard",
        "name": "PostureGuard",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "Posture",
        "hotkey": "Camera",
        "desc": "Uses local Apple Vision pose estimation to alert when slouching without storing or streaming any video.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask postureguard",
        "dmg": "downloads/postureguard-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "44-standup-timer",
        "name": "StandUpTimer",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "Stand",
        "hotkey": "Timer",
        "desc": "Standing desk timer with posture intervals and smart desk Bluetooth auto-sync.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask standup-timer",
        "dmg": "downloads/standup-timer-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "45-dayplanner-notch",
        "name": "DayPlannerNotch",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "Schedule",
        "hotkey": "Notch",
        "desc": "Visual timeline of today's calendar events & time-blocks rendered directly in the MacBook notch.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask dayplanner-notch",
        "dmg": "downloads/dayplanner-notch-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "46-statussync",
        "name": "StatusSync",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "Status",
        "hotkey": "Auto",
        "desc": "Auto-syncs Slack, Discord, and Teams status based on active app or calendar event.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask statussync",
        "dmg": "downloads/statussync-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "47-quicktweet-x",
        "name": "QuickTweetX",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 X",
        "desc": "Floating HUD to draft and schedule posts to X, Bluesky, Threads, and Mastodon in one shot.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask quicktweet-x",
        "dmg": "downloads/quicktweet-x-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "48-dminbox-unified",
        "name": "DMInboxUnified",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "DMs",
        "hotkey": "Menu Bar",
        "desc": "Unified menu bar badge & preview for Slack, Discord, Telegram, and WhatsApp messages.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask dminbox-unified",
        "dmg": "downloads/dminbox-unified-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "49-streamerbanner",
        "name": "StreamerBanner",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "HUD",
        "desc": "Animated lower-thirds, watermark, and ticker for screen recordings and live streaming.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask streamerbanner",
        "dmg": "downloads/streamerbanner-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "50-emojiforge",
        "name": "EmojiForge",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2318 .",
        "desc": "Floating emoji & kaomoji picker with custom Slack/Discord emoji batch uploader & resizer.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask emojiforge",
        "dmg": "downloads/emojiforge-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "51-pdfwhisper-ai",
        "name": "PDFWhisperAI",
        "cat": "ai",
        "catName": "AI & Vision",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Drop PDF",
        "desc": "Instant local Q&A with PDFs via Apple Silicon embeddings & CoreML (100% offline).",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask pdfwhisper-ai",
        "dmg": "downloads/pdfwhisper-ai-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "52-gitcommit-ai",
        "name": "GitCommitAI",
        "cat": "ai",
        "catName": "AI & Dev",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 C",
        "desc": "1-click conventional git commit message generator from active unstaged/staged diffs.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask gitcommit-ai",
        "dmg": "downloads/gitcommit-ai-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "53-codeexplainer-hud",
        "name": "CodeExplainerHUD",
        "cat": "ai",
        "catName": "AI & Dev",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Highlight",
        "desc": "Highlight any cryptic code, regex, or error on screen and get an instant plain-English breakdown.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask codeexplainer-hud",
        "dmg": "downloads/codeexplainer-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "54-voicetranscribe-batch",
        "name": "VoiceTranscribeBatch",
        "cat": "ai",
        "catName": "AI & Voice",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Drop Audio",
        "desc": "Drop long-form podcasts and meetings to generate speaker-diarized timestamped transcripts.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask voicetranscribe-batch",
        "dmg": "downloads/voicetranscribe-batch-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "55-aiwallpaper-generator",
        "name": "AIWallpaperGenerator",
        "cat": "ai",
        "catName": "AI & Creative",
        "icon": "\u26a1\ufe0f",
        "hotkey": "4K Gen",
        "desc": "Generates 4K dynamic desktop wallpapers using local Stable Diffusion / CoreML models.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask aiwallpaper-generator",
        "dmg": "downloads/aiwallpaper-generator-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "56-jsonmaster-pro",
        "name": "JSONMasterPro",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "HUD",
        "desc": "Instant JSON/YAML/TOML viewer, formatter, path extractor, and TypeScript type generator.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask jsonmaster-pro",
        "dmg": "downloads/jsonmaster-pro-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "57-cronvisualizer",
        "name": "CronVisualizer",
        "cat": "dev",
        "catName": "Developer",
        "icon": "Cron",
        "hotkey": "Menu Bar",
        "desc": "Visual cron expression builder, human-readable explainer, and next-runs schedule debugger.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask cronvisualizer",
        "dmg": "downloads/cronvisualizer-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "58-dockerquick-hud",
        "name": "DockerQuickHUD",
        "cat": "dev",
        "catName": "Developer",
        "icon": "Docker",
        "hotkey": "Menu Bar",
        "desc": "Lightweight container viewer, start/stop/restart, log stream, and volume cleanup.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask dockerquick-hud",
        "dmg": "downloads/dockerquick-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "59-hostsmanager",
        "name": "HostsManager",
        "cat": "dev",
        "catName": "Developer",
        "icon": "Hosts",
        "hotkey": "Menu Bar",
        "desc": "1-click /etc/hosts profile switcher for staging, dev, testing, and production domains.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask hostsmanager",
        "dmg": "downloads/hostsmanager-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "60-certsentry",
        "name": "CertSentry",
        "cat": "dev",
        "catName": "Developer",
        "icon": "SSL",
        "hotkey": "Menu Bar",
        "desc": "SSL/TLS certificate expiration tracker for your domains with 30/14/7-day alerts.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask certsentry",
        "dmg": "downloads/certsentry-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "61-keychainquick",
        "name": "KeyChainQuick",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 K",
        "desc": "Fast search and copy for developer SSH keys, GPG fingerprints, and access tokens.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask keychainquick",
        "dmg": "downloads/keychainquick-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "62-curlcraft",
        "name": "CurlCraft",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Convert",
        "desc": "Converts network cURL commands to Swift, Python, Node, Go, Rust code snippets instantly.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask curlcraft",
        "dmg": "downloads/curlcraft-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "63-sqlitelens",
        "name": "SqliteLens",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Drop .db",
        "desc": "Instant SQLite database file inspector, query runner, and table exporter.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask sqlitelens",
        "dmg": "downloads/sqlitelens-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "64-npmoutdated-hud",
        "name": "NpmOutdatedHUD",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Menu Bar",
        "desc": "Watches package.json across local repos and alerts when dependencies have security patches.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask npmoutdated-hud",
        "dmg": "downloads/npmoutdated-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "65-taillogs",
        "name": "TailLogs",
        "cat": "dev",
        "catName": "Developer",
        "icon": "Logs",
        "hotkey": "Tail -f",
        "desc": "Menu bar multi-file live log tailer with regex color highlighting.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask taillogs",
        "dmg": "downloads/taillogs-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "66-mockupsnap",
        "name": "MockupSnap",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\u26a1\ufe0f",
        "hotkey": "1-Click",
        "desc": "1-click wraps screenshots inside realistic 3D MacBook Pro, iPhone, and iPad frames.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask mockupsnap",
        "dmg": "downloads/mockupsnap-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "67-appiconforge",
        "name": "AppIconForge",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Drop PNG",
        "desc": "Drag a 1024x1024 PNG to automatically generate all iOS, macOS, watchOS, and Web icon sizes.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask appiconforge",
        "dmg": "downloads/appiconforge-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "68-lottiepreview",
        "name": "LottiePreview",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "Lottie",
        "hotkey": "Scrubber",
        "desc": "Native dotLottie and JSON animation player, frame scrubber, and GIF/MP4 exporter.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask lottiepreview",
        "dmg": "downloads/lottiepreview-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "69-aspectratio-calc",
        "name": "AspectRatioCalc",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "Ratio",
        "hotkey": "Calc",
        "desc": "Instant aspect ratio, DPI, points-to-pixels, and responsive viewport sizing calculator.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask aspectratio-calc",
        "dmg": "downloads/aspectratio-calc-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "70-shadowstudio",
        "name": "ShadowStudio",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\u26a1\ufe0f",
        "hotkey": "CSS/SwiftUI",
        "desc": "Visual realistic multi-layer shadow designer with CSS box-shadow and SwiftUI code export.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask shadowstudio",
        "dmg": "downloads/shadowstudio-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "71-duplicatefinder",
        "name": "DuplicateFinder",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Scan",
        "desc": "Blazing-fast hashing-based duplicate file scanner to reclaim disk space.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask duplicatefinder",
        "dmg": "downloads/duplicatefinder-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "72-caffeinebar",
        "name": "CaffeineBar",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "Awake",
        "hotkey": "1-Click",
        "desc": "Keeps Mac awake indefinitely or on a timer with custom display sleep rules.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask caffeinebar",
        "dmg": "downloads/caffeinebar-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "73-hiddenfiles-toggle",
        "name": "HiddenFilesToggle",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2318 \u21e7 .",
        "desc": "1-click menu bar toggle to show/hide hidden dotfiles and system files in Finder.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask hiddenfiles-toggle",
        "dmg": "downloads/hiddenfiles-toggle-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "74-archiveextractor",
        "name": "ArchiveExtractor",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Drop Zip",
        "desc": "Ultra-fast unarchiver supporting 7z, RAR, TAR, GZ, ISO with auto-delete zip option.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask archiveextractor",
        "dmg": "downloads/archiveextractor-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "75-clipboarddiff",
        "name": "ClipboardDiff",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 V",
        "desc": "Compares current clipboard with previous clipboard and shows a visual side-by-side git diff.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask clipboarddiff",
        "dmg": "downloads/clipboarddiff-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "76-apppermission-auditor",
        "name": "AppPermissionAuditor",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Audit",
        "desc": "Inspects all apps granted Camera, Mic, Accessibility, Screen Recording, or Full Disk permissions.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask apppermission-auditor",
        "dmg": "downloads/apppermission-auditor-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "77-wifiradar",
        "name": "WiFiRadar",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "WiFi",
        "hotkey": "Menu Bar",
        "desc": "Displays channel congestion, signal RSSI, interference, and speed test directly in the menu bar.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask wifiradar",
        "dmg": "downloads/wifiradar-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "78-quickshare-local",
        "name": "QuickShareLocal",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\u26a1\ufe0f",
        "hotkey": "P2P Drop",
        "desc": "AirDrop-like local network file dropper between Macs and PCs via browser URL.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask quickshare-local",
        "dmg": "downloads/quickshare-local-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "79-audiorecord-hud",
        "name": "AudioRecordHUD",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\u26a1\ufe0f",
        "hotkey": "1-Click",
        "desc": "1-click system audio + microphone recorder with instant MP3/M4A export.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask audiorecord-hud",
        "dmg": "downloads/audiorecord-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "80-memorypurge-pro",
        "name": "MemoryPurgePro",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "RAM",
        "hotkey": "Purge",
        "desc": "Visual RAM pressure monitor with 1-click inactive memory purge and cache optimization.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask memorypurge-pro",
        "dmg": "downloads/memorypurge-pro-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "81-pixelhamster-desktop",
        "name": "PixelHamsterDesktop",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "Hamster",
        "hotkey": "Menu Bar",
        "desc": "Animated pixel hamster running on a wheel in your menu bar, speeding up with typing and commits.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask pixelhamster-desktop",
        "dmg": "downloads/pixelhamster-desktop-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "82-cybergochi",
        "name": "CyberGochi",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "Gochi",
        "hotkey": "Menu Bar",
        "desc": "Retro Tamagotchi virtual pet that eats completed to-do items and evolves through productivity streaks.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask cybergochi",
        "dmg": "downloads/cybergochi-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "83-deskduck",
        "name": "DeskDuck",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 D",
        "desc": "Floating rubber duck debugger that asks Socratic prompts when you're stuck coding or writing.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask deskduck",
        "dmg": "downloads/deskduck-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "84-plantnursery-hud",
        "name": "PlantNurseryHUD",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "Nursery",
        "hotkey": "HUD",
        "desc": "Virtual greenhouse where rare succulents grow based on your hydration and focus check-ins.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask plantnursery-hud",
        "dmg": "downloads/plantnursery-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "85-focussloth",
        "name": "FocusSloth",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "Sloth",
        "hotkey": "Notch",
        "desc": "Animated sloth climbing a branch in the notch during continuous deep focus time.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask focussloth",
        "dmg": "downloads/focussloth-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "86-zenpanda",
        "name": "ZenPanda",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Breathe",
        "desc": "Meditating panda companion guiding 60-second box-breathing exercises between meetings.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask zenpanda",
        "dmg": "downloads/zenpanda-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "87-codeotter",
        "name": "CodeOtter",
        "cat": "pets",
        "catName": "Pets & Habits",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Window Edge",
        "desc": "Playful otter swimming along window edges, catching fish on successful test runs.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask codeotter",
        "dmg": "downloads/codeotter-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "88-brainwave-sync",
        "name": "BrainWaveSync",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Audio",
        "desc": "Binaural 40Hz Gamma and Alpha wave generator for memory consolidation and hyper-focus.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask brainwave-sync",
        "dmg": "downloads/brainwave-sync-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "89-singletask-spotlight",
        "name": "SingleTaskSpotlight",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 S",
        "desc": "Forces 1 single active window, completely hiding dock and menu bar until current task is checked off.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask singletask-spotlight",
        "dmg": "downloads/singletask-spotlight-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "90-antiprocrastinate-friction",
        "name": "AntiProcrastinateFriction",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Auto",
        "desc": "Adds a 10-second deliberate breathing countdown before opening selected addictive URLs/apps.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask antiprocrastinate-friction",
        "dmg": "downloads/antiprocrastinate-friction-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "91-whitenoise-mixer",
        "name": "WhiteNoiseMixer",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Audio",
        "desc": "Multi-track customizable soundscape mixer (Rain + Campfire + Ocean Waves + Wind Chimes).",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask whitenoise-mixer",
        "dmg": "downloads/whitenoise-mixer-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "92-tablimiter-pro",
        "name": "TabLimiterPro",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "Tabs",
        "hotkey": "Safari/Chrome",
        "desc": "Restricts open tabs to max 5 per window, auto-archiving overflowing tabs to a reading list.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask tablimiter-pro",
        "dmg": "downloads/tablimiter-pro-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "93-eyeblink-coach",
        "name": "EyeBlinkCoach",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Subtle Pulse",
        "desc": "Subtly flashes a soft screen border halo every 15 seconds to remind power users to blink.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask eyeblink-coach",
        "dmg": "downloads/eyeblink-coach-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "94-focusheatmap",
        "name": "FocusHeatmap",
        "cat": "focus",
        "catName": "Focus & Flow",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Overlay",
        "desc": "Live visual heatmap overlay showing which apps and windows consumed your attention today.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask focusheatmap",
        "dmg": "downloads/focusheatmap-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "95-morningkickoff-hud",
        "name": "MorningKickoffHUD",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "\u26a1\ufe0f",
        "hotkey": "9:00 AM",
        "desc": "3-minute morning launchpad popup showing today's top 3 MITs, calendar, and weather overview.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask morningkickoff-hud",
        "dmg": "downloads/morningkickoff-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "96-microjournal-bar",
        "name": "MicroJournalBar",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Menu Bar",
        "desc": "1-line micro-journaling in the menu bar to log quick thoughts, gratitude, and wins.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask microjournal-bar",
        "dmg": "downloads/microjournal-bar-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "97-sugar-fasting-tracker",
        "name": "SugarFastingTracker",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "Fasting",
        "hotkey": "Status Bar",
        "desc": "Visual intermittent fasting timer in status bar with ketosis stage and metabolic alerts.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask sugar-fasting-tracker",
        "dmg": "downloads/sugar-fasting-tracker-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "98-sleephygiene-nudge",
        "name": "SleepHygieneNudge",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "Bedtime",
        "hotkey": "Night Shift",
        "desc": "Automatically warms screen temperature and locks distraction apps 1 hour before scheduled bedtime.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask sleephygiene-nudge",
        "dmg": "downloads/sleephygiene-nudge-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "99-meetingprep-countdown",
        "name": "MeetingPrepCountdown",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "Meeting",
        "hotkey": "Pre-Alarm",
        "desc": "Popover chime 2 minutes before Google Meet/Zoom calls with direct 1-click join link.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask meetingprep-countdown",
        "dmg": "downloads/meetingprep-countdown-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "100-stepcounter-sync",
        "name": "StepCounterSync",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Health Sync",
        "desc": "Apple Watch / Health synced step counter progress bar right in the menu bar.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask stepcounter-sync",
        "dmg": "downloads/stepcounter-sync-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "101-caffeinedecay-curve",
        "name": "CaffeineDecayCurve",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "icon": "Caffeine",
        "hotkey": "Decay Model",
        "desc": "Calculates and plots active caffeine in bloodstream with sleep cutoff time warnings.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask caffeinedecay-curve",
        "dmg": "downloads/caffeinedecay-curve-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "102-cliptomarkdown-thread",
        "name": "ClipToMarkdownThread",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "1-Click",
        "desc": "Converts X, Reddit, and LinkedIn posts into clean Obsidian/Notion markdown.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask cliptomarkdown-thread",
        "dmg": "downloads/cliptomarkdown-thread-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "103-podcastchapter-marker",
        "name": "PodcastChapterMarker",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "ID3 Tags",
        "desc": "Audio waveform scrubber to drop timestamped chapter markers and export ID3 tags.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask podcastchapter-marker",
        "dmg": "downloads/podcastchapter-marker-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "104-teleprompter-hud",
        "name": "TeleprompterHUD",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Transparent",
        "desc": "Translucent scrolling teleprompter for presentations and recorded video.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask teleprompter-hud",
        "dmg": "downloads/teleprompter-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "105-quickpoll-creator",
        "name": "QuickPollCreator",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "HUD",
        "desc": "Generates formatted poll layouts for Twitter, LinkedIn, and Slack with 1-click copy.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask quickpoll-creator",
        "dmg": "downloads/quickpoll-creator-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "106-videothumbnail-tester",
        "name": "VideoThumbnailTester",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Preview",
        "desc": "Previews YouTube and Twitter thumbnails on light/dark mode social feed mocks.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask videothumbnail-tester",
        "dmg": "downloads/videothumbnail-tester-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "107-discordrole-autoping",
        "name": "DiscordRoleAutoPing",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Embed",
        "desc": "Quick organizer for Discord markdown formatting, roles, and embed payloads.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask discordrole-autoping",
        "dmg": "downloads/discordrole-autoping-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "108-watermarkmaster",
        "name": "WatermarkMaster",
        "cat": "social",
        "catName": "Social & Creator",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Batch",
        "desc": "Applies customizable dynamic logos and watermarks to batches of images.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask watermarkmaster",
        "dmg": "downloads/watermarkmaster-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "109-whispersubtitles-srt",
        "name": "WhisperSubtitlesSRT",
        "cat": "ai",
        "catName": "AI & Voice",
        "icon": "\u26a1\ufe0f",
        "hotkey": "WhisperKit",
        "desc": "Generates timestamped .srt and .vtt subtitles locally via WhisperKit in seconds.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask whispersubtitles-srt",
        "dmg": "downloads/whispersubtitles-srt-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "110-summarizeurl-ai",
        "name": "SummarizeURLAI",
        "cat": "ai",
        "catName": "AI & Voice",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 U",
        "desc": "Offline webpage and article summarizer with 3 bullet takeaways.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask summarizeurl-ai",
        "dmg": "downloads/summarizeurl-ai-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "111-sqlquery-ai",
        "name": "SqlQueryAI",
        "cat": "ai",
        "catName": "AI & Dev",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Natural Lang",
        "desc": "Translates plain English requests into optimized SQL queries.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask sqlquery-ai",
        "dmg": "downloads/sqlquery-ai-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "112-localembeddings-search",
        "name": "LocalEmbeddingsSearch",
        "cat": "ai",
        "catName": "AI & Dev",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Semantic",
        "desc": "Semantic vector search across local folders using local CoreML embeddings.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask localembeddings-search",
        "dmg": "downloads/localembeddings-search-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "113-diffexplainer-ai",
        "name": "DiffExplainerAI",
        "cat": "ai",
        "catName": "AI & Dev",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Changelog",
        "desc": "Analyzes git diffs to generate clean release notes and changelogs.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask diffexplainer-ai",
        "dmg": "downloads/diffexplainer-ai-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "114-readaloud-tts",
        "name": "ReadAloudTTS",
        "cat": "ai",
        "catName": "AI & Voice",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Speech",
        "desc": "Ultra-natural text-to-speech voice reader for selected articles and code comments.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask readaloud-tts",
        "dmg": "downloads/readaloud-tts-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "115-regexgenerator-ai",
        "name": "RegexGeneratorAI",
        "cat": "ai",
        "catName": "AI & Dev",
        "icon": "\u26a1\ufe0f",
        "hotkey": "AI Gen",
        "desc": "Converts plain English descriptions into tested, production-ready regular expressions.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask regexgenerator-ai",
        "dmg": "downloads/regexgenerator-ai-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "116-kubecluster-quick",
        "name": "KubeClusterQuick",
        "cat": "dev",
        "catName": "Developer",
        "icon": "K8s",
        "hotkey": "Menu Bar",
        "desc": "Minimalist Kubernetes cluster status watcher with 1-click pod log viewing.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask kubecluster-quick",
        "dmg": "downloads/kubecluster-quick-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "117-redislens",
        "name": "RedisLens",
        "cat": "dev",
        "catName": "Developer",
        "icon": "Redis",
        "hotkey": "Menu Bar",
        "desc": "Menu bar Redis key-value browser, TTL inspector, and memory analyzer.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask redislens",
        "dmg": "downloads/redislens-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "118-gitstash-manager",
        "name": "GitStashManager",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "\u2325 S",
        "desc": "Visual UI for viewing, comparing, applying, and dropping local git stashes.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask gitstash-manager",
        "dmg": "downloads/gitstash-manager-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "119-portforwarder-pro",
        "name": "PortForwarderPro",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Tunnel",
        "desc": "SSH tunnel and local port forwarding manager with auto-reconnect.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask portforwarder-pro",
        "dmg": "downloads/portforwarder-pro-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "120-apimock-server",
        "name": "ApiMockServer",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": ":4000",
        "desc": "1-click local mock HTTP server with custom latency and status simulation.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask apimock-server",
        "dmg": "downloads/apimock-server-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "121-dotenv-diff",
        "name": "DotEnvDiff",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Verify",
        "desc": "Compares .env.example against actual .env and flags missing keys before push.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask dotenv-diff",
        "dmg": "downloads/dotenv-diff-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "122-dnslookup-hud",
        "name": "DnsLookupHUD",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "DNS",
        "desc": "Instant DNS record inspector (A, CNAME, MX, TXT) with global node propagation test.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask dnslookup-hud",
        "dmg": "downloads/dnslookup-hud-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "123-httpheader-inspector",
        "name": "HttpHeaderInspector",
        "cat": "dev",
        "catName": "Developer",
        "icon": "\u26a1\ufe0f",
        "hotkey": "CORS/SSL",
        "desc": "Tests HTTP/HTTPS response headers, CORS policies, and SSL handshakes.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask httpheader-inspector",
        "dmg": "downloads/httpheader-inspector-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "124-icongrid-overlay",
        "name": "IconGridOverlay",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Grid",
        "desc": "Pixel-perfect icon grid overlay for designing 512x512 and 1024x1024 app icons.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask icongrid-overlay",
        "dmg": "downloads/icongrid-overlay-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "125-contrastpalette-studio",
        "name": "ContrastPaletteStudio",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\u26a1\ufe0f",
        "hotkey": "WCAG AAA",
        "desc": "Creates accessible, harmonious color systems meeting WCAG AAA requirements.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask contrastpalette-studio",
        "dmg": "downloads/contrastpalette-studio-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "126-gradientmesh-maker",
        "name": "GradientMeshMaker",
        "cat": "media",
        "catName": "Creative & Design",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Mesh",
        "desc": "Visual multi-point gradient mesh generator with real-time SwiftUI curve export.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask gradientmesh-maker",
        "dmg": "downloads/gradientmesh-maker-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "127-diskscleaner-mini",
        "name": "DisksCleanerMini",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "Disk",
        "hotkey": "Scan",
        "desc": "Visualizes large downloads, node_modules, and cache folders for selective 1-click purge.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask diskscleaner-mini",
        "dmg": "downloads/diskscleaner-mini-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "128-bluetoothsignal-radar",
        "name": "BluetoothSignalRadar",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "AirPods",
        "hotkey": "RSSI",
        "desc": "Signal strength (RSSI) monitor for AirPods and mice with disconnect alerts.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask bluetoothsignal-radar",
        "dmg": "downloads/bluetoothsignal-radar-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "129-batterycycle-telemetry",
        "name": "BatteryCycleTelemetry",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "Battery",
        "hotkey": "SMC",
        "desc": "Deep SMC battery analytics: degradation curve, wattage telemetry, and cycles.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask batterycycle-telemetry",
        "dmg": "downloads/batterycycle-telemetry-1.0.0.dmg",
        "price": "$9"
    },
    {
        "id": "130-appquarantine-inspector",
        "name": "AppQuarantineInspector",
        "cat": "system",
        "catName": "Utilities & System",
        "icon": "\u26a1\ufe0f",
        "hotkey": "Gatekeeper",
        "desc": "Lists quarantine attributes (com.apple.quarantine) with 1-click override.",
        "features": [
            "Native Swift 6 / SwiftUI",
            "Zero-lag performance",
            "100% Offline Private"
        ],
        "brew": "brew install --cask appquarantine-inspector",
        "dmg": "downloads/appquarantine-inspector-1.0.0.dmg",
        "price": "$9"
    }
];

// DOM Elements
const appsGrid = document.getElementById("appsGrid");
const searchInput = document.getElementById("appSearchInput");
const categoryPills = document.querySelectorAll(".pill");
const buySuiteBtn = document.getElementById("buySuiteBtn");
const licenseModal = document.getElementById("licenseModal");
const closeModalBtn = document.getElementById("closeModalBtn");
const copyKeyBtn = document.getElementById("copyKeyBtn");
const generatedKeyEl = document.getElementById("generatedKey");

let activeCategory = "all";
let searchTerm = "";

function renderApps() {
    const filtered = apps.filter(app => {
        const matchesCategory = activeCategory === "all" || app.cat === activeCategory;
        const matchesSearch = searchTerm === "" || 
            app.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.desc.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.catName.toLowerCase().includes(searchTerm.toLowerCase());
        return matchesCategory && matchesSearch;
    });

    if (filtered.length === 0) {
        appsGrid.innerHTML = `
            <div style="grid-column: 1/-1; text-align: center; padding: 60px 20px; color: var(--text-muted);">
                <h3>No apps match "${searchTerm}"</h3>
                <p>Try searching for "Hamster", "Bonsai", "Duck", "Focus", "Water", "Git", "SQL", or "Docker"</p>
            </div>
        `;
        return;
    }

    appsGrid.innerHTML = filtered.map(app => `
        <div class="app-card" data-category="${app.cat}">
            <div>
                <div class="app-card-top">
                    <div class="app-icon" style="background: rgba(255, 255, 255, 0.05); font-size: 1.5rem;">${app.icon}</div>
                    <div class="app-meta">
                        <div class="app-title-row">
                            <h3 class="app-name">${app.name}</h3>
                            <span class="app-cat-badge">${app.catName}</span>
                        </div>
                        <div class="app-hotkey">${app.hotkey}</div>
                    </div>
                </div>

                <p class="app-desc">${app.desc}</p>

                <ul class="app-features">
                    ${app.features.map(f => `<li>${f}</li>`).join("")}
                </ul>
            </div>

            <div class="app-card-footer">
                <span class="app-brew-cmd" onclick="copyBrewCmd('${app.brew}', this)">
                    📋 ${app.brew}
                </span>
                <a href="${app.dmg}" class="btn btn-secondary btn-sm" onclick="handleDmgDownload(event, '${app.name}')">
                    Download .dmg
                </a>
            </div>
        </div>
    `).join("");
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

// Copy brew command
window.copyBrewCmd = function(cmd, element) {
    navigator.clipboard.writeText(cmd).then(() => {
        const original = element.innerHTML;
        element.innerHTML = "✓ Copied to clipboard!";
        element.style.color = "#10b981";
        setTimeout(() => {
            element.innerHTML = original;
            element.style.color = "";
        }, 1800);
    });
};

// Handle DMG direct download simulation
window.handleDmgDownload = function(e, appName) {
    e.preventDefault();
    alert(`📥 Starting direct download for ${appName}.dmg\n\nDrag to your /Applications folder to start using instantly!`);
};

// License modal
buySuiteBtn.addEventListener("click", () => {
    const randomHex = Math.random().toString(36).substring(2, 6).toUpperCase();
    const randomNum = Math.floor(1000 + Math.random() * 9000);
    const key = `SUITE-PRO-PASS-${randomHex}-${randomNum}`;
    generatedKeyEl.textContent = key;
    licenseModal.classList.remove("hidden");
});

closeModalBtn.addEventListener("click", () => {
    licenseModal.classList.add("hidden");
});

copyKeyBtn.addEventListener("click", () => {
    navigator.clipboard.writeText(generatedKeyEl.textContent).then(() => {
        copyKeyBtn.textContent = "✓ Copied!";
        setTimeout(() => { copyKeyBtn.textContent = "Copy Key"; }, 1500);
    });
});

// Initialize
renderApps();
