#!/usr/bin/env python3
import os
import re

# Comprehensive Blueprint Generator for all 130 apps
from scaffold_50_more_apps import new_50_apps as apps_31_to_80
from scaffold_apps_81_to_130 import apps_81_to_130

apps_1_to_30_specs = [
    {
        "id": "01-whispertap", "name": "WhisperTap", "cat": "ai", "catName": "Local AI & Voice Intelligence",
        "hotkey": "⌥ Space", "price": "$19",
        "pitch": "Stop typing repetitive emails, docs, and Slack messages. WhisperTap brings local OpenAI Whisper dictation to every single text input on macOS with zero latency, zero cloud API fees, and 100% offline privacy.",
        "use_cases": [
            "Dictate long architectural RFCs, GitHub PR descriptions, and Notion documents 4x faster than typing.",
            "Reply to Slack threads and customer emails in seconds with instant automatic clipboard pasting.",
            "Private dictation in HIPAA, SOC2, and confidential enterprise environments where cloud audio streaming is prohibited."
        ],
        "how_it_works": "WhisperTap registers a global system hotkey (⌥ Space) via Carbon Event Hotkeys. On keydown, AVFoundation opens an uncompressed 16kHz mono audio capture stream into a circular ring buffer. When the key is released, the audio buffer is fed directly into a local Whisper.cpp / MLX CoreML model running on Apple Silicon Neural Engine (ANE). The transcribed string is filtered through a developer syntax cleaner and immediately injected into the active focused window using CGEventPost keyboard simulation.",
        "features": [
            "100% Offline CoreML / Apple Silicon Neural Engine inference (Tiny, Base, Small, Medium models)",
            "Zero cloud round-trips — your voice never leaves your Mac",
            "Auto-pastes transcribed text directly into focused text field",
            "Dev Mode: Auto-formats camelCase, snake_case, punctuation, and code blocks",
            "Custom vocabulary booster for names, company jargon, and technical keywords",
            "Audio waveform visualizer dynamic HUD during active dictation"
        ]
    },
    {
        "id": "02-tokenwatch", "name": "TokenWatch", "cat": "ai", "catName": "Local AI & Developer Tools",
        "hotkey": "Menu Bar Live", "price": "$14",
        "pitch": "Never get surprised by a $500 monthly OpenAI or Anthropic bill again. TokenWatch sits right in your menu bar, tracking your real-time API spend, token consumption rates, and rate limit ceilings across every LLM provider.",
        "use_cases": [
            "Monitor live cost spikes when running automated AI agent loops, batch embedding jobs, or LangChain pipelines.",
            "Track multiple client API keys with separate budget thresholds and automatic emergency cutoff alerts.",
            "Audit cost-per-prompt efficiency across GPT-4o, Claude 3.5 Sonnet, Gemini 1.5 Pro, and Groq."
        ],
        "how_it_works": "Runs an async background polling daemon using URLSession that securely queries usage endpoints for OpenAI, Anthropic, Google Gemini, Groq, and OpenRouter every 60 seconds using keys stored in macOS Keychain. Computes delta velocity ($/minute and tokens/sec). If usage velocity breaches a user-defined threshold, it triggers an NSUserNotification and updates the NSStatusItem title with a flashing warning badge.",
        "features": [
            "Live status bar cost ticker (e.g. '$12.45 today • 42k t/m')",
            "Multi-provider aggregation: OpenAI, Anthropic, Gemini, Groq, OpenRouter, Mistral, Perplexity",
            "Custom budget alarms with sound notifications and automatic process kill scripts",
            "Per-project API key grouping and monthly exportable CSV expense reports",
            "Keychain-encrypted local key storage with zero telemetry"
        ]
    },
    {
        "id": "03-locallens-ocr", "name": "LocalLens OCR", "cat": "ai", "catName": "Local AI & Vision",
        "hotkey": "⌘ ⇧ 2", "price": "$16",
        "pitch": "Extract clean code, JSON, formatted tables, and math equations from videos, zoom calls, images, and unselectable PDFs in 0.2 seconds. No cloud upload, no broken line-wraps.",
        "use_cases": [
            "Instantly copy code snippets from YouTube tutorials, conference livestreams, and Loom recordings.",
            "Grab unselectable tabular data from legacy web apps and paste directly into Google Sheets/Excel as clean CSV.",
            "Extract LaTeX mathematical formulas directly from academic PDF papers."
        ],
        "how_it_works": "Activates an interactive screen marquee selection overlay using an NSWindow with a transparent tracking view. Captures the selected CGWindowList pixel buffer and dispatches it directly to Apple's VNRecognizeTextRequest (Vision Framework) with recognitionLevel = .accurate. Passes recognized text blocks through a regex AST cleaner that strips spurious line breaks, fixes indentation tabs, and formats JSON/code before copying to NSPasteboard.",
        "features": [
            "Vision Neural Engine OCR with sub-200ms recognition speed",
            "Code Mode: Preserves 2/4-space indentation, brackets, and syntax structure",
            "Table Mode: Converts visual column grids into CSV / Markdown tables",
            "LaTeX Math Mode: Converts screen formulas into equation markup",
            "QR & Barcode scanner with instant 1-click URL preview",
            "Floating history tray storing your last 50 text captures"
        ]
    },
    {
        "id": "04-portsentry", "name": "PortSentry", "cat": "dev", "catName": "Developer Tools",
        "hotkey": "Menu Bar", "price": "$9",
        "pitch": "Kill stubborn 'Error: listen EADDRINUSE :::3000' bugs in 1 second. PortSentry monitors all listening local network ports, reveals rogue zombie node/python processes, and kills them with a single click.",
        "use_cases": [
            "Instantly free up occupied ports (3000, 8080, 5173, 8000) when dev servers crash in the background.",
            "Inspect memory footprint and launch command of every local listening web server.",
            "1-click browser preview of any active localhost service."
        ],
        "how_it_works": "Executes optimized BSD socket inspection using libproc and lsof commands in a non-blocking background thread. Maps active listening sockets (IPv4 & IPv6) to process identifiers (PIDs), process executable names, memory consumption, and runtime uptime. NSStatusItem popover displays interactive list with a direct SIGTERM / SIGKILL button that calls kill(pid, SIGKILL) via standard POSIX APIs.",
        "features": [
            "Real-time port monitor (Ports 80, 3000, 5000, 5173, 8000, 8080, 9000, etc.)",
            "1-Click 'Kill Process' button that instantly reclaims the port",
            "1-Click 'Open in Browser' (http://localhost:PORT)",
            "PID, process path, and memory usage inspection",
            "Search and filter by port number, service name, or PID",
            "Auto-notification when a port is unexpectedly occupied by another process"
        ]
    },
    {
        "id": "05-shrinkmedia", "name": "ShrinkMedia", "cat": "media", "catName": "Creative & Media Processing",
        "hotkey": "Drag & Drop", "price": "$11",
        "pitch": "Compress massive 4K screen recordings, MP4 videos, and audio files by up to 88% in seconds without quality loss using Apple Silicon hardware VideoToolbox.",
        "use_cases": [
            "Shrink 500MB Loom recordings into 25MB MP4 files for instant Slack/Discord sharing.",
            "Batch compress entire folders of product demo videos for website hero sections.",
            "Convert bulky screen recordings into lightweight animated GIFs."
        ],
        "how_it_works": "Reads dropped video/audio URLs and initializes an AVAssetReader / AVAssetWriter pipeline with VTCompressionSession using hardware-accelerated HEVC / H.264 encoders on Apple Silicon VideoToolbox. Applies adaptive two-pass bitrate optimization based on frame complexity, ensuring maximum visual fidelity at a fraction of the file size.",
        "features": [
            "Hardware VideoToolbox acceleration (M1/M2/M3/M4 optimized)",
            "Presets for Discord (25MB), Slack (50MB), Email (10MB), and Web Hero (Ultra-compressed)",
            "Batch drag-and-drop support for 100+ files simultaneously",
            "Lossless GIF, MP4, WebM, and ProRes conversion",
            "Side-by-side visual quality comparison slider before exporting",
            "Automatic metadata and audio track normalization"
        ]
    },
    {
        "id": "06-colorforge", "name": "ColorForge", "cat": "media", "catName": "Creative & Design",
        "hotkey": "⌘ ⇧ C", "price": "$7",
        "pitch": "The ultimate macOS color eyedropper and palette studio. Inspect any pixel with 16x zoom magnifier, verify WCAG 2.2 AAA accessibility contrast ratios, and copy in SwiftUI, CSS, Hex, HSL, or NSColor in 1 click.",
        "use_cases": [
            "Inspect design tokens and colors directly from Figma, websites, and native apps.",
            "Verify compliance with international accessibility standards (WCAG AAA/AA).",
            "Export color palettes directly into Swift Color asset catalogs and CSS variables."
        ],
        "how_it_works": "Creates an NSWindow crosshair loupe tracking NSEvent.mouseLocation. Captures a 32x32 pixel matrix from the display framebuffer using CGWindowListCreateImage. Computes RGB, HSL, and sRGB color coordinates in real time. Calculates relative luminance and contrast ratios between foreground and background according to W3C WCAG 2.2 formulas.",
        "features": [
            "16x precision pixel magnifier loupe with grid coordinates",
            "Instant 1-click format copy (Hex, RGB, HSL, SwiftUI Color, NSColor, UIColor, CSS var)",
            "Live WCAG 2.2 AA & AAA contrast compliance validator",
            "Palette Builder: Save, name, and categorize custom project color swatches",
            "Color Blindness Simulator: Preview palettes under Protanopia, Deuteranopia, and Tritanopia",
            "Export palettes to ASE, JSON, Swift, and Tailwind CSS configs"
        ]
    }
]

print("Writing exhaustive specifications for all 130 apps...")
with open("APP_CATALOG_SPECIFICATIONS.md", "w") as f:
    f.write("""# IndieSuite / MacUpgraded: 130 Standalone Native macOS Applications
## Complete Commercial Sales Copy & Software Engineering Architecture Blueprints

This document provides exhaustive, high-converting commercial descriptions, value propositions, primary use cases, and detailed engineering architecture blueprints for all **130 native macOS applications** in the IndieSuite / MacUpgraded monorepo.

---

# Table of Contents
1. [Category 1: Local AI, Voice & Speech Intelligence (17 Apps)](#category-1-local-ai-voice--speech-intelligence)
2. [Category 2: Interactive Desktop Pets & Habit Companions (12 Apps)](#category-2-interactive-desktop-pets--habit-companions)
3. [Category 3: Focus, Deep Work & Flow States (12 Apps)](#category-3-focus-deep-work--flow-states)
4. [Category 4: Daily Routine, Wellness & Micro-Habits (12 Apps)](#category-4-daily-routine-wellness--micro-habits)
5. [Category 5: Social, Creator & Content Production (12 Apps)](#category-5-social-creator--content-production)
6. [Category 6: Developer & DevOps Power Tools (23 Apps)](#category-6-developer--devops-power-tools)
7. [Category 7: Creative Media & Design Utilities (18 Apps)](#category-7-creative-media--design-utilities)
8. [Category 8: System, Privacy & Hardware Optimization (24 Apps)](#category-8-system-privacy--hardware-optimization)

---
""")

    # Combine all 130 apps into master list
    all_apps = []
    
    # Process First 30
    for a in apps_1_to_30_specs:
        all_apps.append(a)
        
    # Read rest from existing scaffolds if available or format
    print("Catalog generator ready.")
