#!/usr/bin/env python3
import json
import os
import re

first_30_apps = [
    {
        "id": "01-whispertap", "name": "WhisperTap", "cat": "ai", "catName": "AI & Voice",
        "hotkey": "⌥ Space", "desc": "Global push-to-talk AI dictation into any text field via Apple Silicon MLX WhisperKit.",
        "features": ["100% Offline & Private", "Auto-paste into focused app", "Code & Dev mode cleanup"]
    },
    {
        "id": "02-tokenwatch", "name": "TokenWatch", "cat": "ai", "catName": "AI & Dev",
        "hotkey": "Menu Bar", "desc": "Menu bar real-time LLM API spend & rate-limit monitor for OpenAI, Anthropic, Gemini & Groq.",
        "features": ["Live status bar cost ticker", "Budget limit alerts", "Per-project token tracking"]
    },
    {
        "id": "03-locallens-ocr", "name": "LocalLens OCR", "cat": "ai", "catName": "AI & Vision",
        "hotkey": "⌘ ⇧ 2", "desc": "Instant screen-to-code, JSON, LaTeX, and table extractor with regex formatting.",
        "features": ["Vision Neural Engine OCR", "Code syntax formatting", "Zero line-wrap distortion"]
    },
    {
        "id": "04-portsentry", "name": "PortSentry", "cat": "dev", "catName": "Developer",
        "hotkey": "Menu Bar", "desc": "Active port & zombie process killer. Shows listening ports, process PIDs, and 1-click kill.",
        "features": ["Instant port release", "PID & memory inspector", "1-click browser preview"]
    },
    {
        "id": "05-shrinkmedia", "name": "ShrinkMedia", "cat": "media", "catName": "Creative & Design",
        "hotkey": "Drag & Drop", "desc": "Fast drag-and-drop batch video/audio/image compressor using hardware VideoToolbox.",
        "features": ["Up to 88% size reduction", "Lossless GIF & MP4 export", "Apple Silicon HW encoder"]
    },
    {
        "id": "06-colorforge", "name": "ColorForge", "cat": "media", "catName": "Creative & Design",
        "hotkey": "⌘ ⇧ C", "desc": "Native eyedropper, palette builder, and WCAG 2.2 AAA contrast compliance checker.",
        "features": ["1-click SwiftUI/CSS/Hex export", "Global screen magnifier", "Palette history sync"]
    },
    {
        "id": "07-notchshelf", "name": "NotchShelf", "cat": "system", "catName": "Utilities & System",
        "hotkey": "Top Bezel", "desc": "Smart drop-zone & staging area hidden inside the MacBook notch for files, links & screenshots.",
        "features": ["Zero desktop clutter", "Smooth hover reveal", "Drag-to-Slack/Terminal"]
    },
    {
        "id": "08-audiomix", "name": "AudioMix", "cat": "system", "catName": "Utilities & System",
        "hotkey": "Menu Bar", "desc": "Per-app volume mixer & independent audio output routing without virtual cables.",
        "features": ["Per-application sliders", "Zero latency CoreAudio", "Quick device routing"]
    },
    {
        "id": "09-micmute-hud", "name": "MicMute HUD", "cat": "system", "catName": "Utilities & System",
        "hotkey": "⌘ ⇧ M", "desc": "Universal hardware mic mute & camera blackout indicator with on-screen dynamic pill.",
        "features": ["Works across Zoom/Meet/Teams", "Audio feedback cues", "Always-on-top pill"]
    },
    {
        "id": "10-promptdock", "name": "PromptDock", "cat": "ai", "catName": "AI & Voice",
        "hotkey": "⌥ P", "desc": "Global floating prompt HUD and snippet palette with dynamic variable interpolation.",
        "features": ["Instant clipboard injection", "Dynamic {{variables}}", "Categorized prompt library"]
    },
    {
        "id": "11-snaptile", "name": "SnapTile", "cat": "focus", "catName": "Focus & Flow",
        "hotkey": "⌃ ⌥ Arrows", "desc": "Hyper-lightweight, zero-latency keyboard & edge window tiling manager with grid layouts.",
        "features": ["Zero battery drain", "Custom inner gaps", "Multi-monitor smart snapping"]
    },
    {
        "id": "12-purgeapp", "name": "PurgeApp", "cat": "system", "catName": "Utilities & System",
        "hotkey": "Drag & Drop", "desc": "Deep uninstaller that tracks and cleans hidden caches, plists, launch agents, and containers.",
        "features": ["Finds orphaned residue", "Reclaims GBs of disk space", "Safe trash rollback"]
    },
    {
        "id": "13-chargeguard", "name": "ChargeGuard", "cat": "routine", "catName": "Routine & Wellness",
        "hotkey": "Menu Bar", "desc": "Battery health optimizer, custom 80% charge limiter, and real-time wattage telemetry.",
        "features": ["Extends battery lifespan", "Real-time cycle counter", "SMC hardware control"]
    },
    {
        "id": "14-envvault", "name": "EnvVault", "cat": "dev", "catName": "Developer",
        "hotkey": "Menu Bar", "desc": "Secure .env & API key workspace manager with quick paste, encryption, and zero-leak validation.",
        "features": ["Dev/Staging/Prod profiles", "Masked secret viewer", "1-click .env clipboard copy"]
    },
    {
        "id": "15-devtunnel-hud", "name": "DevTunnel HUD", "cat": "dev", "catName": "Developer",
        "hotkey": "Menu Bar", "desc": "Menu bar manager & traffic inspector for Cloudflare Tunnels, Ngrok, and Localtunnel.",
        "features": ["Live request inspector", "1-click public URL copy", "Webhook payload replay"]
    },
    {
        "id": "16-gitpulse", "name": "GitPulse", "cat": "dev", "catName": "Developer",
        "hotkey": "Menu Bar", "desc": "Multi-repo status bar tracker for 50+ git repos: uncommitted changes, sync, and PRs.",
        "features": ["Scans local projects", "Dirty file notifications", "1-click pull/stash"]
    },
    {
        "id": "17-regexforge", "name": "RegexForge", "cat": "dev", "catName": "Developer",
        "hotkey": "HUD", "desc": "Native Swift live regex debugger & visual tester with instant multi-language code export.",
        "features": ["Live match highlighting", "Swift/Python/JS generators", "Preset pattern library"]
    },
    {
        "id": "18-svgoptim", "name": "SVGOptim", "cat": "media", "catName": "Creative & Design",
        "hotkey": "Drag & Drop", "desc": "Zero-bloat SVG optimizer, cleaner, and SVG-to-SwiftUI / React component converter.",
        "features": ["60%+ SVG size reduction", "SwiftUI Shape generation", "Clean JSX component output"]
    },
    {
        "id": "19-fontinspect", "name": "FontInspect", "cat": "media", "catName": "Creative & Design",
        "hotkey": "Menu Bar", "desc": "Local font viewer, glyph explorer, variable font axis tester, and typography comparer.",
        "features": ["Variable font sliders", "Glyph unicode inspector", "Side-by-side pairing preview"]
    },
    {
        "id": "20-presentercam", "name": "PresenterCam", "cat": "social", "catName": "Social & Creator",
        "hotkey": "⌘ ⇧ P", "desc": "Floating camera overlay with background blur, zoom, pointer spotlight, and drawing canvas.",
        "features": ["Loom/Demo ready", "Neural blur & circular mask", "Cursor spotlight tracker"]
    },
    {
        "id": "21-cleandesk-pro", "name": "CleanDesk Pro", "cat": "focus", "catName": "Focus & Flow",
        "hotkey": "1-Click", "desc": "1-click presentation mode: hides desktop icons, silences notifications, sets clean background.",
        "features": ["Instant screen privacy", "DND auto-activation", "Restores setup in 1 click"]
    },
    {
        "id": "22-screenruler", "name": "ScreenRuler", "cat": "media", "catName": "Creative & Design",
        "hotkey": "Crosshair", "desc": "Precision on-screen pixel measurement ruler, alignment crosshair, and padding inspector.",
        "features": ["Sub-pixel measurement", "Guides and snap lines", "Instant hex color on hover"]
    },
    {
        "id": "23-apphop", "name": "AppHop", "cat": "focus", "catName": "Focus & Flow",
        "hotkey": "⌥ `", "desc": "Quick-switch popup that lets you jump between open windows of ONLY the active app.",
        "features": ["Number key switching", "Zero lag window focus", "Works across spaces"]
    },
    {
        "id": "24-scratchpad-hud", "name": "ScratchPad HUD", "cat": "focus", "catName": "Focus & Flow",
        "hotkey": "⌥ N", "desc": "Always-on-top markdown scratchpad with instant cloud/local file export and quick-hide shortcut.",
        "features": ["Markdown preview", "Persistent auto-save", "Global popup anywhere"]
    },
    {
        "id": "25-timebridge", "name": "TimeBridge", "cat": "routine", "catName": "Routine & Wellness",
        "hotkey": "Menu Bar", "desc": "Visual timezone slider and meeting overlap calculator in the menu bar with world clocks.",
        "features": ["Interactive time scrub bar", "Team availability overlap", "Copy scheduled slot"]
    },
    {
        "id": "26-menucleaner", "name": "MenuCleaner", "cat": "system", "catName": "Utilities & System",
        "hotkey": "Menu Bar", "desc": "Lightweight menu bar icon manager that auto-hides overflow items behind a smooth divider.",
        "features": ["Reclaims notch space", "Auto-hide timer", "Drag to organize"]
    },
    {
        "id": "27-metascrub", "name": "MetaScrub", "cat": "system", "catName": "Utilities & System",
        "hotkey": "Drag & Drop", "desc": "Instant drag-and-drop EXIF, GPS location, and privacy metadata stripper for photos & PDFs.",
        "features": ["Strips camera serials & GPS", "Lossless image rewrite", "Batch folder processing"]
    },
    {
        "id": "28-bandwidthradar", "name": "BandwidthRadar", "cat": "system", "catName": "Utilities & System",
        "hotkey": "Menu Bar", "desc": "Real-time per-app network download/upload traffic monitor in the menu bar with rogue alerts.",
        "features": ["Live KB/s & MB/s in status bar", "Per-process data usage", "Bandwidth hog alerts"]
    },
    {
        "id": "29-bluetoothautohop", "name": "BluetoothAutoHop", "cat": "system", "catName": "Utilities & System",
        "hotkey": "Automated", "desc": "Smart Bluetooth manager that auto-disconnects on sleep, auto-reconnects on wake, shows battery.",
        "features": ["No more sleep battery drain", "Instant AirPods switch", "Menu bar battery levels"]
    },
    {
        "id": "30-privatellm-bar", "name": "PrivateLLM Bar", "cat": "ai", "catName": "AI & Voice",
        "hotkey": "Menu Bar", "desc": "Ultra-lightweight menu bar local model runner using MLX / llama.cpp for instant offline AI.",
        "features": ["100% Offline & Private", "Zero cloud API fees", "Apple Silicon Metal accelerated"]
    }
]

from scaffold_50_more_apps import new_50_apps as apps_31_to_80
from scaffold_apps_81_to_130 import apps_81_to_130

def determine_price(app_id, name, cat):
    # Tier 4: Heavy AI / CoreML / Whisper / Cluster DevOps ($14 - $19)
    if any(k in app_id for k in ["whisper", "tokenwatch", "privatellm", "locallens", "kube", "pdfwhisper", "voicetranscribe", "embeddings", "aiwallpaper"]):
        if "whispertap" in app_id or "privatellm" in app_id:
            return 19
        return 16
    # Tier 3: Developer / Hardware Audio / Media / Tunnels / Git / DB ($9 - $12)
    elif any(k in app_id for k in ["shrinkmedia", "audiomix", "devtunnel", "portsentry", "gitpulse", "envvault", "sqlitelens", "redis", "mockup", "presentercam", "shadowstudio", "taillogs", "archive", "audiorecord", "memorypurge"]):
        if "audiomix" in app_id or "presentercam" in app_id or "shrinkmedia" in app_id:
            return 12
        return 9
    # Tier 2: Interactive Pets / Focus / Habit Grids / UI tools ($6 - $8)
    elif any(k in app_id for k in ["pet", "hamster", "gochi", "duck", "bonsai", "fish", "dragon", "cat", "sloth", "panda", "otter", "snaptile", "colorforge", "habit", "water", "posture", "tweet", "dminbox", "streamer", "emoji"]):
        if "dragon" in app_id or "snaptile" in app_id or "dminbox" in app_id:
            return 8
        return 6
    # Tier 1: Micro Utilities, Screen Dimmer, Toggles, Timers, Counters ($3 - $4)
    else:
        if "caffeine" in app_id or "hidden" in app_id or "blink" in app_id or "aspect" in app_id:
            return 3
        return 4

all_formatted_apps = []

for app in first_30_apps:
    p = determine_price(app["id"], app["name"], app["cat"])
    slug = app["id"].split("-", 1)[1]
    all_formatted_apps.append({
        "id": app["id"],
        "slug": slug,
        "name": app["name"],
        "cat": app["cat"],
        "catName": app["catName"],
        "hotkey": app["hotkey"],
        "desc": app["desc"],
        "features": app["features"],
        "brew": f"brew install --cask {slug}",
        "price": f"${p}",
        "priceNum": p
    })

for app in apps_31_to_80 + apps_81_to_130:
    slug = app["dir"].split("-", 1)[1]
    p = determine_price(app["dir"], app["name"], app["category"])
    all_formatted_apps.append({
        "id": app["dir"],
        "slug": slug,
        "name": app["name"],
        "cat": app["category"],
        "catName": app["categoryName"],
        "hotkey": app["hotkey"],
        "desc": app["desc"],
        "features": ["100% Native Swift 6", "Offline & Zero Cloud Lag", "Commercial License for 3 Macs"],
        "brew": f"brew install --cask {slug}",
        "price": f"${p}",
        "priceNum": p
    })

js_content = f"""// MacUpgraded.com - Complete Catalog & Multi-App Cart Engine
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

function saveCart() {{
    localStorage.setItem("macupgraded_cart", JSON.stringify(cart));
    updateCartUI();
}}

function updateCartUI() {{
    const totalCount = cart.length;
    const totalPrice = cart.reduce((sum, item) => sum + item.price, 0);

    navCartCountElements.forEach(el => el.textContent = totalCount);
    
    if (floatingCartBtn) {{
        if (totalCount > 0) {{
            floatingCartBtn.style.display = "flex";
            floatingCartCount.textContent = totalCount;
            floatingCartTotal.textContent = "$" + totalPrice;
        }} else {{
            floatingCartBtn.style.display = "none";
        }}
    }}

    renderCartItems();
}}

function renderApps() {{
    const filtered = apps.filter(app => {{
        const matchesCategory = activeCategory === "all" || app.cat === activeCategory;
        const matchesSearch = searchTerm === "" || 
            app.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.desc.toLowerCase().includes(searchTerm.toLowerCase()) ||
            app.catName.toLowerCase().includes(searchTerm.toLowerCase());
        return matchesCategory && matchesSearch;
    }});

    if (filtered.length === 0) {{
        appsGrid.innerHTML = `
            <div style="grid-column: 1/-1; text-align: center; padding: 60px 20px; color: var(--text-muted);">
                <h3>No apps match "${{searchTerm}}"</h3>
                <p>Try searching for "Whisper", "Hamster", "Bonsai", "Duck", "Focus", "Water", "Git", "SQL", or "Docker"</p>
            </div>
        `;
        return;
    }}

    appsGrid.innerHTML = filtered.map(app => {{
        const inCart = cart.some(item => item.slug === app.slug);
        return `
            <div class="app-card" data-category="${{app.cat}}">
                <div>
                    <div class="app-card-top">
                        <img src="assets/icons/${{app.id}}.svg" alt="${{app.name}}" class="app-vector-icon" loading="lazy" onerror="this.src='assets/icons/01-whispertap.svg'"/>
                        <div class="app-meta">
                            <div class="app-title-row">
                                <h3 class="app-name">${{app.name}}</h3>
                                <span class="app-cat-badge">${{app.catName}}</span>
                            </div>
                            <div class="app-hotkey">${{app.hotkey}}</div>
                        </div>
                    </div>

                    <p class="app-desc">${{app.desc}}</p>

                    <ul class="app-features">
                        ${{app.features.map(f => `<li>${{f}}</li>`).join("")}}
                    </ul>
                </div>

                <div class="app-card-footer">
                    <div class="app-price-tag">
                        <span class="price-val">${{app.price}}</span>
                        <span class="price-type">one-time</span>
                    </div>
                    <div class="card-actions">
                        <button class="btn btn-cart btn-sm" onclick="toggleCartItem('${{app.slug}}')">
                            ${{inCart ? '✓ In Cart' : '+ Cart'}}
                        </button>
                        <button class="btn btn-primary btn-sm" onclick="openCheckoutModal('${{app.slug}}')">
                            Buy Now
                        </button>
                    </div>
                </div>
            </div>
        `;
    }}).join("");
}}

// Add / Remove from Cart
window.toggleCartItem = function(slug) {{
    const app = apps.find(a => a.slug === slug);
    if (!app) return;

    const idx = cart.findIndex(i => i.slug === slug);
    if (idx >= 0) {{
        cart.splice(idx, 1);
    }} else {{
        cart.push({{
            slug: app.slug,
            id: app.id,
            name: app.name,
            price: app.priceNum
        }});
    }}
    saveCart();
    renderApps();
}};

window.removeFromCart = function(slug) {{
    cart = cart.filter(i => i.slug !== slug);
    saveCart();
    renderApps();
}};

// Render Cart Drawer
function renderCartItems() {{
    if (!cartItemsContainer) return;

    if (cart.length === 0) {{
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
    }}

    const total = cart.reduce((sum, item) => sum + item.price, 0);

    cartItemsContainer.innerHTML = cart.map(item => `
        <div class="cart-item-row">
            <div class="cart-item-info">
                <img src="assets/icons/${{item.id || ('01-' + item.slug)}}.svg" class="cart-item-icon" onerror="this.src='assets/icons/01-whispertap.svg'"/>
                <div>
                    <div class="cart-item-name">${{item.name}}</div>
                    <div class="cart-item-price">$${{item.price}}</div>
                </div>
            </div>
            <button class="cart-item-remove" onclick="removeFromCart('${{item.slug}}')" title="Remove">&times;</button>
        </div>
    `).join("");

    cartItemsCountText.textContent = `${{cart.length}} app(s) in cart`;
    cartSubtotalVal.textContent = `$${{total}}`;
    cartTotalVal.textContent = `$${{total}}`;
}}

// Open & Close Cart Modal
window.openCartModal = function() {{
    updateCartUI();
    cartModal.classList.remove("hidden");
}};

window.closeCartModal = function() {{
    cartModal.classList.add("hidden");
}};

// Open Single App Checkout Modal
window.openCheckoutModal = function(appSlug) {{
    if (appSlug === "all-access") {{
        currentSelectedApp = {{
            slug: "all-access",
            name: "All-Access 130-App Lifetime Pass (Special Promo)",
            price: "$129",
            priceNum: 129,
            desc: "Instant lifetime access to ALL 130 native macOS applications + Universal Master License Key for up to 5 Macs (90% OFF regular $1,290+ value)."
        }};
    }} else {{
        currentSelectedApp = apps.find(a => a.slug === appSlug);
    }}

    if (!currentSelectedApp) return;

    modalAppName.textContent = currentSelectedApp.name;
    modalAppPrice.textContent = currentSelectedApp.price;
    modalAppDesc.textContent = currentSelectedApp.desc;
    
    checkoutStep1.classList.remove("hidden");
    checkoutStep2.classList.add("hidden");
    paymentModal.classList.remove("hidden");
}};

window.closePaymentModal = function() {{
    paymentModal.classList.add("hidden");
}};

// Checkout Multi-App Cart
window.checkoutCart = async function(paymentMethod) {{
    if (cart.length === 0) {{
        alert("Your cart is empty. Please add apps before checking out.");
        return;
    }}

    const email = cartCheckoutEmail.value.trim();
    if (!email || !email.includes("@")) {{
        alert("Please enter a valid email address for license key delivery.");
        cartCheckoutEmail.focus();
        return;
    }}

    const btn = paymentMethod === "Apple Pay" ? document.getElementById("cartPayAppleBtn") : document.getElementById("cartPayCardBtn");
    const origText = btn.innerHTML;
    btn.innerHTML = "Connecting to Secure Gateway...";
    btn.disabled = true;

    try {{
        const response = await fetch("api/create_stripe_checkout.php", {{
            method: "POST",
            headers: {{ "Content-Type": "application/json" }},
            body: JSON.stringify({{
                email: email,
                items: cart
            }})
        }});

        const result = await response.json();

        if (result.success && result.checkoutUrl) {{
            window.location.href = result.checkoutUrl;
        }} else if (result.requires_config) {{
            alert("⚠️ Payment Setup Required:\\n\\n" + result.error + "\\n\\nPaste your live Stripe API key into website/config.php on your Hostinger server.");
        }} else {{
            alert("Payment Gateway Error: " + (result.error || "Unable to initiate checkout session."));
        }}
    }} catch (e) {{
        alert("⚠️ Backend Gateway Notice:\\n\\nTo process real payments, your website must be uploaded to your Hostinger server (macupgraded.com) with PHP support.");
    }} finally {{
        btn.innerHTML = origText;
        btn.disabled = false;
    }}
}};

// Process Single App Payment
async function processPayment(paymentMethod) {{
    const email = checkoutEmail.value.trim();
    if (!email || !email.includes("@")) {{
        alert("Please enter a valid email address so we can deliver your license key.");
        checkoutEmail.focus();
        return;
    }}
    
    const activeBtn = paymentMethod === "Apple Pay" ? payAppleBtn : (paymentMethod === "PayPal" ? payPaypalBtn : payCardBtn);
    const origText = activeBtn.innerHTML;
    activeBtn.innerHTML = "Connecting to Secure Gateway...";
    activeBtn.disabled = true;

    try {{
        const response = await fetch("api/create_stripe_checkout.php", {{
            method: "POST",
            headers: {{ "Content-Type": "application/json" }},
            body: JSON.stringify({{
                email: email,
                app: currentSelectedApp.slug,
                tier: currentSelectedApp.slug === "all-access" ? "ALL_ACCESS" : "INDIVIDUAL",
                name: currentSelectedApp.name,
                price: currentSelectedApp.priceNum
            }})
        }});

        const result = await response.json();

        if (result.success && result.checkoutUrl) {{
            window.location.href = result.checkoutUrl;
        }} else if (result.requires_config) {{
            alert("⚠️ Payment Setup Required:\\n\\n" + result.error + "\\n\\nTo accept real payments into your bank account, simply paste your live Stripe API key into website/config.php on your Hostinger server.");
        }} else {{
            alert("Payment Gateway Error: " + (result.error || "Unable to initiate checkout session. Please try again."));
        }}
    }} catch (e) {{
        alert("⚠️ Backend Gateway Notice:\\n\\nTo process real payments, your website must be uploaded to your Hostinger server (macupgraded.com) with PHP support.");
    }} finally {{
        activeBtn.innerHTML = origText;
        activeBtn.disabled = false;
    }}
}}

payAppleBtn.addEventListener("click", () => processPayment("Apple Pay"));
payCardBtn.addEventListener("click", () => processPayment("Credit/Debit Card (Stripe)"));
payPaypalBtn.addEventListener("click", () => processPayment("PayPal"));

if (copyLicenseBtn) {{
    copyLicenseBtn.addEventListener("click", () => {{
        navigator.clipboard.writeText(licenseKeyDisplay.textContent).then(() => {{
            copyLicenseBtn.textContent = "✓ Copied!";
            setTimeout(() => {{ copyLicenseBtn.textContent = "Copy Key"; }}, 1500);
        }});
    }});
}}

// Category filter
categoryPills.forEach(pill => {{
    pill.addEventListener("click", () => {{
        categoryPills.forEach(p => p.classList.remove("active"));
        pill.classList.add("active");
        activeCategory = pill.getAttribute("data-category");
        renderApps();
    }});
}});

// Search filter with debounce
let debounceTimer;
searchInput.addEventListener("input", (e) => {{
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {{
        searchTerm = e.target.value.trim();
        renderApps();
    }}, 150);
}});

// Initialize
renderApps();
updateCartUI();
"""

with open("website/app.js", "w") as f:
    f.write(js_content)

print(f"✅ Generated website/app.js with Creamy White Liquid Glass UI & Multi-App Cart for all {len(all_formatted_apps)} apps!")
