// App Data Catalog for 30 Native macOS Apps
const apps = [
    {
        id: "01-whispertap",
        name: "WhisperTap",
        cat: "ai",
        catName: "AI & Voice",
        icon: "🎙️",
        hotkey: "⌥ Space",
        desc: "Global push-to-talk AI dictation into any text field via Apple Silicon MLX WhisperKit.",
        features: ["100% Offline & Private", "Auto-paste into focused app", "Code & Dev mode cleanup"],
        brew: "brew install --cask whispertap",
        dmg: "downloads/whispertap-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "02-tokenwatch",
        name: "TokenWatch",
        cat: "ai",
        catName: "AI & Dev",
        icon: "💳",
        hotkey: "Menu Bar",
        desc: "Menu bar real-time LLM API spend & rate-limit monitor for OpenAI, Anthropic, Gemini & Groq.",
        features: ["Live status bar cost ticker", "Budget limit alerts", "Per-project token tracking"],
        brew: "brew install --cask tokenwatch",
        dmg: "downloads/tokenwatch-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "03-locallens-ocr",
        name: "LocalLens OCR",
        cat: "ai",
        catName: "AI & Vision",
        icon: "🔍",
        hotkey: "⌘ ⇧ 2",
        desc: "Instant screen-to-code, JSON, LaTeX, and table extractor with regex formatting.",
        features: ["Vision Neural Engine OCR", "Code syntax formatting", "Zero line-wrap distortion"],
        brew: "brew install --cask locallens-ocr",
        dmg: "downloads/locallens-ocr-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "04-portsentry",
        name: "PortSentry",
        cat: "dev",
        catName: "Developer",
        icon: "🌐",
        hotkey: "Menu Bar",
        desc: "Active port & zombie process killer. Shows listening ports, process PIDs, and 1-click kill.",
        features: ["Instant port release", "PID & memory inspector", "1-click browser preview"],
        brew: "brew install --cask portsentry",
        dmg: "downloads/portsentry-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "05-shrinkmedia",
        name: "ShrinkMedia",
        cat: "media",
        catName: "Creative & Media",
        icon: "🗜️",
        hotkey: "Drag & Drop",
        desc: "Fast drag-and-drop batch video/audio/image compressor using hardware VideoToolbox.",
        features: ["Up to 88% size reduction", "Lossless GIF & MP4 export", "Apple Silicon HW encoder"],
        brew: "brew install --cask shrinkmedia",
        dmg: "downloads/shrinkmedia-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "06-colorforge",
        name: "ColorForge",
        cat: "media",
        catName: "Design & Dev",
        icon: "🎨",
        hotkey: "⌘ ⇧ C",
        desc: "Native eyedropper, palette builder, and WCAG 2.2 AAA contrast compliance checker.",
        features: ["1-click SwiftUI/CSS/Hex export", "Global screen magnifier", "Palette history sync"],
        brew: "brew install --cask colorforge",
        dmg: "downloads/colorforge-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "07-notchshelf",
        name: "NotchShelf",
        cat: "window",
        catName: "Workflow",
        icon: "📥",
        hotkey: "Top Bezel",
        desc: "Smart drop-zone & staging area hidden inside the MacBook notch for files, links & screenshots.",
        features: ["Zero desktop clutter", "Smooth hover reveal", "Drag-to-Slack/Terminal"],
        brew: "brew install --cask notchshelf",
        dmg: "downloads/notchshelf-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "08-audiomix",
        name: "AudioMix",
        cat: "audio",
        catName: "Audio & Screen",
        icon: "🎚️",
        hotkey: "Menu Bar",
        desc: "Per-app volume mixer & independent audio output routing without virtual cables.",
        features: ["Per-application sliders", "Zero latency CoreAudio", "Quick device routing"],
        brew: "brew install --cask audiomix",
        dmg: "downloads/audiomix-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "09-micmute-hud",
        name: "MicMute HUD",
        cat: "audio",
        catName: "Privacy & Audio",
        icon: "🔇",
        hotkey: "⌘ ⇧ M",
        desc: "Universal hardware mic mute & camera blackout indicator with on-screen dynamic pill.",
        features: ["Works across Zoom/Meet/Teams", "Audio feedback cues", "Always-on-top pill"],
        brew: "brew install --cask micmute-hud",
        dmg: "downloads/micmute-hud-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "10-promptdock",
        name: "PromptDock",
        cat: "ai",
        catName: "AI & Workflow",
        icon: "✨",
        hotkey: "⌥ P",
        desc: "Global floating prompt HUD and snippet palette with dynamic variable interpolation.",
        features: ["Instant clipboard injection", "Dynamic {{variables}}", "Categorized prompt library"],
        brew: "brew install --cask promptdock",
        dmg: "downloads/promptdock-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "11-snaptile",
        name: "SnapTile",
        cat: "window",
        catName: "Window Mgr",
        icon: "🪟",
        hotkey: "⌃ ⌥ Arrows",
        desc: "Hyper-lightweight, zero-latency keyboard & edge window tiling manager with grid layouts.",
        features: ["Zero battery drain", "Custom inner gaps", "Multi-monitor smart snapping"],
        brew: "brew install --cask snaptile",
        dmg: "downloads/snaptile-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "12-purgeapp",
        name: "PurgeApp",
        cat: "system",
        catName: "System Utility",
        icon: "🗑️",
        hotkey: "Drag & Drop",
        desc: "Deep uninstaller that tracks and cleans hidden caches, plists, launch agents, and containers.",
        features: ["Finds orphaned residue", "Reclaims GBs of disk space", "Safe trash rollback"],
        brew: "brew install --cask purgeapp",
        dmg: "downloads/purgeapp-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "13-chargeguard",
        name: "ChargeGuard",
        cat: "system",
        catName: "Battery & System",
        icon: "🔋",
        hotkey: "Menu Bar",
        desc: "Battery health optimizer, custom 80% charge limiter, and real-time wattage telemetry.",
        features: ["Extends battery lifespan", "Real-time cycle counter", "SMC hardware control"],
        brew: "brew install --cask chargeguard",
        dmg: "downloads/chargeguard-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "14-envvault",
        name: "EnvVault",
        cat: "dev",
        catName: "Developer",
        icon: "🔐",
        hotkey: "Menu Bar",
        desc: "Secure .env & API key workspace manager with quick paste, encryption, and zero-leak validation.",
        features: ["Dev/Staging/Prod profiles", "Masked secret viewer", "1-click .env clipboard copy"],
        brew: "brew install --cask envvault",
        dmg: "downloads/envvault-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "15-devtunnel-hud",
        name: "DevTunnel HUD",
        cat: "dev",
        catName: "Developer",
        icon: "🚇",
        hotkey: "Menu Bar",
        desc: "Menu bar manager & traffic inspector for Cloudflare Tunnels, Ngrok, and Localtunnel.",
        features: ["Live request inspector", "1-click public URL copy", "Webhook payload replay"],
        brew: "brew install --cask devtunnel-hud",
        dmg: "downloads/devtunnel-hud-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "16-gitpulse",
        name: "GitPulse",
        cat: "dev",
        catName: "Developer",
        icon: "🌿",
        hotkey: "Menu Bar",
        desc: "Multi-repo status bar tracker for 50+ git repos: uncommitted changes, sync, and PRs.",
        features: ["Scans local projects", "Dirty file notifications", "1-click pull/stash"],
        brew: "brew install --cask gitpulse",
        dmg: "downloads/gitpulse-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "17-regexforge",
        name: "RegexForge",
        cat: "dev",
        catName: "Developer",
        icon: "🔣",
        hotkey: "HUD",
        desc: "Native Swift live regex debugger & visual tester with instant multi-language code export.",
        features: ["Live match highlighting", "Swift/Python/JS generators", "Preset pattern library"],
        brew: "brew install --cask regexforge",
        dmg: "downloads/regexforge-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "18-svgoptim",
        name: "SVGOptim",
        cat: "media",
        catName: "Creative & Dev",
        icon: "📐",
        hotkey: "Drag & Drop",
        desc: "Zero-bloat SVG optimizer, cleaner, and SVG-to-SwiftUI / React component converter.",
        features: ["60%+ SVG size reduction", "SwiftUI Shape generation", "Clean JSX component output"],
        brew: "brew install --cask svgoptim",
        dmg: "downloads/svgoptim-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "19-fontinspect",
        name: "FontInspect",
        cat: "media",
        catName: "Design",
        icon: "🔤",
        hotkey: "Menu Bar",
        desc: "Local font viewer, glyph explorer, variable font axis tester, and typography comparer.",
        features: ["Variable font sliders", "Glyph unicode inspector", "Side-by-side pairing preview"],
        brew: "brew install --cask fontinspect",
        dmg: "downloads/fontinspect-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "20-presentercam",
        name: "PresenterCam",
        cat: "audio",
        catName: "Screen & Video",
        icon: "📷",
        hotkey: "⌘ ⇧ P",
        desc: "Floating camera overlay with background blur, zoom, pointer spotlight, and drawing canvas.",
        features: ["Loom/Demo ready", "Neural blur & circular mask", "Cursor spotlight tracker"],
        brew: "brew install --cask presentercam",
        dmg: "downloads/presentercam-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "21-cleandesk-pro",
        name: "CleanDesk Pro",
        cat: "window",
        catName: "Presentation",
        icon: "✨",
        hotkey: "1-Click",
        desc: "1-click presentation mode: hides desktop icons, silences notifications, sets clean background.",
        features: ["Instant screen privacy", "DND auto-activation", "Restores setup in 1 click"],
        brew: "brew install --cask cleandesk-pro",
        dmg: "downloads/cleandesk-pro-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "22-screenruler",
        name: "ScreenRuler",
        cat: "media",
        catName: "Design & Dev",
        icon: "📏",
        hotkey: "Crosshair",
        desc: "Precision on-screen pixel measurement ruler, alignment crosshair, and padding inspector.",
        features: ["Sub-pixel measurement", "Guides and snap lines", "Instant hex color on hover"],
        brew: "brew install --cask screenruler",
        dmg: "downloads/screenruler-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "23-apphop",
        name: "AppHop",
        cat: "window",
        catName: "Window Mgr",
        icon: "⚡️",
        hotkey: "⌥ `",
        desc: "Quick-switch popup that lets you jump between open windows of ONLY the active app.",
        features: ["Number key switching", "Zero lag window focus", "Works across spaces"],
        brew: "brew install --cask apphop",
        dmg: "downloads/apphop-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "24-scratchpad-hud",
        name: "ScratchPad HUD",
        cat: "window",
        catName: "Productivity",
        icon: "📝",
        hotkey: "⌥ N",
        desc: "Always-on-top markdown scratchpad with instant cloud/local file export and quick-hide shortcut.",
        features: ["Markdown preview", "Persistent auto-save", "Global popup anywhere"],
        brew: "brew install --cask scratchpad-hud",
        dmg: "downloads/scratchpad-hud-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "25-timebridge",
        name: "TimeBridge",
        cat: "window",
        catName: "Productivity",
        icon: "🕒",
        hotkey: "Menu Bar",
        desc: "Visual timezone slider and meeting overlap calculator in the menu bar with world clocks.",
        features: ["Interactive time scrub bar", "Team availability overlap", "Copy scheduled slot"],
        brew: "brew install --cask timebridge",
        dmg: "downloads/timebridge-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "26-menucleaner",
        name: "MenuCleaner",
        cat: "system",
        catName: "System Utility",
        icon: "🍱",
        hotkey: "Menu Bar",
        desc: "Lightweight menu bar icon manager that auto-hides overflow items behind a smooth divider.",
        features: ["Reclaims notch space", "Auto-hide timer", "Drag to organize"],
        brew: "brew install --cask menucleaner",
        dmg: "downloads/menucleaner-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "27-metascrub",
        name: "MetaScrub",
        cat: "system",
        catName: "Privacy",
        icon: "🛡️",
        hotkey: "Drag & Drop",
        desc: "Instant drag-and-drop EXIF, GPS location, and privacy metadata stripper for photos & PDFs.",
        features: ["Strips camera serials & GPS", "Lossless image rewrite", "Batch folder processing"],
        brew: "brew install --cask metascrub",
        dmg: "downloads/metascrub-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "28-bandwidthradar",
        name: "BandwidthRadar",
        cat: "system",
        catName: "System Utility",
        icon: "📡",
        hotkey: "Menu Bar",
        desc: "Real-time per-app network download/upload traffic monitor in the menu bar with rogue alerts.",
        features: ["Live KB/s & MB/s in status bar", "Per-process data usage", "Bandwidth hog alerts"],
        brew: "brew install --cask bandwidthradar",
        dmg: "downloads/bandwidthradar-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "29-bluetoothautohop",
        name: "BluetoothAutoHop",
        cat: "system",
        catName: "System Utility",
        icon: "🎧",
        hotkey: "Automated",
        desc: "Smart Bluetooth manager that auto-disconnects on sleep, auto-reconnects on wake, shows battery.",
        features: ["No more sleep battery drain", "Instant AirPods switch", "Menu bar battery levels"],
        brew: "brew install --cask bluetoothautohop",
        dmg: "downloads/bluetoothautohop-1.0.0.dmg",
        price: "$9"
    },
    {
        id: "30-privatellm-bar",
        name: "PrivateLLM Bar",
        cat: "ai",
        catName: "AI & Privacy",
        icon: "🧠",
        hotkey: "Menu Bar",
        desc: "Ultra-lightweight menu bar local model runner using MLX / llama.cpp for instant offline AI.",
        features: ["100% Offline & Private", "Zero cloud API fees", "Apple Silicon Metal accelerated"],
        brew: "brew install --cask privatellm-bar",
        dmg: "downloads/privatellm-bar-1.0.0.dmg",
        price: "$9"
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
                <p>Try searching for "Whisper", "Ports", "OCR", "Audio", or "Git"</p>
            </div>
        `;
        return;
    }

    appsGrid.innerHTML = filtered.map(app => `
        <div class="app-card" data-category="${app.cat}">
            <div>
                <div class="app-card-top">
                    <div class="app-icon" style="background: rgba(255, 255, 255, 0.05);">${app.icon}</div>
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
