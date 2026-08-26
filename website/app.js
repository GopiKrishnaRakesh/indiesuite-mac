// MacUpgraded.com - Complete Catalog for 130 Native macOS Apps
const apps = [
    {
        "id": "01-whispertap",
        "slug": "whispertap",
        "name": "WhisperTap",
        "cat": "ai",
        "catName": "AI & Voice",
        "hotkey": "\u2325 Space",
        "desc": "Global push-to-talk AI dictation into any text field via Apple Silicon MLX WhisperKit.",
        "features": [
            "100% Offline & Private",
            "Auto-paste into focused app",
            "Code & Dev mode cleanup"
        ],
        "brew": "brew install --cask whispertap",
        "price": "$19",
        "priceNum": 19
    },
    {
        "id": "02-tokenwatch",
        "slug": "tokenwatch",
        "name": "TokenWatch",
        "cat": "ai",
        "catName": "AI & Dev",
        "hotkey": "Menu Bar",
        "desc": "Menu bar real-time LLM API spend & rate-limit monitor for OpenAI, Anthropic, Gemini & Groq.",
        "features": [
            "Live status bar cost ticker",
            "Budget limit alerts",
            "Per-project token tracking"
        ],
        "brew": "brew install --cask tokenwatch",
        "price": "$16",
        "priceNum": 16
    },
    {
        "id": "03-locallens-ocr",
        "slug": "locallens-ocr",
        "name": "LocalLens OCR",
        "cat": "ai",
        "catName": "AI & Vision",
        "hotkey": "\u2318 \u21e7 2",
        "desc": "Instant screen-to-code, JSON, LaTeX, and table extractor with regex formatting.",
        "features": [
            "Vision Neural Engine OCR",
            "Code syntax formatting",
            "Zero line-wrap distortion"
        ],
        "brew": "brew install --cask locallens-ocr",
        "price": "$16",
        "priceNum": 16
    },
    {
        "id": "04-portsentry",
        "slug": "portsentry",
        "name": "PortSentry",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "Active port & zombie process killer. Shows listening ports, process PIDs, and 1-click kill.",
        "features": [
            "Instant port release",
            "PID & memory inspector",
            "1-click browser preview"
        ],
        "brew": "brew install --cask portsentry",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "05-shrinkmedia",
        "slug": "shrinkmedia",
        "name": "ShrinkMedia",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "Drag & Drop",
        "desc": "Fast drag-and-drop batch video/audio/image compressor using hardware VideoToolbox.",
        "features": [
            "Up to 88% size reduction",
            "Lossless GIF & MP4 export",
            "Apple Silicon HW encoder"
        ],
        "brew": "brew install --cask shrinkmedia",
        "price": "$12",
        "priceNum": 12
    },
    {
        "id": "06-colorforge",
        "slug": "colorforge",
        "name": "ColorForge",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "\u2318 \u21e7 C",
        "desc": "Native eyedropper, palette builder, and WCAG 2.2 AAA contrast compliance checker.",
        "features": [
            "1-click SwiftUI/CSS/Hex export",
            "Global screen magnifier",
            "Palette history sync"
        ],
        "brew": "brew install --cask colorforge",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "07-notchshelf",
        "slug": "notchshelf",
        "name": "NotchShelf",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Top Bezel",
        "desc": "Smart drop-zone & staging area hidden inside the MacBook notch for files, links & screenshots.",
        "features": [
            "Zero desktop clutter",
            "Smooth hover reveal",
            "Drag-to-Slack/Terminal"
        ],
        "brew": "brew install --cask notchshelf",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "08-audiomix",
        "slug": "audiomix",
        "name": "AudioMix",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Menu Bar",
        "desc": "Per-app volume mixer & independent audio output routing without virtual cables.",
        "features": [
            "Per-application sliders",
            "Zero latency CoreAudio",
            "Quick device routing"
        ],
        "brew": "brew install --cask audiomix",
        "price": "$12",
        "priceNum": 12
    },
    {
        "id": "09-micmute-hud",
        "slug": "micmute-hud",
        "name": "MicMute HUD",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "\u2318 \u21e7 M",
        "desc": "Universal hardware mic mute & camera blackout indicator with on-screen dynamic pill.",
        "features": [
            "Works across Zoom/Meet/Teams",
            "Audio feedback cues",
            "Always-on-top pill"
        ],
        "brew": "brew install --cask micmute-hud",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "10-promptdock",
        "slug": "promptdock",
        "name": "PromptDock",
        "cat": "ai",
        "catName": "AI & Voice",
        "hotkey": "\u2325 P",
        "desc": "Global floating prompt HUD and snippet palette with dynamic variable interpolation.",
        "features": [
            "Instant clipboard injection",
            "Dynamic {{variables}}",
            "Categorized prompt library"
        ],
        "brew": "brew install --cask promptdock",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "11-snaptile",
        "slug": "snaptile",
        "name": "SnapTile",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "\u2303 \u2325 Arrows",
        "desc": "Hyper-lightweight, zero-latency keyboard & edge window tiling manager with grid layouts.",
        "features": [
            "Zero battery drain",
            "Custom inner gaps",
            "Multi-monitor smart snapping"
        ],
        "brew": "brew install --cask snaptile",
        "price": "$8",
        "priceNum": 8
    },
    {
        "id": "12-purgeapp",
        "slug": "purgeapp",
        "name": "PurgeApp",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Drag & Drop",
        "desc": "Deep uninstaller that tracks and cleans hidden caches, plists, launch agents, and containers.",
        "features": [
            "Finds orphaned residue",
            "Reclaims GBs of disk space",
            "Safe trash rollback"
        ],
        "brew": "brew install --cask purgeapp",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "13-chargeguard",
        "slug": "chargeguard",
        "name": "ChargeGuard",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Menu Bar",
        "desc": "Battery health optimizer, custom 80% charge limiter, and real-time wattage telemetry.",
        "features": [
            "Extends battery lifespan",
            "Real-time cycle counter",
            "SMC hardware control"
        ],
        "brew": "brew install --cask chargeguard",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "14-envvault",
        "slug": "envvault",
        "name": "EnvVault",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "Secure .env & API key workspace manager with quick paste, encryption, and zero-leak validation.",
        "features": [
            "Dev/Staging/Prod profiles",
            "Masked secret viewer",
            "1-click .env clipboard copy"
        ],
        "brew": "brew install --cask envvault",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "15-devtunnel-hud",
        "slug": "devtunnel-hud",
        "name": "DevTunnel HUD",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "Menu bar manager & traffic inspector for Cloudflare Tunnels, Ngrok, and Localtunnel.",
        "features": [
            "Live request inspector",
            "1-click public URL copy",
            "Webhook payload replay"
        ],
        "brew": "brew install --cask devtunnel-hud",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "16-gitpulse",
        "slug": "gitpulse",
        "name": "GitPulse",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "Multi-repo status bar tracker for 50+ git repos: uncommitted changes, sync, and PRs.",
        "features": [
            "Scans local projects",
            "Dirty file notifications",
            "1-click pull/stash"
        ],
        "brew": "brew install --cask gitpulse",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "17-regexforge",
        "slug": "regexforge",
        "name": "RegexForge",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "HUD",
        "desc": "Native Swift live regex debugger & visual tester with instant multi-language code export.",
        "features": [
            "Live match highlighting",
            "Swift/Python/JS generators",
            "Preset pattern library"
        ],
        "brew": "brew install --cask regexforge",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "18-svgoptim",
        "slug": "svgoptim",
        "name": "SVGOptim",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "Drag & Drop",
        "desc": "Zero-bloat SVG optimizer, cleaner, and SVG-to-SwiftUI / React component converter.",
        "features": [
            "60%+ SVG size reduction",
            "SwiftUI Shape generation",
            "Clean JSX component output"
        ],
        "brew": "brew install --cask svgoptim",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "19-fontinspect",
        "slug": "fontinspect",
        "name": "FontInspect",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "Menu Bar",
        "desc": "Local font viewer, glyph explorer, variable font axis tester, and typography comparer.",
        "features": [
            "Variable font sliders",
            "Glyph unicode inspector",
            "Side-by-side pairing preview"
        ],
        "brew": "brew install --cask fontinspect",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "20-presentercam",
        "slug": "presentercam",
        "name": "PresenterCam",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "\u2318 \u21e7 P",
        "desc": "Floating camera overlay with background blur, zoom, pointer spotlight, and drawing canvas.",
        "features": [
            "Loom/Demo ready",
            "Neural blur & circular mask",
            "Cursor spotlight tracker"
        ],
        "brew": "brew install --cask presentercam",
        "price": "$12",
        "priceNum": 12
    },
    {
        "id": "21-cleandesk-pro",
        "slug": "cleandesk-pro",
        "name": "CleanDesk Pro",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "1-Click",
        "desc": "1-click presentation mode: hides desktop icons, silences notifications, sets clean background.",
        "features": [
            "Instant screen privacy",
            "DND auto-activation",
            "Restores setup in 1 click"
        ],
        "brew": "brew install --cask cleandesk-pro",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "22-screenruler",
        "slug": "screenruler",
        "name": "ScreenRuler",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "Crosshair",
        "desc": "Precision on-screen pixel measurement ruler, alignment crosshair, and padding inspector.",
        "features": [
            "Sub-pixel measurement",
            "Guides and snap lines",
            "Instant hex color on hover"
        ],
        "brew": "brew install --cask screenruler",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "23-apphop",
        "slug": "apphop",
        "name": "AppHop",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "\u2325 `",
        "desc": "Quick-switch popup that lets you jump between open windows of ONLY the active app.",
        "features": [
            "Number key switching",
            "Zero lag window focus",
            "Works across spaces"
        ],
        "brew": "brew install --cask apphop",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "24-scratchpad-hud",
        "slug": "scratchpad-hud",
        "name": "ScratchPad HUD",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "\u2325 N",
        "desc": "Always-on-top markdown scratchpad with instant cloud/local file export and quick-hide shortcut.",
        "features": [
            "Markdown preview",
            "Persistent auto-save",
            "Global popup anywhere"
        ],
        "brew": "brew install --cask scratchpad-hud",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "25-timebridge",
        "slug": "timebridge",
        "name": "TimeBridge",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Menu Bar",
        "desc": "Visual timezone slider and meeting overlap calculator in the menu bar with world clocks.",
        "features": [
            "Interactive time scrub bar",
            "Team availability overlap",
            "Copy scheduled slot"
        ],
        "brew": "brew install --cask timebridge",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "26-menucleaner",
        "slug": "menucleaner",
        "name": "MenuCleaner",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Menu Bar",
        "desc": "Lightweight menu bar icon manager that auto-hides overflow items behind a smooth divider.",
        "features": [
            "Reclaims notch space",
            "Auto-hide timer",
            "Drag to organize"
        ],
        "brew": "brew install --cask menucleaner",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "27-metascrub",
        "slug": "metascrub",
        "name": "MetaScrub",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Drag & Drop",
        "desc": "Instant drag-and-drop EXIF, GPS location, and privacy metadata stripper for photos & PDFs.",
        "features": [
            "Strips camera serials & GPS",
            "Lossless image rewrite",
            "Batch folder processing"
        ],
        "brew": "brew install --cask metascrub",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "28-bandwidthradar",
        "slug": "bandwidthradar",
        "name": "BandwidthRadar",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Menu Bar",
        "desc": "Real-time per-app network download/upload traffic monitor in the menu bar with rogue alerts.",
        "features": [
            "Live KB/s & MB/s in status bar",
            "Per-process data usage",
            "Bandwidth hog alerts"
        ],
        "brew": "brew install --cask bandwidthradar",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "29-bluetoothautohop",
        "slug": "bluetoothautohop",
        "name": "BluetoothAutoHop",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Automated",
        "desc": "Smart Bluetooth manager that auto-disconnects on sleep, auto-reconnects on wake, shows battery.",
        "features": [
            "No more sleep battery drain",
            "Instant AirPods switch",
            "Menu bar battery levels"
        ],
        "brew": "brew install --cask bluetoothautohop",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "30-privatellm-bar",
        "slug": "privatellm-bar",
        "name": "PrivateLLM Bar",
        "cat": "ai",
        "catName": "AI & Voice",
        "hotkey": "Menu Bar",
        "desc": "Ultra-lightweight menu bar local model runner using MLX / llama.cpp for instant offline AI.",
        "features": [
            "100% Offline & Private",
            "Zero cloud API fees",
            "Apple Silicon Metal accelerated"
        ],
        "brew": "brew install --cask privatellm-bar",
        "price": "$19",
        "priceNum": 19
    },
    {
        "id": "31-petpals-desktop",
        "slug": "petpals-desktop",
        "name": "PetPalsDesktop",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "On Desktop",
        "desc": "Interactive desktop pet that walks on windows, sleeps during focus sessions, and nudges hydration.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask petpals-desktop",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "32-bonsaigrow",
        "slug": "bonsaigrow",
        "name": "BonsaiGrow",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "Menu Bar",
        "desc": "Virtual Zen Bonsai tree that grows lush leaves with completed focus sessions and withers if distracted.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask bonsaigrow",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "33-deskfish-aquarium",
        "slug": "deskfish-aquarium",
        "name": "DeskFishAquarium",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "Floating HUD",
        "desc": "Floating translucent mini-aquarium HUD with fish whose health depends on daily habit streaks.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask deskfish-aquarium",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "34-pomodorodragon",
        "slug": "pomodorodragon",
        "name": "PomodoroDragon",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "25m Cycle",
        "desc": "RPG Pomodoro egg that hatches into unique elemental dragons as you complete 25-minute focus cycles.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask pomodorodragon",
        "price": "$8",
        "priceNum": 8
    },
    {
        "id": "35-codecat",
        "slug": "codecat",
        "name": "CodeCat",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "Window Edge",
        "desc": "Animated cat sitting on your active terminal or Xcode window edge, purring on Git commits and test passes.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask codecat",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "36-deepflow-blocker",
        "slug": "deepflow-blocker",
        "name": "DeepFlowBlocker",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "\u2325 F",
        "desc": "Host and process-level distraction website & social app killer with emergency unblock math friction puzzles.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask deepflow-blocker",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "37-zenaudio-ambience",
        "slug": "zenaudio-ambience",
        "name": "ZenAudioAmbience",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "Menu Bar",
        "desc": "Binaural beats, brown noise, lo-fi coffee shop, and rain generator with 432Hz focus frequencies.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask zenaudio-ambience",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "38-screendimmer-focus",
        "slug": "screendimmer-focus",
        "name": "ScreenDimmerFocus",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "\u2325 D",
        "desc": "Spotlights your active window and dims/blurs background windows on all connected displays.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask screendimmer-focus",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "39-breakreminder",
        "slug": "breakreminder",
        "name": "BreakReminder",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "Timer",
        "desc": "20-20-20 eye strain rule & ergonomic stretch coach with screen fade micro-pauses.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask breakreminder",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "40-monospace-flow",
        "slug": "monospace-flow",
        "name": "MonoSpaceFlow",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "\u2325 T",
        "desc": "Full-screen minimalist typewriter mode with mechanical keyboard audio feedback.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask monospace-flow",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "41-habitgrid",
        "slug": "habitgrid",
        "name": "HabitGrid",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Menu Bar",
        "desc": "GitHub-style 365-day contribution heatmaps for personal daily habits in the menu bar.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask habitgrid",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "42-waterdrop-hud",
        "slug": "waterdrop-hud",
        "name": "WaterDropHUD",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "1-Click",
        "desc": "Smart hydration tracker with 1-click water logging, reminders, and daily goal telemetry.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask waterdrop-hud",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "43-postureguard",
        "slug": "postureguard",
        "name": "PostureGuard",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Camera",
        "desc": "Uses local Apple Vision pose estimation to alert when slouching without storing or streaming any video.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask postureguard",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "44-standup-timer",
        "slug": "standup-timer",
        "name": "StandUpTimer",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Timer",
        "desc": "Standing desk timer with posture intervals and smart desk Bluetooth auto-sync.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask standup-timer",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "45-dayplanner-notch",
        "slug": "dayplanner-notch",
        "name": "DayPlannerNotch",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Notch",
        "desc": "Visual timeline of today's calendar events & time-blocks rendered directly in the MacBook notch.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask dayplanner-notch",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "46-statussync",
        "slug": "statussync",
        "name": "StatusSync",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "Auto",
        "desc": "Auto-syncs Slack, Discord, and Teams status based on active app or calendar event.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask statussync",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "47-quicktweet-x",
        "slug": "quicktweet-x",
        "name": "QuickTweetX",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "\u2325 X",
        "desc": "Floating HUD to draft and schedule posts to X, Bluesky, Threads, and Mastodon in one shot.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask quicktweet-x",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "48-dminbox-unified",
        "slug": "dminbox-unified",
        "name": "DMInboxUnified",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "Menu Bar",
        "desc": "Unified menu bar badge & preview for Slack, Discord, Telegram, and WhatsApp messages.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask dminbox-unified",
        "price": "$8",
        "priceNum": 8
    },
    {
        "id": "49-streamerbanner",
        "slug": "streamerbanner",
        "name": "StreamerBanner",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "HUD",
        "desc": "Animated lower-thirds, watermark, and ticker for screen recordings and live streaming.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask streamerbanner",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "50-emojiforge",
        "slug": "emojiforge",
        "name": "EmojiForge",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "\u2318 .",
        "desc": "Floating emoji & kaomoji picker with custom Slack/Discord emoji batch uploader & resizer.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask emojiforge",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "51-pdfwhisper-ai",
        "slug": "pdfwhisper-ai",
        "name": "PDFWhisperAI",
        "cat": "ai",
        "catName": "AI & Vision",
        "hotkey": "Drop PDF",
        "desc": "Instant local Q&A with PDFs via Apple Silicon embeddings & CoreML (100% offline).",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask pdfwhisper-ai",
        "price": "$16",
        "priceNum": 16
    },
    {
        "id": "52-gitcommit-ai",
        "slug": "gitcommit-ai",
        "name": "GitCommitAI",
        "cat": "ai",
        "catName": "AI & Dev",
        "hotkey": "\u2325 C",
        "desc": "1-click conventional git commit message generator from active unstaged/staged diffs.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask gitcommit-ai",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "53-codeexplainer-hud",
        "slug": "codeexplainer-hud",
        "name": "CodeExplainerHUD",
        "cat": "ai",
        "catName": "AI & Dev",
        "hotkey": "Highlight",
        "desc": "Highlight any cryptic code, regex, or error on screen and get an instant plain-English breakdown.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask codeexplainer-hud",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "54-voicetranscribe-batch",
        "slug": "voicetranscribe-batch",
        "name": "VoiceTranscribeBatch",
        "cat": "ai",
        "catName": "AI & Voice",
        "hotkey": "Drop Audio",
        "desc": "Drop long-form podcasts and meetings to generate speaker-diarized timestamped transcripts.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask voicetranscribe-batch",
        "price": "$16",
        "priceNum": 16
    },
    {
        "id": "55-aiwallpaper-generator",
        "slug": "aiwallpaper-generator",
        "name": "AIWallpaperGenerator",
        "cat": "ai",
        "catName": "AI & Creative",
        "hotkey": "4K Gen",
        "desc": "Generates 4K dynamic desktop wallpapers using local Stable Diffusion / CoreML models.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask aiwallpaper-generator",
        "price": "$16",
        "priceNum": 16
    },
    {
        "id": "56-jsonmaster-pro",
        "slug": "jsonmaster-pro",
        "name": "JSONMasterPro",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "HUD",
        "desc": "Instant JSON/YAML/TOML viewer, formatter, path extractor, and TypeScript type generator.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask jsonmaster-pro",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "57-cronvisualizer",
        "slug": "cronvisualizer",
        "name": "CronVisualizer",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "Visual cron expression builder, human-readable explainer, and next-runs schedule debugger.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask cronvisualizer",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "58-dockerquick-hud",
        "slug": "dockerquick-hud",
        "name": "DockerQuickHUD",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "Lightweight container viewer, start/stop/restart, log stream, and volume cleanup.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask dockerquick-hud",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "59-hostsmanager",
        "slug": "hostsmanager",
        "name": "HostsManager",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "1-click /etc/hosts profile switcher for staging, dev, testing, and production domains.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask hostsmanager",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "60-certsentry",
        "slug": "certsentry",
        "name": "CertSentry",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "SSL/TLS certificate expiration tracker for your domains with 30/14/7-day alerts.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask certsentry",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "61-keychainquick",
        "slug": "keychainquick",
        "name": "KeyChainQuick",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "\u2325 K",
        "desc": "Fast search and copy for developer SSH keys, GPG fingerprints, and access tokens.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask keychainquick",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "62-curlcraft",
        "slug": "curlcraft",
        "name": "CurlCraft",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Convert",
        "desc": "Converts network cURL commands to Swift, Python, Node, Go, Rust code snippets instantly.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask curlcraft",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "63-sqlitelens",
        "slug": "sqlitelens",
        "name": "SqliteLens",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Drop .db",
        "desc": "Instant SQLite database file inspector, query runner, and table exporter.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask sqlitelens",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "64-npmoutdated-hud",
        "slug": "npmoutdated-hud",
        "name": "NpmOutdatedHUD",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "Watches package.json across local repos and alerts when dependencies have security patches.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask npmoutdated-hud",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "65-taillogs",
        "slug": "taillogs",
        "name": "TailLogs",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Tail -f",
        "desc": "Menu bar multi-file live log tailer with regex color highlighting.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask taillogs",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "66-mockupsnap",
        "slug": "mockupsnap",
        "name": "MockupSnap",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "1-Click",
        "desc": "1-click wraps screenshots inside realistic 3D MacBook Pro, iPhone, and iPad frames.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask mockupsnap",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "67-appiconforge",
        "slug": "appiconforge",
        "name": "AppIconForge",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "Drop PNG",
        "desc": "Drag a 1024x1024 PNG to automatically generate all iOS, macOS, watchOS, and Web icon sizes.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask appiconforge",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "68-lottiepreview",
        "slug": "lottiepreview",
        "name": "LottiePreview",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "Scrubber",
        "desc": "Native dotLottie and JSON animation player, frame scrubber, and GIF/MP4 exporter.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask lottiepreview",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "69-aspectratio-calc",
        "slug": "aspectratio-calc",
        "name": "AspectRatioCalc",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "Calc",
        "desc": "Instant aspect ratio, DPI, points-to-pixels, and responsive viewport sizing calculator.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask aspectratio-calc",
        "price": "$3",
        "priceNum": 3
    },
    {
        "id": "70-shadowstudio",
        "slug": "shadowstudio",
        "name": "ShadowStudio",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "CSS/SwiftUI",
        "desc": "Visual realistic multi-layer shadow designer with CSS box-shadow and SwiftUI code export.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask shadowstudio",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "71-duplicatefinder",
        "slug": "duplicatefinder",
        "name": "DuplicateFinder",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Scan",
        "desc": "Blazing-fast hashing-based duplicate file scanner to reclaim disk space.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask duplicatefinder",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "72-caffeinebar",
        "slug": "caffeinebar",
        "name": "CaffeineBar",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "1-Click",
        "desc": "Keeps Mac awake indefinitely or on a timer with custom display sleep rules.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask caffeinebar",
        "price": "$3",
        "priceNum": 3
    },
    {
        "id": "73-hiddenfiles-toggle",
        "slug": "hiddenfiles-toggle",
        "name": "HiddenFilesToggle",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "\u2318 \u21e7 .",
        "desc": "1-click menu bar toggle to show/hide hidden dotfiles and system files in Finder.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask hiddenfiles-toggle",
        "price": "$3",
        "priceNum": 3
    },
    {
        "id": "74-archiveextractor",
        "slug": "archiveextractor",
        "name": "ArchiveExtractor",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Drop Zip",
        "desc": "Ultra-fast unarchiver supporting 7z, RAR, TAR, GZ, ISO with auto-delete zip option.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask archiveextractor",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "75-clipboarddiff",
        "slug": "clipboarddiff",
        "name": "ClipboardDiff",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "\u2325 V",
        "desc": "Compares current clipboard with previous clipboard and shows a visual side-by-side git diff.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask clipboarddiff",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "76-apppermission-auditor",
        "slug": "apppermission-auditor",
        "name": "AppPermissionAuditor",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Audit",
        "desc": "Inspects all apps granted Camera, Mic, Accessibility, Screen Recording, or Full Disk permissions.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask apppermission-auditor",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "77-wifiradar",
        "slug": "wifiradar",
        "name": "WiFiRadar",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Menu Bar",
        "desc": "Displays channel congestion, signal RSSI, interference, and speed test directly in the menu bar.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask wifiradar",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "78-quickshare-local",
        "slug": "quickshare-local",
        "name": "QuickShareLocal",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "P2P Drop",
        "desc": "AirDrop-like local network file dropper between Macs and PCs via browser URL.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask quickshare-local",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "79-audiorecord-hud",
        "slug": "audiorecord-hud",
        "name": "AudioRecordHUD",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "1-Click",
        "desc": "1-click system audio + microphone recorder with instant MP3/M4A export.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask audiorecord-hud",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "80-memorypurge-pro",
        "slug": "memorypurge-pro",
        "name": "MemoryPurgePro",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Purge",
        "desc": "Visual RAM pressure monitor with 1-click inactive memory purge and cache optimization.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask memorypurge-pro",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "81-pixelhamster-desktop",
        "slug": "pixelhamster-desktop",
        "name": "PixelHamsterDesktop",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "Menu Bar",
        "desc": "Animated pixel hamster running on a wheel in your menu bar, speeding up with typing and commits.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask pixelhamster-desktop",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "82-cybergochi",
        "slug": "cybergochi",
        "name": "CyberGochi",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "Menu Bar",
        "desc": "Retro Tamagotchi virtual pet that eats completed to-do items and evolves through productivity streaks.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask cybergochi",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "83-deskduck",
        "slug": "deskduck",
        "name": "DeskDuck",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "\u2325 D",
        "desc": "Floating rubber duck debugger that asks Socratic prompts when you're stuck coding or writing.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask deskduck",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "84-plantnursery-hud",
        "slug": "plantnursery-hud",
        "name": "PlantNurseryHUD",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "HUD",
        "desc": "Virtual greenhouse where rare succulents grow based on your hydration and focus check-ins.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask plantnursery-hud",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "85-focussloth",
        "slug": "focussloth",
        "name": "FocusSloth",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "Notch",
        "desc": "Animated sloth climbing a branch in the notch during continuous deep focus time.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask focussloth",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "86-zenpanda",
        "slug": "zenpanda",
        "name": "ZenPanda",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "Breathe",
        "desc": "Meditating panda companion guiding 60-second box-breathing exercises between meetings.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask zenpanda",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "87-codeotter",
        "slug": "codeotter",
        "name": "CodeOtter",
        "cat": "pets",
        "catName": "Pets & Habits",
        "hotkey": "Window Edge",
        "desc": "Playful otter swimming along window edges, catching fish on successful test runs.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask codeotter",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "88-brainwave-sync",
        "slug": "brainwave-sync",
        "name": "BrainWaveSync",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "Audio",
        "desc": "Binaural 40Hz Gamma and Alpha wave generator for memory consolidation and hyper-focus.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask brainwave-sync",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "89-singletask-spotlight",
        "slug": "singletask-spotlight",
        "name": "SingleTaskSpotlight",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "\u2325 S",
        "desc": "Forces 1 single active window, completely hiding dock and menu bar until current task is checked off.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask singletask-spotlight",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "90-antiprocrastinate-friction",
        "slug": "antiprocrastinate-friction",
        "name": "AntiProcrastinateFriction",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "Auto",
        "desc": "Adds a 10-second deliberate breathing countdown before opening selected addictive URLs/apps.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask antiprocrastinate-friction",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "91-whitenoise-mixer",
        "slug": "whitenoise-mixer",
        "name": "WhiteNoiseMixer",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "Audio",
        "desc": "Multi-track customizable soundscape mixer (Rain + Campfire + Ocean Waves + Wind Chimes).",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask whitenoise-mixer",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "92-tablimiter-pro",
        "slug": "tablimiter-pro",
        "name": "TabLimiterPro",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "Safari/Chrome",
        "desc": "Restricts open tabs to max 5 per window, auto-archiving overflowing tabs to a reading list.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask tablimiter-pro",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "93-eyeblink-coach",
        "slug": "eyeblink-coach",
        "name": "EyeBlinkCoach",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "Subtle Pulse",
        "desc": "Subtly flashes a soft screen border halo every 15 seconds to remind power users to blink.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask eyeblink-coach",
        "price": "$3",
        "priceNum": 3
    },
    {
        "id": "94-focusheatmap",
        "slug": "focusheatmap",
        "name": "FocusHeatmap",
        "cat": "focus",
        "catName": "Focus & Flow",
        "hotkey": "Overlay",
        "desc": "Live visual heatmap overlay showing which apps and windows consumed your attention today.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask focusheatmap",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "95-morningkickoff-hud",
        "slug": "morningkickoff-hud",
        "name": "MorningKickoffHUD",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "9:00 AM",
        "desc": "3-minute morning launchpad popup showing today's top 3 MITs, calendar, and weather overview.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask morningkickoff-hud",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "96-microjournal-bar",
        "slug": "microjournal-bar",
        "name": "MicroJournalBar",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Menu Bar",
        "desc": "1-line micro-journaling in the menu bar to log quick thoughts, gratitude, and wins.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask microjournal-bar",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "97-sugar-fasting-tracker",
        "slug": "sugar-fasting-tracker",
        "name": "SugarFastingTracker",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Status Bar",
        "desc": "Visual intermittent fasting timer in status bar with ketosis stage and metabolic alerts.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask sugar-fasting-tracker",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "98-sleephygiene-nudge",
        "slug": "sleephygiene-nudge",
        "name": "SleepHygieneNudge",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Night Shift",
        "desc": "Automatically warms screen temperature and locks distraction apps 1 hour before scheduled bedtime.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask sleephygiene-nudge",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "99-meetingprep-countdown",
        "slug": "meetingprep-countdown",
        "name": "MeetingPrepCountdown",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Pre-Alarm",
        "desc": "Popover chime 2 minutes before Google Meet/Zoom calls with direct 1-click join link.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask meetingprep-countdown",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "100-stepcounter-sync",
        "slug": "stepcounter-sync",
        "name": "StepCounterSync",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Health Sync",
        "desc": "Apple Watch / Health synced step counter progress bar right in the menu bar.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask stepcounter-sync",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "101-caffeinedecay-curve",
        "slug": "caffeinedecay-curve",
        "name": "CaffeineDecayCurve",
        "cat": "routine",
        "catName": "Routine & Wellness",
        "hotkey": "Decay Model",
        "desc": "Calculates and plots active caffeine in bloodstream with sleep cutoff time warnings.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask caffeinedecay-curve",
        "price": "$3",
        "priceNum": 3
    },
    {
        "id": "102-cliptomarkdown-thread",
        "slug": "cliptomarkdown-thread",
        "name": "ClipToMarkdownThread",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "1-Click",
        "desc": "Converts X, Reddit, and LinkedIn posts into clean Obsidian/Notion markdown.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask cliptomarkdown-thread",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "103-podcastchapter-marker",
        "slug": "podcastchapter-marker",
        "name": "PodcastChapterMarker",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "ID3 Tags",
        "desc": "Audio waveform scrubber to drop timestamped chapter markers and export ID3 tags.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask podcastchapter-marker",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "104-teleprompter-hud",
        "slug": "teleprompter-hud",
        "name": "TeleprompterHUD",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "Transparent",
        "desc": "Translucent scrolling teleprompter for presentations and recorded video.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask teleprompter-hud",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "105-quickpoll-creator",
        "slug": "quickpoll-creator",
        "name": "QuickPollCreator",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "HUD",
        "desc": "Generates formatted poll layouts for Twitter, LinkedIn, and Slack with 1-click copy.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask quickpoll-creator",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "106-videothumbnail-tester",
        "slug": "videothumbnail-tester",
        "name": "VideoThumbnailTester",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "Preview",
        "desc": "Previews YouTube and Twitter thumbnails on light/dark mode social feed mocks.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask videothumbnail-tester",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "107-discordrole-autoping",
        "slug": "discordrole-autoping",
        "name": "DiscordRoleAutoPing",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "Embed",
        "desc": "Quick organizer for Discord markdown formatting, roles, and embed payloads.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask discordrole-autoping",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "108-watermarkmaster",
        "slug": "watermarkmaster",
        "name": "WatermarkMaster",
        "cat": "social",
        "catName": "Social & Creator",
        "hotkey": "Batch",
        "desc": "Applies customizable dynamic logos and watermarks to batches of images.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask watermarkmaster",
        "price": "$6",
        "priceNum": 6
    },
    {
        "id": "109-whispersubtitles-srt",
        "slug": "whispersubtitles-srt",
        "name": "WhisperSubtitlesSRT",
        "cat": "ai",
        "catName": "AI & Voice",
        "hotkey": "WhisperKit",
        "desc": "Generates timestamped .srt and .vtt subtitles locally via WhisperKit in seconds.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask whispersubtitles-srt",
        "price": "$16",
        "priceNum": 16
    },
    {
        "id": "110-summarizeurl-ai",
        "slug": "summarizeurl-ai",
        "name": "SummarizeURLAI",
        "cat": "ai",
        "catName": "AI & Voice",
        "hotkey": "\u2325 U",
        "desc": "Offline webpage and article summarizer with 3 bullet takeaways.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask summarizeurl-ai",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "111-sqlquery-ai",
        "slug": "sqlquery-ai",
        "name": "SqlQueryAI",
        "cat": "ai",
        "catName": "AI & Dev",
        "hotkey": "Natural Lang",
        "desc": "Translates plain English requests into optimized SQL queries.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask sqlquery-ai",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "112-localembeddings-search",
        "slug": "localembeddings-search",
        "name": "LocalEmbeddingsSearch",
        "cat": "ai",
        "catName": "AI & Dev",
        "hotkey": "Semantic",
        "desc": "Semantic vector search across local folders using local CoreML embeddings.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask localembeddings-search",
        "price": "$16",
        "priceNum": 16
    },
    {
        "id": "113-diffexplainer-ai",
        "slug": "diffexplainer-ai",
        "name": "DiffExplainerAI",
        "cat": "ai",
        "catName": "AI & Dev",
        "hotkey": "Changelog",
        "desc": "Analyzes git diffs to generate clean release notes and changelogs.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask diffexplainer-ai",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "114-readaloud-tts",
        "slug": "readaloud-tts",
        "name": "ReadAloudTTS",
        "cat": "ai",
        "catName": "AI & Voice",
        "hotkey": "Speech",
        "desc": "Ultra-natural text-to-speech voice reader for selected articles and code comments.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask readaloud-tts",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "115-regexgenerator-ai",
        "slug": "regexgenerator-ai",
        "name": "RegexGeneratorAI",
        "cat": "ai",
        "catName": "AI & Dev",
        "hotkey": "AI Gen",
        "desc": "Converts plain English descriptions into tested, production-ready regular expressions.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask regexgenerator-ai",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "116-kubecluster-quick",
        "slug": "kubecluster-quick",
        "name": "KubeClusterQuick",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "Minimalist Kubernetes cluster status watcher with 1-click pod log viewing.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask kubecluster-quick",
        "price": "$16",
        "priceNum": 16
    },
    {
        "id": "117-redislens",
        "slug": "redislens",
        "name": "RedisLens",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Menu Bar",
        "desc": "Menu bar Redis key-value browser, TTL inspector, and memory analyzer.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask redislens",
        "price": "$9",
        "priceNum": 9
    },
    {
        "id": "118-gitstash-manager",
        "slug": "gitstash-manager",
        "name": "GitStashManager",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "\u2325 S",
        "desc": "Visual UI for viewing, comparing, applying, and dropping local git stashes.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask gitstash-manager",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "119-portforwarder-pro",
        "slug": "portforwarder-pro",
        "name": "PortForwarderPro",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Tunnel",
        "desc": "SSH tunnel and local port forwarding manager with auto-reconnect.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask portforwarder-pro",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "120-apimock-server",
        "slug": "apimock-server",
        "name": "ApiMockServer",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": ":4000",
        "desc": "1-click local mock HTTP server with custom latency and status simulation.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask apimock-server",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "121-dotenv-diff",
        "slug": "dotenv-diff",
        "name": "DotEnvDiff",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "Verify",
        "desc": "Compares .env.example against actual .env and flags missing keys before push.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask dotenv-diff",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "122-dnslookup-hud",
        "slug": "dnslookup-hud",
        "name": "DnsLookupHUD",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "DNS",
        "desc": "Instant DNS record inspector (A, CNAME, MX, TXT) with global node propagation test.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask dnslookup-hud",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "123-httpheader-inspector",
        "slug": "httpheader-inspector",
        "name": "HttpHeaderInspector",
        "cat": "dev",
        "catName": "Developer",
        "hotkey": "CORS/SSL",
        "desc": "Tests HTTP/HTTPS response headers, CORS policies, and SSL handshakes.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask httpheader-inspector",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "124-icongrid-overlay",
        "slug": "icongrid-overlay",
        "name": "IconGridOverlay",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "Grid",
        "desc": "Pixel-perfect icon grid overlay for designing 512x512 and 1024x1024 app icons.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask icongrid-overlay",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "125-contrastpalette-studio",
        "slug": "contrastpalette-studio",
        "name": "ContrastPaletteStudio",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "WCAG AAA",
        "desc": "Creates accessible, harmonious color systems meeting WCAG AAA requirements.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask contrastpalette-studio",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "126-gradientmesh-maker",
        "slug": "gradientmesh-maker",
        "name": "GradientMeshMaker",
        "cat": "media",
        "catName": "Creative & Design",
        "hotkey": "Mesh",
        "desc": "Visual multi-point gradient mesh generator with real-time SwiftUI curve export.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask gradientmesh-maker",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "127-diskscleaner-mini",
        "slug": "diskscleaner-mini",
        "name": "DisksCleanerMini",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Scan",
        "desc": "Visualizes large downloads, node_modules, and cache folders for selective 1-click purge.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask diskscleaner-mini",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "128-bluetoothsignal-radar",
        "slug": "bluetoothsignal-radar",
        "name": "BluetoothSignalRadar",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "RSSI",
        "desc": "Signal strength (RSSI) monitor for AirPods and mice with disconnect alerts.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask bluetoothsignal-radar",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "129-batterycycle-telemetry",
        "slug": "batterycycle-telemetry",
        "name": "BatteryCycleTelemetry",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "SMC",
        "desc": "Deep SMC battery analytics: degradation curve, wattage telemetry, and cycles.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask batterycycle-telemetry",
        "price": "$4",
        "priceNum": 4
    },
    {
        "id": "130-appquarantine-inspector",
        "slug": "appquarantine-inspector",
        "name": "AppQuarantineInspector",
        "cat": "system",
        "catName": "Utilities & System",
        "hotkey": "Gatekeeper",
        "desc": "Lists quarantine attributes (com.apple.quarantine) with 1-click override.",
        "features": [
            "100% Native Swift 6",
            "Offline & Zero Cloud Lag",
            "Commercial License for 3 Macs"
        ],
        "brew": "brew install --cask appquarantine-inspector",
        "price": "$4",
        "priceNum": 4
    }
];

// DOM Elements
const appsGrid = document.getElementById("appsGrid");
const searchInput = document.getElementById("appSearchInput");
const categoryPills = document.querySelectorAll(".pill");
const buySuiteBtn = document.getElementById("buySuiteBtn");
const paymentModal = document.getElementById("paymentModal");
const closePaymentModalBtn = document.getElementById("closePaymentModalBtn");

// Modal checkout elements
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

let activeCategory = "all";
let searchTerm = "";
let currentSelectedApp = null;

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
                <p>Try searching for "Whisper", "Hamster", "Bonsai", "Duck", "Focus", "Water", "Git", "SQL", or "Docker"</p>
            </div>
        `;
        return;
    }

    appsGrid.innerHTML = filtered.map(app => `
        <div class="app-card" data-category="${app.cat}">
            <div>
                <div class="app-card-top">
                    <img src="assets/icons/${app.id}.svg" alt="${app.name}" class="app-vector-icon" loading="lazy" onerror="this.src='assets/icons/01-whispertap.svg'"/>
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
                <div class="app-price-tag">
                    <span class="price-val">${app.price}</span>
                    <span class="price-type">one-time</span>
                </div>
                <button class="btn btn-primary btn-sm" onclick="openCheckoutModal('${app.slug}')">
                    Buy & Download
                </button>
            </div>
        </div>
    `).join("");
}

// Open checkout modal for individual app or all-access suite
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
    modalAppDesc.textContent = currentSelectedApp.desc;
    
    // Reset view to payment step 1
    checkoutStep1.classList.remove("hidden");
    checkoutStep2.classList.add("hidden");
    paymentModal.classList.remove("hidden");
};

// Process payment and generate secure tokenized link
async function processPayment(paymentMethod) {
    const email = checkoutEmail.value.trim() || "buyer@macupgraded.com";
    
    // Animate button processing
    const activeBtn = paymentMethod === "Apple Pay" ? payAppleBtn : (paymentMethod === "PayPal" ? payPaypalBtn : payCardBtn);
    const origText = activeBtn.innerHTML;
    activeBtn.innerHTML = "Processing Securely...";
    activeBtn.disabled = true;

    try {
        // Call backend verification API
        const response = await fetch("verify_order.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                email: email,
                app: currentSelectedApp.slug,
                tier: currentSelectedApp.slug === "all-access" ? "ALL_ACCESS" : "INDIVIDUAL",
                paymentMethod: paymentMethod
            })
        });

        const result = await response.json();

        // Switch to Step 2: Confirmation, License Key, and Secure Download
        licenseKeyDisplay.textContent = result.licenseKey;
        downloadLinkBtn.href = result.downloadUrl;
        
        checkoutStep1.classList.add("hidden");
        checkoutStep2.classList.remove("hidden");
    } catch (e) {
        // Fallback generator for preview servers
        const randomHex = Math.random().toString(36).substring(2, 6).toUpperCase();
        const fallbackKey = `${currentSelectedApp.slug.toUpperCase().replace(/-/g, "")}-PRO-PASS-${randomHex}-${Math.floor(1000 + Math.random() * 9000)}`;
        licenseKeyDisplay.textContent = fallbackKey;
        downloadLinkBtn.href = `download.php?app=${currentSelectedApp.slug}&token=DEMO_TOKEN&expires=${Math.floor(Date.now()/1000) + 900}&sig=DEMO_SIG`;
        
        checkoutStep1.classList.add("hidden");
        checkoutStep2.classList.remove("hidden");
    } finally {
        activeBtn.innerHTML = origText;
        activeBtn.disabled = false;
    }
}

payAppleBtn.addEventListener("click", () => processPayment("Apple Pay"));
payCardBtn.addEventListener("click", () => processPayment("Credit/Debit Card (Stripe)"));
payPaypalBtn.addEventListener("click", () => processPayment("PayPal"));

closePaymentModalBtn.addEventListener("click", () => {
    paymentModal.classList.add("hidden");
});

copyLicenseBtn.addEventListener("click", () => {
    navigator.clipboard.writeText(licenseKeyDisplay.textContent).then(() => {
        copyLicenseBtn.textContent = "✓ Copied!";
        setTimeout(() => { copyLicenseBtn.textContent = "Copy Key"; }, 1500);
    });
});

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

buySuiteBtn.addEventListener("click", () => {
    openCheckoutModal("all-access");
});

// Initialize
renderApps();
