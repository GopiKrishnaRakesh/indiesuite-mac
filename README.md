#  IndieSuite Mac — 30 Native macOS Power Utilities

> **30 hyper-fast, lightweight, zero-bloat native macOS applications designed for developers, creators, and power users.** Built with Swift 6 & SwiftUI, with zero Electron memory overhead and direct website/Homebrew distribution.

---

## 📦 What's Inside

```
.
├── apps/                       # 30 Standalone Native macOS Applications
│   ├── 01-whispertap/          # Global Push-to-Talk AI Dictation (WhisperKit/MLX)
│   ├── 02-tokenwatch/          # Real-time LLM API Spend & Rate-Limit Monitor
│   ├── 03-locallens-ocr/       # Instant Screen-to-Code & OCR Snipper
│   ├── 04-portsentry/          # Menu Bar Port & Zombie Process Killer
│   ├── 05-shrinkmedia/         # Hardware VideoToolbox Media Compressor
│   ├── 06-colorforge/          # Eyedropper & WCAG 2.2 AAA Contrast Auditor
│   ├── 07-notchshelf/          # MacBook Notch Drop-Zone & Staging Shelf
│   ├── 08-audiomix/            # Per-App Volume Mixer & Audio Device Router
│   ├── 09-micmute-hud/         # Hardware Mic Mute & HUD Dynamic Indicator
│   ├── 10-promptdock/          # Global Floating Prompt Palette & Snippet Injector
│   ├── 11-snaptile/            # Keyboard & Edge Window Tiling Manager
│   ├── 12-purgeapp/            # Deep Uninstaller & Residue Cleaner
│   ├── 13-chargeguard/         # Battery Health Optimizer & 80% Charge Limiter
│   ├── 14-envvault/            # Secure .env & Secret Workspace Manager
│   ├── 15-devtunnel-hud/       # Cloudflare & Ngrok Tunnel Traffic Inspector
│   ├── 16-gitpulse/            # Multi-Repo Status Bar Tracker
│   ├── 17-regexforge/          # Live Regex Visual Debugger & Code Exporter
│   ├── 18-svgoptim/            # SVG Optimizer & SwiftUI/React Generator
│   ├── 19-fontinspect/         # Local Font Viewer & Variable Axis Tester
│   ├── 20-presentercam/        # Floating Camera Overlay for Screen Demos
│   ├── 21-cleandesk-pro/       # 1-Click Presentation & Clutter Cleaner
│   ├── 22-screenruler/         # Precision Pixel Ruler & Alignment Crosshair
│   ├── 23-apphop/              # Quick-Switch Popup for Active App Windows
│   ├── 24-scratchpad-hud/      # Always-On-Top Markdown Floating Scratchpad
│   ├── 25-timebridge/          # Visual Timezone Slider & Meeting Overlap Finder
│   ├── 26-menucleaner/         # Menu Bar Icon Hider & Divider Organizer
│   ├── 27-metascrub/           # Privacy EXIF & GPS Location Metadata Stripper
│   ├── 28-bandwidthradar/      # Real-Time Per-App Network Monitor
│   ├── 29-bluetoothautohop/    # Smart Bluetooth Auto-Disconnect on Sleep
│   └── 30-privatellm-bar/      # Ultra-Lightweight Offline Local LLM Runner
├── shared/                     # Reusable Core Packages
│   ├── DesignSystem/           # Liquid Glass UI, Themes, Animated Badges
│   ├── AppKitKit/              # MenuBar Controller, Global Hotkeys, Sparkle
│   ├── Licensing/              # Offline HMAC/Ed25519 License Key Validator
│   └── AudioVideoCore/         # VideoToolbox Compressor & Vision OCR
├── dist/
│   └── casks/                  # 30 Homebrew Cask Ruby Definitions
├── scripts/                    # Build, DMG packager & release automation
└── website/                    # Live Storefront & Showcase Web App
```

---

## 🚀 Quick Start

### Build All 30 Apps
```bash
./scripts/build_all.sh
```

### Run an Individual App
```bash
cd "apps/01-whispertap" && swift run
```

### Generate Homebrew Casks
```bash
./scripts/generate_cask.sh
```

### Package App into `.dmg`
```bash
./scripts/package_dmg.sh WhisperTap 1.0.0 apps/01-whispertap/.build/debug/WhisperTap
```

### Run Website Storefront Locally
```bash
npx http-server website -p 4242
```
Open [http://localhost:4242](http://localhost:4242)

---

## 📄 License
Commercial Indie License / All-Access Lifetime Pass.
