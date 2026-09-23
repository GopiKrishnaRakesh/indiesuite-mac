// MacUpgraded.com - Complete Catalog & Multi-App Cart Engine
const apps = [
    {
        "id": "03-locallens-ocr",
        "slug": "locallens-ocr",
        "name": "LocalLens OCR",
        "cat": "AI & Vision",
        "catKey": "ai",
        "price": "$16",
        "priceNum": 16,
        "hotkey": "\u2318\u21e72",
        "icon": "assets/icons/03-locallens-ocr.svg",
        "desc": "Select any part of your screen and get real, on-device Vision-framework text extraction \u2014 no cloud, no API key.",
        "pitch": "LocalLens OCR calls the actual macOS screencapture tool to let you drag-select any region of your screen, then runs Apple's on-device Vision text-recognition engine on it \u2014 the same engine behind Live Text. The extracted text is real, not a canned example, and is auto-copied to your clipboard.",
        "use_cases": [
            "Grab a code snippet from a video call or PDF screenshot without retyping it.",
            "Pull a SQL query, URL, or error message off screen straight into your clipboard.",
            "Works completely offline \u2014 nothing you capture ever leaves your Mac."
        ],
        "how_it_works": "Press \u2318\u21e72 or click Capture, and the app shells out to /usr/sbin/screencapture -i for the native interactive region selector, then feeds the resulting image into Apple's Vision framework (VNRecognizeTextRequest, accurate mode with language correction). A small on-device heuristic labels the result (SQL, URL, Swift, JSON, etc.) before it's copied. Requires a one-time Screen Recording permission grant in System Settings, like any screenshot utility.",
        "features": [
            "Real interactive screen-region capture via macOS's own screencapture",
            "On-device Vision framework OCR \u2014 no network calls, no API costs",
            "Auto-copy to clipboard with a rolling history of past captures",
            "Lightweight content-type labeling (SQL / URL / Swift / JSON / plain text)",
            "Global \u2318\u21e72 hotkey in addition to the menu bar popover"
        ]
    },
    {
        "id": "06-colorforge",
        "slug": "colorforge",
        "name": "ColorForge",
        "cat": "Creative & Design",
        "catKey": "media",
        "price": "$6",
        "priceNum": 6,
        "hotkey": "\u2318\u21e7C",
        "icon": "assets/icons/06-colorforge.svg",
        "desc": "A real system-wide eyedropper (NSColorSampler) with live WCAG contrast scoring and instant code export.",
        "pitch": "ColorForge wraps AppKit's own NSColorSampler \u2014 the same magnifier Apple ships in Preview and Sketch \u2014 so you can pick the exact color of any pixel on your screen, in any app. Every pick recalculates a real WCAG 2.x contrast ratio against white, not a fixed number.",
        "use_cases": [
            "Sample a brand color from a competitor's website or a screenshot.",
            "Check whether a picked color passes WCAG AA/AAA contrast before shipping it.",
            "Copy the color instantly as hex, rgb(), SwiftUI, or Tailwind class syntax."
        ],
        "how_it_works": "Click the eyedropper (or press \u2318\u21e7C) to invoke NSColorSampler's native screen-sampling cursor. The picked NSColor is converted to sRGB, and a real relative-luminance WCAG contrast ratio is computed against white on every pick \u2014 the AA/AAA badge reflects the actual math, not a placeholder.",
        "features": [
            "Real NSColorSampler system eyedropper \u2014 pick any pixel, any app",
            "Live WCAG 2.x contrast ratio computed from relative luminance, not hardcoded",
            "One-click export as Hex, rgb(), SwiftUI Color(), or Tailwind bg-[...]",
            "Running palette history of your last 8 picks, click to recopy",
            "Global \u2318\u21e7C hotkey in addition to the menu bar popover"
        ]
    },
    {
        "id": "05-shrinkmedia",
        "slug": "shrinkmedia",
        "name": "ShrinkMedia",
        "cat": "Creative & Design",
        "catKey": "media",
        "price": "$12",
        "priceNum": 12,
        "hotkey": "Menu Bar",
        "icon": "assets/icons/05-shrinkmedia.svg",
        "desc": "Actually re-encodes your images and videos on disk via ImageIO/AVFoundation \u2014 real before/after byte sizes, real output files.",
        "pitch": "Pick real image or video files and ShrinkMedia re-encodes them for real: JPEG/HEIC go through ImageIO's lossy compressor at your chosen quality, video goes through AVFoundation's AVAssetExportSession. The savings percentage you see is measured from actual file sizes on disk, and clicking a finished row reveals the real output file in Finder.",
        "use_cases": [
            "Shrink screenshots and photos before attaching them to an email or ticket.",
            "Compress a screen recording down before uploading it anywhere.",
            "Batch a whole folder of assets and see exactly how many MB you reclaimed."
        ],
        "how_it_works": "Images are re-encoded through Core Graphics' CGImageDestination with a lossy compression quality tied to your slider. Videos are exported through the existing AVAssetExportSession-based compressor at a Medium/Low quality preset depending on the slider. Every queue row's before/after size comes from FileManager's real attributesOfItem, not a simulated number.",
        "features": [
            "Real ImageIO re-encoding for JPEG/PNG/HEIC \u2014 verified 80%+ size cuts on typical photos",
            "Real AVFoundation video re-encoding to MP4",
            "Actual before/after file sizes and % saved, read from disk",
            "Batch queue \u2014 pick many files, compress them all in one pass",
            "Click a finished row to reveal the real output file in Finder"
        ]
    },
    {
        "id": "04-portsentry",
        "slug": "portsentry",
        "name": "PortSentry",
        "cat": "Developer Tools",
        "catKey": "dev",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Menu Bar",
        "icon": "assets/icons/04-portsentry.svg",
        "desc": "A real lsof-backed listener list for every open TCP port on your Mac, with a working Kill button.",
        "pitch": "PortSentry shells out to the same lsof your terminal uses to list every real listening TCP port \u2014 process name, PID, and user \u2014 and refreshes automatically. The Kill button sends a genuine SIGTERM to the process, not a local list-splice.",
        "use_cases": [
            "Find and free up a port a stuck dev server left open (\"address already in use\").",
            "Spot an unexpected process listening on a port you don't recognize.",
            "Jump straight to http://localhost:PORT in your browser for anything running locally."
        ],
        "how_it_works": "Runs /usr/sbin/lsof -iTCP -sTCP:LISTEN -n -P as a subprocess, parses the real column output into port/process/PID/user, and auto-refreshes every few seconds. Kill sends a real POSIX SIGTERM via the kill() syscall to the exact PID shown \u2014 verified end-to-end against a live test listener during development.",
        "features": [
            "Real lsof-backed scan of every listening TCP port, auto-refreshing",
            "Genuine SIGTERM kill \u2014 confirmed to actually terminate the target process",
            "Search/filter by port number or process name",
            "One click to open http://localhost:PORT in your default browser",
            "Zero fake data \u2014 what you see is what lsof reports right now"
        ]
    },
    {
        "id": "12-purgeapp",
        "slug": "purgeapp",
        "name": "PurgeApp",
        "cat": "Utilities & System",
        "catKey": "system",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "icon": "assets/icons/12-purgeapp.svg",
        "desc": "Scans the real, standard macOS leftover locations for any app you pick, with sizes from an actual du scan and Trash-based removal.",
        "pitch": "Choose any .app from /Applications and PurgeApp reads its real bundle identifier, then checks the standard places macOS apps leave residue \u2014 Caches, Preferences, Saved State, Containers, HTTPStorages, WebKit data, and matching Launch Agents \u2014 reporting real disk usage from du for each one it actually finds.",
        "use_cases": [
            "Fully remove an app's caches and preferences after uninstalling it.",
            "See exactly how much disk space an app's data is really using.",
            "Reclaim space safely \u2014 everything goes to Trash, nothing is deleted outright."
        ],
        "how_it_works": "Reads the picked app's real CFBundleIdentifier via Bundle(url:), then checks nine standard per-user locations that key off that identifier or the app's name, running /usr/bin/du -sk on each one that actually exists to report real sizes. Only items you tick are moved with FileManager.trashItem \u2014 fully recoverable, never a permanent delete.",
        "features": [
            "Real per-bundle-ID scan across Caches, Preferences, Saved State, Containers, HTTPStorages, WebKit & Launch Agents",
            "Actual disk usage from du, not an estimate",
            "Safe removal via macOS Trash \u2014 always recoverable",
            "Verified against real installed apps during development",
            "No sandboxed guesswork \u2014 only reports paths that genuinely exist on disk"
        ]
    },
    {
        "id": "11-snaptile",
        "slug": "snaptile",
        "name": "SnapTile",
        "cat": "Focus & Flow",
        "catKey": "focus",
        "price": "$8",
        "priceNum": 8,
        "hotkey": "\u2303\u2325 Arrows",
        "icon": "assets/icons/11-snaptile.svg",
        "desc": "Real Accessibility-API window tiling \u2014 halves, quarters, and maximize \u2014 on the frontmost app's actual window.",
        "pitch": "SnapTile uses the same AXUIElement Accessibility APIs that Rectangle and Magnet are built on to move and resize the real focused window of whatever app is frontmost, snapping it to the exact half/quarter/centered geometry you pick \u2014 gap size and all.",
        "use_cases": [
            "Snap two windows side-by-side for real multitasking, keyboard-only.",
            "Quarter-tile four reference windows around your screen.",
            "Center a window at 70% size for focused reading."
        ],
        "how_it_works": "Reads the frontmost app's focused window via AXUIElementCopyAttributeValue(kAXFocusedWindowAttribute), computes the target rect from the current screen's visibleFrame (so it respects your menu bar and Dock), and writes it back with AXUIElementSetAttributeValue for both position and size. Requires a one-time Accessibility permission grant \u2014 the app detects and prompts for this itself.",
        "features": [
            "Real AXUIElement window positioning \u2014 the same technique Rectangle uses",
            "10 layouts: halves, quarters, maximize, and a centered 70%",
            "Adjustable inner gap between tiled windows, applied for real",
            "Global \u2303\u2325+Arrow / Return hotkeys alongside the popover grid",
            "Detects missing Accessibility permission and links straight to the fix"
        ]
    },
    {
        "id": "07-notchshelf",
        "slug": "notchshelf",
        "name": "NotchShelf",
        "cat": "Utilities & System",
        "catKey": "system",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325\u21e7N",
        "icon": "assets/icons/07-notchshelf.svg",
        "desc": "A real floating drop-zone shelf pinned near your notch \u2014 genuinely accepts files, links, and text dragged from Finder or a browser.",
        "pitch": "NotchShelf is a real always-on-top panel positioned at the top-center of your screen. It accepts real SwiftUI drag-and-drop of files, URLs, and text (not a decorative drop zone), holds them with real file icons and sizes, and lets you drag them back out to any app or reveal them in Finder.",
        "use_cases": [
            "Stage files while moving them between two Finder windows or apps.",
            "Drop a link or snippet of text mid-task without breaking flow.",
            "Quickly reveal a staged file in Finder, or drag it into an email."
        ],
        "how_it_works": "A native NSPanel (floating, all-Spaces) is positioned at the top-center of the main screen and toggled from the menu bar icon or a global \u2325\u21e7N hotkey. It implements real SwiftUI `.onDrop` handling for the fileURL, url, and plainText content types, reading actual file sizes and icons via FileManager and NSWorkspace.",
        "features": [
            "Real file/link/text drag-and-drop, not a static mock list",
            "Floating panel toggled by a global \u2325\u21e7N hotkey or the menu bar icon",
            "Shows the item's real icon and real file size",
            "Drag items back out to Finder or any other app",
            "Click a staged file to reveal it in Finder"
        ]
    },
    {
        "id": "14-envvault",
        "slug": "envvault",
        "name": "EnvVault",
        "cat": "Developer Tools",
        "catKey": "dev",
        "price": "$9",
        "priceNum": 9,
        "hotkey": "Menu Bar",
        "icon": "assets/icons/14-envvault.svg",
        "desc": "Secrets are stored for real in the macOS Keychain \u2014 verified round-trip write/read/delete, never written to a plaintext file.",
        "pitch": "Every key you add in EnvVault is written to the real macOS Keychain via the Security framework (SecItemAdd/SecItemCopyMatching), the same store Safari and 1Password use. Only the key NAME is kept outside the Keychain, as a non-sensitive index; the value never touches disk unencrypted.",
        "use_cases": [
            "Keep API keys and DB URLs out of your shell history and .env files.",
            "Copy a secret to your clipboard for one paste without leaving it visible.",
            "Export everything as a real .env blob when you actually need one."
        ],
        "how_it_works": "Add/read/delete all go straight through Security.framework's SecItemAdd, SecItemCopyMatching and SecItemDelete against a generic-password Keychain item scoped to this app. This exact read/write/delete path was verified end-to-end (write \u2192 read-back match \u2192 delete \u2192 confirmed gone) during development.",
        "features": [
            "Real macOS Keychain storage \u2014 not UserDefaults, not a local file",
            "Mask/unmask toggle for on-screen values",
            "Per-secret copy, and one-click \"Copy .env\" of everything at once",
            "Add and delete secrets directly from the popover",
            "Verified write/read/delete round-trip"
        ]
    },
    {
        "id": "10-promptdock",
        "slug": "promptdock",
        "name": "PromptDock",
        "cat": "Developer Tools",
        "catKey": "dev",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "\u2325P",
        "icon": "assets/icons/10-promptdock.svg",
        "desc": "A real saved-snippet palette that fills {{clipboard}} with your actual clipboard and can auto-paste into whatever app is frontmost.",
        "pitch": "PromptDock keeps your own reusable text templates (persisted for real via UserDefaults/JSON, editable, deletable) and, on Inject, merges {{clipboard}} with whatever is genuinely on your clipboard right now, copies the result, and \u2014 once you grant Accessibility access \u2014 simulates a real \u2318V into the app you were just using.",
        "use_cases": [
            "Wrap whatever you just copied in a reusable \"review this code\" or \"rewrite this email\" template.",
            "Keep a personal library of prompts, snippets, or boilerplate you reuse daily.",
            "Inject straight into your editor or chat window without breaking flow."
        ],
        "how_it_works": "Templates are Codable structs persisted to UserDefaults as JSON, editable and deletable from the popover. Inject reads NSPasteboard.general.string for the real current clipboard, substitutes it into {{clipboard}}, writes the merged text back to the clipboard, and \u2014 if Accessibility access has been granted \u2014 posts a genuine \u2318V CGEvent into the frontmost app.",
        "features": [
            "Real, persistent, user-editable snippet library (add/delete, not just 4 fixed demos)",
            "{{clipboard}} is filled from your actual current clipboard content",
            "Optional real auto-paste into the frontmost app via a simulated \u2318V",
            "Per-prompt use-count tracking",
            "Global \u2325P hotkey to pop the palette open from anywhere"
        ]
    },
    {
        "id": "17-regexforge",
        "slug": "regexforge",
        "name": "RegexForge",
        "cat": "Developer Tools",
        "catKey": "dev",
        "price": "$4",
        "priceNum": 4,
        "hotkey": "Menu Bar",
        "icon": "assets/icons/17-regexforge.svg",
        "desc": "A live NSRegularExpression tester \u2014 real match counts, real capture groups, real invalid-pattern errors, as you type.",
        "pitch": "RegexForge evaluates your pattern against your test string using Foundation's real NSRegularExpression on every keystroke \u2014 match count, full matches, and capture groups are all computed live, and a genuinely invalid pattern is caught and flagged rather than silently showing a stale number.",
        "use_cases": [
            "Build and debug a regex against real sample text before shipping it in code.",
            "Check capture groups extract exactly the fields you expect.",
            "Grab common patterns (email, URL, IPv4, hex color, phone) as a starting point."
        ],
        "how_it_works": "Every change to the pattern, test string, case-insensitive toggle, or multiline toggle re-runs a real NSRegularExpression match pass and rebuilds the match list, including numbered capture groups per match. An invalid pattern throws a real NSError which is caught and surfaced as an inline error state instead of a fake match count.",
        "features": [
            "Live NSRegularExpression evaluation on every keystroke, not a static demo",
            "Real capture-group extraction shown per match",
            "Case-insensitive and multiline (^$) mode toggles that actually change matching",
            "Six built-in presets: email, URL, IPv4, hex color, phone, digits",
            "Copy all matches to clipboard in one click"
        ]
    },
    {
        "id": "131-pathway",
        "slug": "pathway",
        "name": "Pathway",
        "cat": "Utilities & System",
        "catKey": "system",
        "standalone": true,
        "price": "$14",
        "priceNum": 14,
        "hotkey": "\u2318L",
        "icon": "assets/icons/131-pathway.png",
        "desc": "A Windows-style file manager for macOS \u2014 Explorer's workflow, Mac's look.",
        "pitch": "Pathway brings the fast, keyboard-driven Explorer workflow you know from Windows to native macOS \u2014 dual breadcrumb navigation, instant search, real thumbnail previews, and zero sandbox friction.",
        "use_cases": [
            "Navigate any folder on disk with Explorer-style shortcuts \u2014 Backspace to go back, F2 to rename, Delete for Trash.",
            "Preview images, PDFs and movies with real thumbnails and a Quick Look pane (\u2325\u2318P) without leaving the list.",
            "Manage drives, network volumes and the Trash from one sidebar with live free-space bars."
        ],
        "how_it_works": "Built natively in SwiftUI with no sandbox and no bundled dependencies. Pathway reimplements the Windows Explorer interaction model \u2014 breadcrumb address bar, type-to-search, column-sortable Details view \u2014 on top of native macOS file APIs, so it feels instant and looks right at home on the Mac.",
        "features": [
            "Sidebar with Quick Access, This Mac volumes, Trash, Recent and a lazy-loading folder tree",
            "Explorer keyboard shortcuts: Backspace back, F2 rename, Delete to Trash, F5 refresh, F3 search",
            "Details / Icons / Tiles views with real thumbnails for images, PDFs and movies",
            "Quick Look preview pane, multi-level Undo, drag-and-drop with Finder",
            "Universal binary (Apple Silicon + Intel), Developer ID signed and notarized"
        ]
    },
    {
        "id": "132-murmur",
        "slug": "murmur",
        "name": "Murmur",
        "cat": "AI & Voice",
        "catKey": "ai",
        "standalone": true,
        "price": "$24",
        "priceNum": 24,
        "hotkey": "⌃⌥D",
        "icon": "assets/icons/murmur.png",
        "desc": "A 100% on-device AI voice agent — press ⌃⌥D anywhere and it types clean, filler-stripped text into whatever app is focused.",
        "pitch": "Murmur runs OpenAI's Whisper (via WhisperKit) directly on the Apple Neural Engine — the Base English model ships inside the app (~147MB) so dictation works instantly, offline, with zero API calls. A real-time filter strips \"um\", \"uh\", stutters and repeated words before the text is inserted.",
        "use_cases": [
            "Dictate messages, docs, or code comments straight into Slack, VS Code, Notion, or Mail.",
            "Think out loud at 150+ WPM and get clean, punctuated text instead of a transcript full of filler words.",
            "Record a meeting's mic + system audio together and get an on-device summary afterward."
        ],
        "how_it_works": "A global Carbon hotkey (⌃⌥D) opens a floating liquid-glass HUD that streams microphone audio into a bundled Core ML Whisper model running on the Neural Engine. A regex/heuristic FillerFilter cleans hesitation sounds and stutters from the transcript, then TextInserter writes the result into the focused app via the Accessibility API. Built, Developer-ID signed with Hardened Runtime, and verified to launch and stay stable during development.",
        "features": [
            "100% on-device Whisper transcription via WhisperKit — no cloud, no API key, works offline",
            "Real-time filler-word and stutter removal before text is inserted",
            "Global ⌃⌥D hotkey types directly into whatever app is focused",
            "Two-way meeting recording (mic + system audio) with on-device summaries",
            "Developer ID signed with Hardened Runtime — source on its own GitHub repo"
        ]
    }
];

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

function appIconSrc(app) {
    return app.icon || `assets/icons/${app.id}.svg`;
}

function buildAppCard(app) {
    const inCart = cart.some(item => item.slug === app.slug);
    return `
        <div class="app-card" data-cat="${app.catKey}" onclick="openAppDetail('${app.slug}')">
            <div>
                <div class="app-mockup">
                    <div class="app-mockup-chrome">
                        <span class="dot red"></span><span class="dot yellow"></span><span class="dot green"></span>
                    </div>
                    <div class="app-mockup-body">
                        <img src="${appIconSrc(app)}" alt="${app.name}" class="app-mockup-icon" loading="lazy" onerror="this.src='assets/icons/01-whispertap.svg'"/>
                        <span class="app-mockup-hotkey">${app.hotkey}</span>
                    </div>
                </div>

                <div class="app-card-top">
                    <div class="app-meta">
                        <div class="app-title-row">
                            <h3 class="app-name">${app.name}</h3>
                            <span class="app-cat-badge">${app.cat}</span>
                        </div>
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
                    <button class="btn btn-cart btn-sm" onclick="event.stopPropagation(); toggleCartItem('${app.slug}')">
                        ${inCart ? '✓ In Cart' : '+ Cart'}
                    </button>
                    <button class="btn btn-primary btn-sm" onclick="event.stopPropagation(); openCheckoutModal('${app.slug}')">
                        Buy Now
                    </button>
                </div>
            </div>
        </div>
    `;
}

function renderApps() {
    const bundleApps = apps.filter(app => !app.standalone);

    const filtered = bundleApps.filter(app => {
        const matchesCategory = activeCategory === "all" || app.catKey === activeCategory;
        const matchesSearch = searchTerm === "" ||
            app.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.desc.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.pitch.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.cat.toLowerCase().includes(searchTerm.toLowerCase());
        return matchesCategory && matchesSearch;
    });

    document.querySelectorAll(".pill").forEach(p => {
        p.classList.toggle("active", p.getAttribute("data-category") === activeCategory);
    });

    if (filtered.length === 0) {
        appsGrid.innerHTML = `
            <div style="grid-column: 1/-1; text-align: center; padding: 60px 20px; color: var(--text-muted);">
                <h3>No apps match "${searchTerm}"</h3>
                <p>Try searching for "OCR", "Color", "Shrink", "Port", "Purge", "Snap", "Notch", "Env", "Prompt", or "Regex"</p>
            </div>
        `;
        return;
    }

    appsGrid.innerHTML = filtered.map(buildAppCard).join("");
}

function renderStandaloneApps() {
    const standaloneGrid = document.getElementById("standaloneGrid");
    if (!standaloneGrid) return;
    const standaloneApps = apps.filter(app => app.standalone);
    standaloneGrid.innerHTML = standaloneApps.map(buildAppCard).join("");
}

// App Detail Modal — full feature breakdown for a single app
const appDetailModal = document.getElementById("appDetailModal");

window.openAppDetail = function(slug) {
    const app = apps.find(a => a.slug === slug);
    if (!app || !appDetailModal) return;

    const inCart = cart.some(item => item.slug === app.slug);

    appDetailModal.querySelector(".detail-mockup-shell").outerHTML = `
        <div class="detail-mockup-shell app-mockup app-mockup-lg" data-cat="${app.catKey}">
            <div class="app-mockup-chrome">
                <span class="dot red"></span><span class="dot yellow"></span><span class="dot green"></span>
                <span class="app-mockup-title">${app.name}.app</span>
            </div>
            <div class="app-mockup-body">
                <img src="${appIconSrc(app)}" alt="${app.name}" class="app-mockup-icon-lg" loading="lazy" onerror="this.src='assets/icons/01-whispertap.svg'"/>
                <span class="app-mockup-hotkey">${app.hotkey}</span>
            </div>
        </div>
    `;

    document.getElementById("detailCatBadge").textContent = app.cat;
    document.getElementById("detailAppName").textContent = app.name;
    document.getElementById("detailPrice").textContent = app.price;
    document.getElementById("detailDesc").textContent = app.pitch || app.desc;
    document.getElementById("detailHowItWorks").textContent = app.how_it_works || "";
    document.getElementById("detailFeaturesList").innerHTML = app.features.map(f => `<li>${f}</li>`).join("");
    document.getElementById("detailUseCasesList").innerHTML = (app.use_cases || []).map(u => `<li>${u}</li>`).join("");

    const cartBtn = document.getElementById("detailCartBtn");
    cartBtn.textContent = inCart ? "✓ In Cart" : "+ Add to Cart";
    cartBtn.onclick = () => { window.toggleCartItem(app.slug); window.openAppDetail(app.slug); };

    document.getElementById("detailBuyBtn").onclick = () => {
        closeAppDetail();
        window.openCheckoutModal(app.slug);
    };

    appDetailModal.classList.remove("hidden");
};

window.closeAppDetail = function() {
    appDetailModal.classList.add("hidden");
};

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
            name: "All-Access 10-App Bundle",
            price: "$49",
            priceNum: 49,
            desc: "Instant lifetime access to all 10 real, tested native macOS applications + Universal Master License Key for up to 5 Macs. (Pathway and Murmur are sold separately.)"
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
renderStandaloneApps();
updateCartUI();
