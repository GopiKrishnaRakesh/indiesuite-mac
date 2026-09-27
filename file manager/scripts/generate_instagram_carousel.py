#!/usr/bin/env python3
"""
Generates a complete 6-slide Instagram carousel set for Pathway.
Format: 1080x1350 (4:5 portrait) — highest-converting format for Instagram feeds.
Matches the clean, minimal luxury design of Pathway & Perry.
"""

import os
import subprocess
import base64
from PIL import Image

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(SCRIPT_DIR)
ASSETS_DIR = os.path.join(PROJECT_DIR, "website", "assets")
INSTA_DIR = os.path.join(ASSETS_DIR, "instagram")
os.makedirs(INSTA_DIR, exist_ok=True)
TMP_DIR = "/tmp/pathway_insta_carousel"
os.makedirs(TMP_DIR, exist_ok=True)

CHROME_BIN = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Base64 App Icon
icon_path = os.path.join(ASSETS_DIR, "app-icon.png")
with open(icon_path, "rb") as f:
    ICON_B64 = "data:image/png;base64," + base64.b64encode(f.read()).decode("utf-8")

# Common SVG Icons
SVG_FOLDER = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#007aff"><path d="M20 18c0 1.1-.9 2-2 2H6c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2h4l2 2h6c1.1 0 2 .9 2 2v10z"/></svg>"""
SVG_SWIFT = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#f05138"><path d="M20.9 14.8c-.8 2-2.3 3.6-4.3 4.8 2.2-.6 4-1.9 5.3-3.6-1 2.3-2.9 4-5.3 4.9 3.5-.7 6.4-3.1 7.4-6.6-1.5 1.5-3.3 2.5-5.3 3 1.9-1.2 3.4-3 4.2-5.1-1.2 1.3-2.7 2.2-4.3 2.7 1.8-1.7 2.9-4 3.1-6.6-.7 1.2-1.6 2.3-2.7 3.2C18 7.3 16 4.3 12.9 2c1.7 2.8 2.1 5.9 1.2 8.7-1.1-1.3-2.5-2.2-4.1-2.7 2.2 2.6 2.8 6.1 1.7 9.1-1.9-2.1-3-4.9-3.2-7.8-.8 1.4-1.2 3-1.2 4.7 0 5.4 4.4 9.8 9.8 9.8 3.5 0 6.6-1.8 8.4-4.6-1.6.4-3.1.2-4.6-.6z"/></svg>"""
SVG_DOC = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#5ac8fa"><path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z"/></svg>"""
SVG_DMG = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#af52de"><path d="M2 20h20v-4H2v4zm2-3h2v2H4v-2zM2 4v4h20V4H2zm4 3H4V5h2v2zm-4 7h20v-4H2v4zm2-3h2v2H4v-2z"/></svg>"""
SVG_IMAGE = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#34c759"><path d="M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zM8.5 13.5l2.5 3.01L14.5 12l4.5 6H5l3.5-4.5z"/></svg>"""

def render_slide(html_content, filename):
    html_path = os.path.join(TMP_DIR, f"{filename}.html")
    png_path = os.path.join(TMP_DIR, f"{filename}.png")
    jpg_path = os.path.join(INSTA_DIR, f"{filename}.jpg")

    with open(html_path, "w", encoding="utf-8") as f:
        f.write(html_content)

    cmd = [
        CHROME_BIN,
        "--headless",
        "--disable-gpu",
        "--force-device-scale-factor=2",
        "--window-size=1080,1350",
        f"--screenshot={png_path}",
        f"file://{html_path}"
    ]
    subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    img = Image.open(png_path).convert("RGB")
    if img.width != 1080 or img.height != 1350:
        img = img.resize((1080, 1350), Image.Resampling.LANCZOS)
    img.save(jpg_path, "JPEG", quality=95, optimize=True)
    print(f"✓ Created {filename}.jpg (1080x1350) -> {jpg_path}")


# Base CSS for all slides
BASE_CSS = """
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1080px;
    height: 1350px;
    background: #ffffff;
    font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Inter", sans-serif;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 64px 54px;
    color: #121316;
    overflow: hidden;
    position: relative;
  }

  /* Ambient light backdrop */
  .glow-mesh {
    position: absolute;
    width: 650px;
    height: 650px;
    background: radial-gradient(circle, rgba(0, 113, 227, 0.05) 0%, rgba(247, 247, 248, 0) 70%);
    top: -120px;
    right: -100px;
    pointer-events: none;
  }

  /* Header */
  .slide-header {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    z-index: 10;
  }
  .slide-brand {
    display: flex;
    align-items: center;
    gap: 14px;
  }
  .slide-logo {
    width: 52px;
    height: 52px;
    border-radius: 13px;
    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
  }
  .slide-app-name {
    font-size: 22px;
    font-weight: 700;
    letter-spacing: -0.02em;
    color: #121316;
  }
  .slide-app-tag {
    font-size: 13px;
    color: #64748b;
  }
  .slide-page-badge {
    background: #f1f5f9;
    color: #334155;
    font-size: 13px;
    font-weight: 700;
    font-family: "SF Mono", Menlo, monospace;
    padding: 6px 14px;
    border-radius: 999px;
    border: 1px solid rgba(0, 0, 0, 0.06);
  }

  /* Headline block */
  .headline-block {
    margin-top: 10px;
    margin-bottom: 24px;
    z-index: 10;
  }
  .category-pill {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    background: #eef2ff;
    color: #4f46e5;
    font-size: 12px;
    font-weight: 600;
    padding: 4px 12px;
    border-radius: 999px;
    margin-bottom: 12px;
    text-transform: uppercase;
    letter-spacing: 0.04em;
  }
  .slide-title {
    font-size: 46px;
    font-weight: 700;
    line-height: 1.12;
    letter-spacing: -0.035em;
    color: #121316;
    margin-bottom: 12px;
  }
  .slide-title span {
    color: #0071e3;
  }
  .slide-desc {
    font-size: 18px;
    color: #52545d;
    line-height: 1.45;
  }

  /* Window Mockup */
  .mockup-window {
    width: 100%;
    background: #ffffff;
    border-radius: 16px;
    border: 1px solid rgba(0, 0, 0, 0.08);
    box-shadow: 0 24px 60px rgba(0, 0, 0, 0.08), 0 2px 6px rgba(0, 0, 0, 0.03);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    z-index: 10;
  }
  .mockup-bar {
    height: 42px;
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    padding: 0 16px;
    justify-content: space-between;
  }
  .traffic-dots { display: flex; gap: 7px; }
  .dot { width: 11px; height: 11px; border-radius: 50%; }
  .d-red { background: #ff5f56; }
  .d-yellow { background: #ffbd2e; }
  .d-green { background: #27c93f; }

  /* Bottom Swipe Bar */
  .slide-footer {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding-top: 18px;
    border-top: 1px solid #f1f5f9;
    z-index: 10;
  }
  .footer-sub {
    font-size: 13px;
    color: #64748b;
  }
  .swipe-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: #121316;
    color: #ffffff;
    font-size: 13px;
    font-weight: 600;
    padding: 10px 18px;
    border-radius: 999px;
  }
"""

# =============================================================
# SLIDE 1: THE COVER (The Hook)
# =============================================================
def generate_slide_1():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {BASE_CSS}
  .hero-preview {{
    height: 570px;
    position: relative;
    padding: 20px;
    background: radial-gradient(circle at 50% 30%, #ffffff 0%, #f4f5f8 100%);
    display: flex;
    align-items: center;
    justify-content: center;
  }}
  .preview-inner-win {{
    width: 100%;
    height: 100%;
    background: #ffffff;
    border-radius: 14px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 20px 50px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }}
  .ribbon-bar {{
    height: 40px;
    background: #fafbfc;
    border-bottom: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    padding: 0 14px;
    gap: 8px;
    font-size: 12px;
    font-weight: 500;
  }}
  .r-pill {{
    background: #f1f5f9;
    padding: 4px 8px;
    border-radius: 5px;
    color: #334155;
  }}
  .r-pill.active {{
    background: #e0f2fe;
    color: #0369a1;
    font-weight: 600;
  }}
  .table-row-item {{
    display: grid;
    grid-template-columns: 340px 170px 140px 1fr;
    padding: 10px 16px;
    font-size: 13px;
    align-items: center;
    border-bottom: 1px solid #f8fafc;
  }}
  .table-row-item.active {{ background: #eff6ff; }}
  .size-badge {{
    background: #ecfdf5;
    color: #059669;
    padding: 2px 8px;
    border-radius: 4px;
    font-weight: 600;
    font-size: 11px;
    display: inline-flex;
    align-items: center;
    gap: 4px;
  }}
  .floating-hero-pill {{
    position: absolute;
    bottom: 30px;
    background: rgba(18, 19, 22, 0.9);
    backdrop-filter: blur(10px);
    color: #ffffff;
    padding: 10px 20px;
    border-radius: 999px;
    font-size: 13px;
    font-weight: 600;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    display: flex;
    align-items: center;
    gap: 10px;
  }}
</style>
</head>
<body>
  <div class="glow-mesh"></div>

  <div class="slide-header">
    <div class="slide-brand">
      <img src="{ICON_B64}" alt="Pathway" class="slide-logo">
      <div>
        <div class="slide-app-name">Pathway</div>
        <div class="slide-app-tag">Windows-Style File Manager for macOS</div>
      </div>
    </div>
    <div class="slide-page-badge">01 / 06</div>
  </div>

  <div class="headline-block">
    <div class="category-pill">New Mac App · Open Source</div>
    <h1 class="slide-title">Windows muscle memory.<br><span>Native Mac power.</span></h1>
    <p class="slide-desc">
      Stop fighting Finder. Launch files on Enter, rename instantly with F2, and see real folder sizes calculated live in List view.
    </p>
  </div>

  <div class="mockup-window hero-preview">
    <div class="preview-inner-win">
      <div class="mockup-bar">
        <div class="traffic-dots">
          <div class="dot d-red"></div>
          <div class="dot d-yellow"></div>
          <div class="dot d-green"></div>
        </div>
        <div style="font-size: 12px; font-weight: 600; color: #475569;">Pathway — indiesuite-mac</div>
        <div style="font-size: 11px; color: #94a3b8;">Details View (⌘1)</div>
      </div>
      <div class="ribbon-bar">
        <div class="r-pill"><span>➕ New</span></div>
        <div class="r-pill"><span>✂️ Cut (⌘X)</span></div>
        <div class="r-pill"><span>📋 Copy (⌘C)</span></div>
        <div class="r-pill"><span>✏️ Rename (F2)</span></div>
        <div class="r-pill active"><span>↕️ Sort: Size ▾</span></div>
        <div class="r-pill active"><span>🗂 Group: Type ▾</span></div>
      </div>
      <div style="flex: 1; padding: 4px 0;">
        <div class="table-row-item active">
          <div style="display: flex; align-items: center; gap: 8px; font-weight: 600;">{SVG_FOLDER} DerivedData</div>
          <div>Today, 18:30</div>
          <div>Folder</div>
          <div><span class="size-badge">✓ 1.84 GB</span></div>
        </div>
        <div class="table-row-item">
          <div style="display: flex; align-items: center; gap: 8px;">{SVG_FOLDER} node_modules</div>
          <div>Today, 17:15</div>
          <div>Folder</div>
          <div><span class="size-badge">✓ 418.2 MB</span></div>
        </div>
        <div class="table-row-item">
          <div style="display: flex; align-items: center; gap: 8px;">{SVG_FOLDER} Sources</div>
          <div>Today, 18:48</div>
          <div>Folder</div>
          <div><span class="size-badge">✓ 148 KB</span></div>
        </div>
        <div class="table-row-item">
          <div style="display: flex; align-items: center; gap: 8px;">{SVG_SWIFT} FileBrowserModel.swift</div>
          <div>Today, 18:40</div>
          <div>Swift Source</div>
          <div>32.8 KB</div>
        </div>
        <div class="table-row-item">
          <div style="display: flex; align-items: center; gap: 8px;">{SVG_DMG} Pathway-1.0.0.dmg</div>
          <div>Today, 17:45</div>
          <div>Disk Image</div>
          <div style="color: #0071e3; font-weight: 600;">1.8 MB</div>
        </div>
      </div>
    </div>

    <div class="floating-hero-pill">
      <span>⚡️ Real-time off-thread folder weight calculation</span>
    </div>
  </div>

  <div class="slide-footer">
    <div class="footer-sub">Universal Binary · Apple Silicon & Intel</div>
    <div class="swipe-btn"><span>Swipe to explore</span><span>→</span></div>
  </div>
</body>
</html>"""
    render_slide(html, "slide-1-cover")


# =============================================================
# SLIDE 2: MUSCLE MEMORY (Enter opens, F2 renames, Cut & Paste)
# =============================================================
def generate_slide_2():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {BASE_CSS}
  .cards-stack {{
    display: flex;
    flex-direction: column;
    gap: 18px;
    z-index: 10;
  }}
  .muscle-card {{
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    padding: 24px;
    display: flex;
    align-items: center;
    gap: 24px;
  }}
  .keycap-box {{
    min-width: 110px;
    height: 70px;
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-bottom: 4px solid #94a3b8;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    font-weight: 700;
    color: #1e293b;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
  }}
  .card-info h4 {{
    font-size: 20px;
    font-weight: 700;
    color: #0f172a;
    margin-bottom: 6px;
  }}
  .card-info p {{
    font-size: 15px;
    color: #475569;
    line-height: 1.45;
  }}
</style>
</head>
<body>
  <div class="glow-mesh"></div>

  <div class="slide-header">
    <div class="slide-brand">
      <img src="{ICON_B64}" alt="Pathway" class="slide-logo">
      <div>
        <div class="slide-app-name">Pathway</div>
        <div class="slide-app-tag">Muscle Memory Restored</div>
      </div>
    </div>
    <div class="slide-page-badge">02 / 06</div>
  </div>

  <div class="headline-block">
    <div class="category-pill">Feature 01 · Natural Workflow</div>
    <h1 class="slide-title">Enter opens files.<br><span>F2 renames immediately.</span></h1>
    <p class="slide-desc">
      In Finder, pressing Enter triggers a slow rename instead of opening your document. Pathway fixes this once and for all.
    </p>
  </div>

  <div class="cards-stack">
    <div class="muscle-card">
      <div class="keycap-box">↵ ENTER</div>
      <div class="card-info">
        <h4>Opens the File or Folder</h4>
        <p>Tap Enter to launch any file in its default app, or dive into a directory. Never accidentally edit filenames again.</p>
      </div>
    </div>

    <div class="muscle-card">
      <div class="keycap-box">F2</div>
      <div class="card-info">
        <h4>Instant Inline Renaming</h4>
        <p>Press F2 to immediately select the base filename without extension. No waiting on double-click delay.</p>
      </div>
    </div>

    <div class="muscle-card">
      <div class="keycap-box">⌘X / Ctrl+X</div>
      <div class="card-info">
        <h4>True Cut & Paste with Undo</h4>
        <p>Cut files with ⌘X or Ctrl+X, navigate to any destination, and press ⌘V/Ctrl+V. Complete multi-level Undo & Redo (⌘Z).</p>
      </div>
    </div>
  </div>

  <div class="slide-footer">
    <div class="footer-sub">Zero unlearning required</div>
    <div class="swipe-btn"><span>Next: Folder Sizes</span><span>→</span></div>
  </div>
</body>
</html>"""
    render_slide(html, "slide-2-muscle-memory")


# =============================================================
# SLIDE 3: FOLDER SIZES & GROUPING
# =============================================================
def generate_slide_3():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {BASE_CSS}
  .size-table-card {{
    background: #ffffff;
    border-radius: 16px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 20px 50px rgba(0,0,0,0.08);
    overflow: hidden;
    z-index: 10;
  }}
  .group-row {{
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
    padding: 12px 20px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    color: #475569;
    letter-spacing: 0.05em;
    display: flex;
    justify-content: space-between;
  }}
  .s-row {{
    display: grid;
    grid-template-columns: 340px 170px 140px 1fr;
    padding: 16px 20px;
    font-size: 14px;
    align-items: center;
    border-bottom: 1px solid #f8fafc;
  }}
  .s-row.highlight {{
    background: #eff6ff;
  }}
  .calc-badge {{
    background: #ecfdf5;
    color: #059669;
    border: 1px solid #a7f3d0;
    padding: 4px 10px;
    border-radius: 6px;
    font-weight: 700;
    font-size: 13px;
    display: inline-flex;
    align-items: center;
    gap: 6px;
  }}
  .callout-box {{
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 16px 20px;
    display: flex;
    align-items: center;
    gap: 14px;
    margin-top: 18px;
    z-index: 10;
  }}
  .callout-box .icon {{
    width: 38px;
    height: 38px;
    border-radius: 8px;
    background: #ecfdf5;
    color: #059669;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    font-weight: 700;
  }}
</style>
</head>
<body>
  <div class="glow-mesh"></div>

  <div class="slide-header">
    <div class="slide-brand">
      <img src="{ICON_B64}" alt="Pathway" class="slide-logo">
      <div>
        <div class="slide-app-name">Pathway</div>
        <div class="slide-app-tag">Folder Weights & Sorting</div>
      </div>
    </div>
    <div class="slide-page-badge">03 / 06</div>
  </div>

  <div class="headline-block">
    <div class="category-pill" style="background:#ecfdf5; color:#059669;">Feature 02 · Deep Storage Intelligence</div>
    <h1 class="slide-title">Real folder sizes in List view.<br><span style="color:#059669">Off-thread Swift 6 actor.</span></h1>
    <p class="slide-desc">
      Finder leaves folder sizes completely blank. Pathway computes exact byte weights in the background so you always know what's taking up your storage.
    </p>
  </div>

  <div class="size-table-card">
    <div class="group-row">
      <span>📁 Folders (Group by: Type)</span>
      <span style="color:#0071e3;">Sort by: Size ▾ (Descending)</span>
    </div>

    <div class="s-row highlight">
      <div style="display: flex; align-items: center; gap: 10px; font-weight: 600;">{SVG_FOLDER} DerivedData</div>
      <div>Today, 18:30</div>
      <div>Folder</div>
      <div><span class="calc-badge">✓ 1.84 GB</span></div>
    </div>

    <div class="s-row">
      <div style="display: flex; align-items: center; gap: 10px; font-weight: 500;">{SVG_FOLDER} node_modules</div>
      <div>Today, 17:15</div>
      <div>Folder</div>
      <div><span class="calc-badge">✓ 418.2 MB</span></div>
    </div>

    <div class="s-row">
      <div style="display: flex; align-items: center; gap: 10px; font-weight: 500;">{SVG_FOLDER} .git</div>
      <div>Today, 09:30</div>
      <div>Folder</div>
      <div><span class="calc-badge">✓ 62.8 MB</span></div>
    </div>

    <div class="s-row">
      <div style="display: flex; align-items: center; gap: 10px; font-weight: 500;">{SVG_FOLDER} Sources</div>
      <div>Today, 18:48</div>
      <div>Folder</div>
      <div><span class="calc-badge">✓ 148 KB</span></div>
    </div>
  </div>

  <div class="callout-box">
    <div class="icon">⚡️</div>
    <div>
      <div style="font-weight: 700; font-size: 14px; color: #0f172a;">Zero UI Freezing</div>
      <div style="font-size: 13px; color: #64748b;">Calculated asynchronously with inode timestamp caching. Never rescans unchanged directories.</div>
    </div>
  </div>

  <div class="slide-footer">
    <div class="footer-sub">Sort folders by true size, not name</div>
    <div class="swipe-btn"><span>Next: Conversions</span><span>→</span></div>
  </div>
</body>
</html>"""
    render_slide(html, "slide-3-folder-sizes")


# =============================================================
# SLIDE 4: BATCH CONVERSIONS
# =============================================================
def generate_slide_4():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {BASE_CSS}
  .context-showcase-box {{
    background: #ffffff;
    border-radius: 16px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 20px 50px rgba(0,0,0,0.08);
    padding: 24px;
    display: flex;
    gap: 20px;
    z-index: 10;
  }}
  .menu-pane {{
    width: 280px;
    background: rgba(255, 255, 255, 0.95);
    border: 1px solid #cbd5e1;
    border-radius: 10px;
    padding: 6px;
    box-shadow: 0 14px 35px rgba(0,0,0,0.15);
    display: flex;
    flex-direction: column;
    gap: 2px;
    font-size: 13px;
  }}
  .m-item {{
    padding: 7px 10px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    color: #1e293b;
  }}
  .m-item.active {{
    background: #007aff;
    color: #ffffff;
  }}
  .sub-pane {{
    flex: 1;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 16px;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }}
  .feature-bullet {{
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 14px;
    color: #334155;
    background: #ffffff;
    padding: 10px 14px;
    border-radius: 8px;
    border: 1px solid #e2e8f0;
  }}
  .bullet-icon {{
    font-weight: 700;
    color: #0071e3;
  }}
</style>
</head>
<body>
  <div class="glow-mesh"></div>

  <div class="slide-header">
    <div class="slide-brand">
      <img src="{ICON_B64}" alt="Pathway" class="slide-logo">
      <div>
        <div class="slide-app-name">Pathway</div>
        <div class="slide-app-tag">Context Menu Utilities</div>
      </div>
    </div>
    <div class="slide-page-badge">04 / 06</div>
  </div>

  <div class="headline-block">
    <div class="category-pill" style="background:#f5f3ff; color:#7c3aed;">Feature 03 · 1-Click Utilities</div>
    <h1 class="slide-title">Batch conversions.<br><span style="color:#7c3aed">Right in your context menu.</span></h1>
    <p class="slide-desc">
      Stop uploading files to random websites or paying for third-party converter apps. Convert images, docs, and archives natively on device.
    </p>
  </div>

  <div class="context-showcase-box">
    <div class="menu-pane">
      <div class="m-item"><span>↗ Open</span><span style="font-size:11px; color:#64748b;">↵</span></div>
      <div class="m-item"><span>✂️ Cut</span><span style="font-size:11px; color:#64748b;">⌘X</span></div>
      <div class="m-item"><span>📋 Copy</span><span style="font-size:11px; color:#64748b;">⌘C</span></div>
      <div class="m-item"><span>✏️ Rename</span><span style="font-size:11px; color:#64748b;">F2</span></div>
      <div style="height:1px; background:#e2e8f0; margin:4px 0;"></div>
      <div class="m-item"><span>📦 Compress to ZIP</span></div>
      <div class="m-item active"><span>🖼 Convert Images (3 items)</span><span>▸</span></div>
      <div class="m-item"><span>📄 Convert Documents</span><span>▸</span></div>
      <div style="height:1px; background:#e2e8f0; margin:4px 0;"></div>
      <div class="m-item"><span>🔗 Copy Full Path</span><span style="font-size:11px; color:#64748b;">⌥⌘C</span></div>
    </div>

    <div class="sub-pane">
      <div style="font-size: 13px; font-weight: 700; color: #0f172a; margin-bottom: 4px;">Native Graphics Pipeline</div>
      <div class="feature-bullet"><span class="bullet-icon">✓</span><span>Convert to JPEG (Quality 90%)</span></div>
      <div class="feature-bullet"><span class="bullet-icon">✓</span><span>Convert to PNG (Lossless)</span></div>
      <div class="feature-bullet"><span class="bullet-icon">✓</span><span>Convert to HEIC (High Efficiency)</span></div>
      <div class="feature-bullet"><span class="bullet-icon">✓</span><span>Convert to WebP format</span></div>
      <div class="feature-bullet"><span class="bullet-icon">✓</span><span>Merge multiple into Single PDF</span></div>
      <div class="feature-bullet"><span class="bullet-icon">✓</span><span>Transcode Docs to PDF / Word (.docx)</span></div>
    </div>
  </div>

  <div class="slide-footer">
    <div class="footer-sub">CoreGraphics & ImageIO · Zero cloud uploads</div>
    <div class="swipe-btn"><span>Next: Shortcuts</span><span>→</span></div>
  </div>
</body>
</html>"""
    render_slide(html, "slide-4-conversions")


# =============================================================
# SLIDE 5: SHORTCUTS MATRIX
# =============================================================
def generate_slide_5():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {BASE_CSS}
  .shortcuts-grid {{
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 14px;
    z-index: 10;
  }}
  .sc-item {{
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 14px 18px;
    display: flex;
    align-items: center;
    gap: 14px;
  }}
  .sc-key {{
    min-width: 80px;
    height: 42px;
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-bottom: 3px solid #94a3b8;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    font-weight: 700;
    color: #0f172a;
    font-family: "SF Mono", Menlo, monospace;
    box-shadow: 0 2px 5px rgba(0,0,0,0.04);
  }}
  .sc-desc h5 {{
    font-size: 14px;
    font-weight: 600;
    color: #0f172a;
  }}
  .sc-desc p {{
    font-size: 12px;
    color: #64748b;
  }}
</style>
</head>
<body>
  <div class="glow-mesh"></div>

  <div class="slide-header">
    <div class="slide-brand">
      <img src="{ICON_B64}" alt="Pathway" class="slide-logo">
      <div>
        <div class="slide-app-name">Pathway</div>
        <div class="slide-app-tag">Keyboard Ergonomics</div>
      </div>
    </div>
    <div class="slide-page-badge">05 / 06</div>
  </div>

  <div class="headline-block">
    <div class="category-pill" style="background:#e0f2fe; color:#0369a1;">Feature 04 · Complete Ergonomics</div>
    <h1 class="slide-title">Every shortcut you know.<br><span style="color:#0284c7">Ready from day one.</span></h1>
    <p class="slide-desc">
      Feel right at home. All your muscle memory keys work out of the box, with full macOS modifier support alongside.
    </p>
  </div>

  <div class="shortcuts-grid">
    <div class="sc-item">
      <div class="sc-key">↵ Enter</div>
      <div class="sc-desc">
        <h5>Open File / Folder</h5>
        <p>Launches immediately</p>
      </div>
    </div>

    <div class="sc-item">
      <div class="sc-key">F2</div>
      <div class="sc-desc">
        <h5>Inline Rename</h5>
        <p>Selects basename only</p>
      </div>
    </div>

    <div class="sc-item">
      <div class="sc-key">⌫ Back</div>
      <div class="sc-desc">
        <h5>Navigate Back / Up</h5>
        <p>Return to parent folder</p>
      </div>
    </div>

    <div class="sc-item">
      <div class="sc-key">Delete</div>
      <div class="sc-desc">
        <h5>Move to Trash</h5>
        <p>⇧Delete for permanent</p>
      </div>
    </div>

    <div class="sc-item">
      <div class="sc-key">Ctrl+X</div>
      <div class="sc-desc">
        <h5>Cut Items</h5>
        <p>⌘X also works</p>
      </div>
    </div>

    <div class="sc-item">
      <div class="sc-key">Ctrl+V</div>
      <div class="sc-desc">
        <h5>Paste Items</h5>
        <p>⌘V also works</p>
      </div>
    </div>

    <div class="sc-item">
      <div class="sc-key">F5</div>
      <div class="sc-desc">
        <h5>Refresh Folder</h5>
        <p>Reloads directory items</p>
      </div>
    </div>

    <div class="sc-item">
      <div class="sc-key">Space</div>
      <div class="sc-desc">
        <h5>Quick Look Preview</h5>
        <p>Instant file preview</p>
      </div>
    </div>
  </div>

  <div class="slide-footer">
    <div class="footer-sub">Press ⌘/ in app for full cheat sheet</div>
    <div class="swipe-btn"><span>Next: Download</span><span>→</span></div>
  </div>
</body>
</html>"""
    render_slide(html, "slide-5-shortcuts")


# =============================================================
# SLIDE 6: DOWNLOAD CTA (Final Slide)
# =============================================================
def generate_slide_6():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {BASE_CSS}
  .download-center-card {{
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 20px;
    padding: 40px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    gap: 24px;
    z-index: 10;
  }}
  .big-icon {{
    width: 88px;
    height: 88px;
    border-radius: 22px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
  }}
  .cta-big-btn {{
    width: 100%;
    height: 72px;
    background: #121316;
    color: #ffffff;
    border-radius: 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 14px;
    font-size: 22px;
    font-weight: 700;
    letter-spacing: -0.02em;
    box-shadow: 0 14px 35px rgba(0, 0, 0, 0.2);
    text-decoration: none;
  }}
  .bio-tag {{
    font-size: 14px;
    background: #0071e3;
    padding: 4px 12px;
    border-radius: 999px;
  }}
  .terminal-box {{
    width: 100%;
    background: #1c1c1e;
    color: #ffffff;
    border-radius: 12px;
    padding: 16px 20px;
    font-family: "SF Mono", Menlo, monospace;
    font-size: 13px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }}
  .t-curl {{
    color: #38bdf8;
  }}
  .specs-row {{
    display: flex;
    align-items: center;
    gap: 14px;
    font-size: 13px;
    color: #64748b;
  }}
  .spec-dot {{ width: 4px; height: 4px; border-radius: 50%; background: #cbd5e1; }}
</style>
</head>
<body>
  <div class="glow-mesh"></div>

  <div class="slide-header">
    <div class="slide-brand">
      <img src="{ICON_B64}" alt="Pathway" class="slide-logo">
      <div>
        <div class="slide-app-name">Pathway</div>
        <div class="slide-app-tag">Get the App</div>
      </div>
    </div>
    <div class="slide-page-badge">06 / 06</div>
  </div>

  <div class="headline-block" style="text-align: center;">
    <div class="category-pill">100% Free · Universal Binary</div>
    <h1 class="slide-title">Stop fighting Finder.<br><span style="color:#121316;">Start enjoying your Mac.</span></h1>
    <p class="slide-desc" style="max-width: 600px; margin: 0 auto;">
      A single 1.8 MB universal DMG. No installer, no background telemetry, no sandbox restrictions.
    </p>
  </div>

  <div class="download-center-card">
    <img src="{ICON_B64}" alt="Pathway" class="big-icon">
    
    <div class="cta-big-btn">
      <span>⬇</span>
      <span>Download Pathway (Free)</span>
      <span class="bio-tag">Link in Bio 🔗</span>
    </div>

    <div class="terminal-box">
      <span class="t-curl">$ curl -fsSL https://.../install.sh | bash</span>
      <span style="color: #94a3b8; font-size: 11px;">1-Line Install</span>
    </div>

    <div class="specs-row">
      <span>macOS 14+ Sonoma & 15+ Sequoia</span>
      <span class="spec-dot"></span>
      <span>M1–M4 & Intel</span>
      <span class="spec-dot"></span>
      <span>1.8 MB</span>
      <span class="spec-dot"></span>
      <span>Open Source</span>
    </div>
  </div>

  <div class="slide-footer">
    <div class="footer-sub">github.com/GopiKrishnaRakesh/indiesuite-mac</div>
    <div style="font-size: 13px; font-weight: 600; color: #0071e3;">Tap Link in Bio to Download ↗</div>
  </div>
</body>
</html>"""
    render_slide(html, "slide-6-download")


if __name__ == "__main__":
    print("Generating complete 6-slide Instagram carousel in 1080x1350...")
    generate_slide_1()
    generate_slide_2()
    generate_slide_3()
    generate_slide_4()
    generate_slide_5()
    generate_slide_6()
    print("\n✓ All 6 Instagram carousel slides created in website/assets/instagram/!")
