#!/usr/bin/env python3
"""
Generates 5 high-impact, professional developer marketing renders for Instagram.
Format: 1080x1350 (4:5 portrait) — highest engaging Instagram feed format.
Zero AI artifacts: 100% pixel-perfect macOS typography, window chrome, and hardware mockups.
"""

import os
import subprocess
import base64
from PIL import Image

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(SCRIPT_DIR)
ASSETS_DIR = os.path.join(PROJECT_DIR, "website", "assets")
FEATURES_DIR = os.path.join(ASSETS_DIR, "instagram", "features")
os.makedirs(FEATURES_DIR, exist_ok=True)
TMP_DIR = "/tmp/pathway_feature_renders"
os.makedirs(TMP_DIR, exist_ok=True)

CHROME_BIN = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Base64 App Icon
icon_path = os.path.join(ASSETS_DIR, "app-icon.png")
with open(icon_path, "rb") as f:
    ICON_B64 = "data:image/png;base64," + base64.b64encode(f.read()).decode("utf-8")

# Common SVG Icons
SVG_FOLDER = """<svg width="20" height="20" viewBox="0 0 24 24" fill="#007aff"><path d="M20 18c0 1.1-.9 2-2 2H6c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2h4l2 2h6c1.1 0 2 .9 2 2v10z"/></svg>"""
SVG_SWIFT = """<svg width="20" height="20" viewBox="0 0 24 24" fill="#f05138"><path d="M20.9 14.8c-.8 2-2.3 3.6-4.3 4.8 2.2-.6 4-1.9 5.3-3.6-1 2.3-2.9 4-5.3 4.9 3.5-.7 6.4-3.1 7.4-6.6-1.5 1.5-3.3 2.5-5.3 3 1.9-1.2 3.4-3 4.2-5.1-1.2 1.3-2.7 2.2-4.3 2.7 1.8-1.7 2.9-4 3.1-6.6-.7 1.2-1.6 2.3-2.7 3.2C18 7.3 16 4.3 12.9 2c1.7 2.8 2.1 5.9 1.2 8.7-1.1-1.3-2.5-2.2-4.1-2.7 2.2 2.6 2.8 6.1 1.7 9.1-1.9-2.1-3-4.9-3.2-7.8-.8 1.4-1.2 3-1.2 4.7 0 5.4 4.4 9.8 9.8 9.8 3.5 0 6.6-1.8 8.4-4.6-1.6.4-3.1.2-4.6-.6z"/></svg>"""
SVG_DOC = """<svg width="20" height="20" viewBox="0 0 24 24" fill="#5ac8fa"><path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z"/></svg>"""
SVG_DMG = """<svg width="20" height="20" viewBox="0 0 24 24" fill="#af52de"><path d="M2 20h20v-4H2v4zm2-3h2v2H4v-2zM2 4v4h20V4H2zm4 3H4V5h2v2zm-4 7h20v-4H2v4zm2-3h2v2H4v-2z"/></svg>"""
SVG_IMAGE = """<svg width="20" height="20" viewBox="0 0 24 24" fill="#34c759"><path d="M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zM8.5 13.5l2.5 3.01L14.5 12l4.5 6H5l3.5-4.5z"/></svg>"""

def render_feature(html_content, filename):
    html_path = os.path.join(TMP_DIR, f"{filename}.html")
    png_path = os.path.join(TMP_DIR, f"{filename}.png")
    jpg_path = os.path.join(FEATURES_DIR, f"{filename}.jpg")

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
    print(f"✓ Rendered {filename}.jpg (1080x1350) -> {jpg_path}")


# Base CSS Template
SHARED_CSS = """
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1080px;
    height: 1350px;
    background: #ffffff;
    font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Inter", sans-serif;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 60px 52px;
    color: #121316;
    overflow: hidden;
    position: relative;
  }

  /* Header */
  .top-brand {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    z-index: 20;
  }
  .brand-left {
    display: flex;
    align-items: center;
    gap: 14px;
  }
  .brand-icon {
    width: 50px;
    height: 50px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  }
  .brand-name {
    font-size: 22px;
    font-weight: 700;
    letter-spacing: -0.02em;
    color: #121316;
  }
  .brand-sub {
    font-size: 13px;
    color: #64748b;
  }
  .feature-tag-badge {
    background: #f1f5f9;
    color: #0f172a;
    font-size: 12px;
    font-weight: 700;
    padding: 6px 14px;
    border-radius: 999px;
    border: 1px solid rgba(0,0,0,0.06);
    letter-spacing: 0.03em;
    text-transform: uppercase;
  }

  /* Headline */
  .hero-headline-wrap {
    margin-top: 14px;
    margin-bottom: 22px;
    z-index: 20;
  }
  .pill-eyebrow {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    padding: 4px 12px;
    border-radius: 999px;
    margin-bottom: 10px;
  }
  .title-main {
    font-size: 46px;
    font-weight: 700;
    line-height: 1.12;
    letter-spacing: -0.035em;
    margin-bottom: 10px;
  }
  .desc-sub {
    font-size: 17px;
    color: #52545d;
    line-height: 1.45;
    max-width: 800px;
  }

  /* Traffic lights */
  .traffic-group { display: flex; gap: 7px; }
  .t-dot { width: 11px; height: 11px; border-radius: 50%; }
  .t-red { background: #ff5f56; }
  .t-yellow { background: #ffbd2e; }
  .t-green { background: #27c93f; }

  /* Bottom CTA */
  .footer-cta-block {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
    z-index: 20;
  }
  .btn-download-bar {
    width: 100%;
    height: 64px;
    background: #121316;
    border-radius: 16px;
    color: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    font-size: 18px;
    font-weight: 600;
    box-shadow: 0 10px 25px rgba(0,0,0,0.14);
    text-decoration: none;
  }
  .bio-pill {
    background: #0071e3;
    color: #ffffff;
    font-size: 13px;
    padding: 3px 10px;
    border-radius: 999px;
  }
  .footer-caption-line {
    font-size: 12px;
    color: #64748b;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .caption-dot { width: 4px; height: 4px; border-radius: 50%; background: #cbd5e1; }
"""

# =============================================================
# 1. FEATURE RENDER: WORKSPACE & COMMAND BAR
# =============================================================
def generate_render_1():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_CSS}
  .stage-frame {{
    flex: 1;
    max-height: 660px;
    background: radial-gradient(circle at 50% 20%, #ffffff 0%, #f4f5f8 100%);
    border-radius: 18px;
    border: 1px solid rgba(0,0,0,0.08);
    box-shadow: 0 24px 60px rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    position: relative;
    z-index: 10;
  }}
  .window-topbar {{
    height: 44px;
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    padding: 0 16px;
    justify-content: space-between;
  }}
  .breadcrumb-capsule {{
    height: 38px;
    background: #ffffff;
    border-bottom: 1px solid #f1f5f9;
    display: flex;
    align-items: center;
    padding: 0 16px;
    gap: 8px;
    font-size: 12px;
    color: #64748b;
  }}
  .b-pill {{
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 3px 8px;
    color: #1e293b;
    font-weight: 500;
  }}
  .ribbon-tools {{
    height: 42px;
    background: #fafbfc;
    border-bottom: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    padding: 0 14px;
    gap: 8px;
    font-size: 12px;
  }}
  .r-btn {{
    padding: 4px 8px;
    border-radius: 6px;
    background: #f1f5f9;
    color: #334155;
    display: flex;
    align-items: center;
    gap: 5px;
    font-weight: 500;
  }}
  .r-btn.active {{
    background: #e0f2fe;
    color: #0284c7;
    font-weight: 600;
  }}
  .split-body {{
    flex: 1;
    display: flex;
    background: #ffffff;
  }}
  .sidebar-pane {{
    width: 210px;
    background: #f8fafc;
    border-right: 1px solid #e2e8f0;
    padding: 14px 10px;
    display: flex;
    flex-direction: column;
    gap: 14px;
    font-size: 12px;
  }}
  .sb-head {{
    font-size: 10px;
    font-weight: 700;
    text-transform: uppercase;
    color: #94a3b8;
    letter-spacing: 0.05em;
    padding-left: 6px;
  }}
  .sb-row {{
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 6px 8px;
    border-radius: 6px;
    color: #475569;
    font-weight: 500;
  }}
  .sb-row.active {{
    background: #e0e7ff;
    color: #4338ca;
    font-weight: 600;
  }}
  .files-pane {{
    flex: 1;
    display: flex;
    flex-direction: column;
  }}
  .row-file {{
    display: grid;
    grid-template-columns: 280px 140px 110px 1fr;
    padding: 10px 14px;
    font-size: 13px;
    align-items: center;
    border-bottom: 1px solid #f8fafc;
  }}
  .row-file.sel {{ background: #eff6ff; }}
  .size-tag-green {{
    background: #ecfdf5;
    color: #059669;
    padding: 2px 7px;
    border-radius: 4px;
    font-weight: 600;
    font-size: 11px;
    display: inline-flex;
    align-items: center;
    gap: 4px;
  }}
  .floating-pin {{
    position: absolute;
    background: rgba(18, 19, 22, 0.94);
    backdrop-filter: blur(10px);
    color: #ffffff;
    padding: 8px 14px;
    border-radius: 999px;
    font-size: 12px;
    font-weight: 600;
    box-shadow: 0 8px 20px rgba(0,0,0,0.18);
    display: flex;
    align-items: center;
    gap: 8px;
    z-index: 30;
  }}
  .pin-1 {{ top: 120px; right: 24px; }}
  .pin-2 {{ bottom: 30px; left: 24px; }}
</style>
</head>
<body>
  <div class="top-brand">
    <div class="brand-left">
      <img src="{ICON_B64}" alt="Pathway" class="brand-icon">
      <div>
        <div class="brand-name">Pathway</div>
        <div class="brand-sub">Windows Ergonomics on macOS</div>
      </div>
    </div>
    <div class="feature-tag-badge">FEATURE 01</div>
  </div>

  <div class="hero-headline-wrap">
    <div class="pill-eyebrow" style="background:#eef2ff; color:#4f46e5;">Explorer Ribbon & Breadcrumbs</div>
    <h1 class="title-main">The file manager your<br><span style="color:#0071e3;">Mac was always missing.</span></h1>
    <p class="desc-sub">Full address bar navigation, ribbon command bar with New, Cut, Copy, Rename, and instant keyboard shortcuts.</p>
  </div>

  <div class="stage-frame">
    <!-- Window Bar -->
    <div class="window-topbar">
      <div class="traffic-group">
        <div class="t-dot t-red"></div>
        <div class="t-dot t-yellow"></div>
        <div class="t-dot t-green"></div>
      </div>
      <div style="font-size: 12px; font-weight: 600; color: #475569;">Pathway — indiesuite-mac</div>
      <div style="font-size: 11px; color: #94a3b8;">Details View (⌘1)</div>
    </div>

    <!-- Breadcrumb Bar -->
    <div class="breadcrumb-capsule">
      <span>◀ ▶ ⟳</span>
      <span class="b-pill">This PC</span>
      <span>›</span>
      <span class="b-pill">Macintosh HD</span>
      <span>›</span>
      <span class="b-pill">Users</span>
      <span>›</span>
      <span class="b-pill">developer</span>
      <span>›</span>
      <span class="b-pill" style="color:#0071e3; font-weight:700;">Pathway</span>
    </div>

    <!-- Command Ribbon -->
    <div class="ribbon-tools">
      <div class="r-btn"><span>➕ New</span></div>
      <div class="r-btn"><span>✂️ Cut (⌘X)</span></div>
      <div class="r-btn"><span>📋 Copy</span></div>
      <div class="r-btn"><span>✏️ Rename (F2)</span></div>
      <div class="r-btn active"><span>↕️ Sort: Size ▾</span></div>
      <div class="r-btn active"><span>🗂 Group: Type ▾</span></div>
    </div>

    <!-- Body -->
    <div class="split-body">
      <div class="sidebar-pane">
        <div class="sb-head">Quick Access</div>
        <div class="sb-row"><span>💻 Desktop</span></div>
        <div class="sb-row"><span>📄 Documents</span></div>
        <div class="sb-row"><span>📥 Downloads</span></div>
        <div class="sb-row active"><span>📂 Projects</span></div>
        <div class="sb-head" style="margin-top: 10px;">Drives</div>
        <div class="sb-row"><span>💾 Macintosh HD</span></div>
        <div class="sb-row"><span>🔌 External SSD</span></div>
      </div>

      <div class="files-pane">
        <div class="row-file sel">
          <div style="display:flex; align-items:center; gap:8px; font-weight:600;">{SVG_FOLDER} DerivedData</div>
          <div>Today, 18:30</div>
          <div>Folder</div>
          <div><span class="size-tag-green">✓ 1.84 GB</span></div>
        </div>
        <div class="row-file">
          <div style="display:flex; align-items:center; gap:8px;">{SVG_FOLDER} node_modules</div>
          <div>Today, 17:15</div>
          <div>Folder</div>
          <div><span class="size-tag-green">✓ 418.2 MB</span></div>
        </div>
        <div class="row-file">
          <div style="display:flex; align-items:center; gap:8px;">{SVG_FOLDER} Sources</div>
          <div>Today, 18:48</div>
          <div>Folder</div>
          <div><span class="size-tag-green">✓ 148 KB</span></div>
        </div>
        <div class="row-file">
          <div style="display:flex; align-items:center; gap:8px;">{SVG_SWIFT} FileBrowserModel.swift</div>
          <div>Today, 18:40</div>
          <div>Swift</div>
          <div>32.8 KB</div>
        </div>
        <div class="row-file">
          <div style="display:flex; align-items:center; gap:8px;">{SVG_DMG} Pathway-1.0.0.dmg</div>
          <div>Today, 17:45</div>
          <div>DMG</div>
          <div style="color:#0071e3; font-weight:600;">1.8 MB</div>
        </div>
      </div>
    </div>

    <!-- Floating Callout Pins -->
    <div class="floating-pin pin-1">
      <span>⚡️ Real-time off-thread folder sizes</span>
    </div>
    <div class="floating-pin pin-2">
      <span>↵ Enter opens files · F2 renames</span>
    </div>
  </div>

  <div class="footer-cta-block">
    <div class="btn-download-bar">
      <span>⬇</span>
      <span>Download Pathway (Free)</span>
      <span class="bio-pill">Link in Bio 🔗</span>
    </div>
    <div class="footer-caption-line">
      <span>github.com/GopiKrishnaRakesh/indiesuite-mac</span>
      <span class="caption-dot"></span>
      <span>Universal Binary · Apple Silicon & Intel</span>
    </div>
  </div>
</body>
</html>"""
    render_feature(html, "feature-1-overview-macbook")


# =============================================================
# 2. FEATURE RENDER: REAL FOLDER WEIGHTS
# =============================================================
def generate_render_2():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_CSS}
  .card-container {{
    flex: 1;
    max-height: 660px;
    background: #ffffff;
    border-radius: 18px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 24px 60px rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    z-index: 10;
  }}
  .card-header-bar {{
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
    padding: 14px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }}
  .filter-pill {{
    background: #eff6ff;
    color: #2563eb;
    border: 1px solid #bfdbfe;
    padding: 6px 12px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 6px;
  }}
  .table-grid {{
    flex: 1;
    display: flex;
    flex-direction: column;
  }}
  .tbl-head {{
    display: grid;
    grid-template-columns: 380px 170px 140px 1fr;
    padding: 12px 20px;
    font-size: 12px;
    font-weight: 700;
    color: #64748b;
    background: #fafbfc;
    border-bottom: 1px solid #e2e8f0;
  }}
  .tbl-row {{
    display: grid;
    grid-template-columns: 380px 170px 140px 1fr;
    padding: 16px 20px;
    font-size: 14px;
    align-items: center;
    border-bottom: 1px solid #f8fafc;
  }}
  .tbl-row.active {{ background: #eff6ff; }}
  .size-calc-chip {{
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
  .tech-spec-bar {{
    background: #f8fafc;
    border-top: 1px solid #e2e8f0;
    padding: 16px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }}
  .spec-icon-box {{
    width: 36px;
    height: 36px;
    border-radius: 8px;
    background: #ecfdf5;
    color: #059669;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
  }}
</style>
</head>
<body>
  <div class="top-brand">
    <div class="brand-left">
      <img src="{ICON_B64}" alt="Pathway" class="brand-icon">
      <div>
        <div class="brand-name">Pathway</div>
        <div class="brand-sub">Storage Intelligence Engine</div>
      </div>
    </div>
    <div class="feature-tag-badge">FEATURE 02</div>
  </div>

  <div class="hero-headline-wrap">
    <div class="pill-eyebrow" style="background:#ecfdf5; color:#059669;">Zero Blank Folder Sizes</div>
    <h1 class="title-main">Real folder weights.<br><span style="color:#059669;">Off-thread Swift 6 actor.</span></h1>
    <p class="desc-sub">Finder leaves folder sizes blank. Pathway calculates recursive folder weights in the background without dropping UI frames.</p>
  </div>

  <div class="card-container">
    <div class="card-header-bar">
      <div class="filter-pill">
        <span>↕️ Sort by: <strong>Size (Descending ▾)</strong></span>
      </div>
      <div class="filter-pill" style="background:#f1f5f9; color:#475569; border-color:#e2e8f0;">
        <span>🗂 Group by: <strong>Type</strong></span>
      </div>
      <div style="font-size: 12px; color: #64748b; font-weight: 600;">
        Pathway Background Calculator
      </div>
    </div>

    <div class="table-grid">
      <div class="tbl-head">
        <div>Name</div>
        <div>Date modified</div>
        <div>Type</div>
        <div style="color:#2563eb;">Size ▾</div>
      </div>

      <div class="tbl-row active">
        <div style="display:flex; align-items:center; gap:10px; font-weight:600;">{SVG_FOLDER} DerivedData</div>
        <div>Today, 18:30</div>
        <div>Folder</div>
        <div><span class="size-calc-chip">✓ 1.84 GB</span></div>
      </div>

      <div class="tbl-row">
        <div style="display:flex; align-items:center; gap:10px; font-weight:500;">{SVG_FOLDER} node_modules</div>
        <div>Today, 17:15</div>
        <div>Folder</div>
        <div><span class="size-calc-chip">✓ 418.2 MB</span></div>
      </div>

      <div class="tbl-row">
        <div style="display:flex; align-items:center; gap:10px; font-weight:500;">{SVG_FOLDER} .git</div>
        <div>Today, 09:30</div>
        <div>Folder</div>
        <div><span class="size-calc-chip">✓ 62.8 MB</span></div>
      </div>

      <div class="tbl-row">
        <div style="display:flex; align-items:center; gap:10px; font-weight:500;">{SVG_FOLDER} build</div>
        <div>Today, 16:45</div>
        <div>Folder</div>
        <div><span class="size-calc-chip">✓ 312.0 MB</span></div>
      </div>

      <div class="tbl-row">
        <div style="display:flex; align-items:center; gap:10px; font-weight:500;">{SVG_FOLDER} Sources</div>
        <div>Today, 18:48</div>
        <div>Folder</div>
        <div><span class="size-calc-chip">✓ 148 KB</span></div>
      </div>
    </div>

    <div class="tech-spec-bar">
      <div style="display:flex; align-items:center; gap:12px;">
        <div class="spec-icon-box">⚡️</div>
        <div>
          <div style="font-weight:700; font-size:13px; color:#0f172a;">Inode Timestamp Caching</div>
          <div style="font-size:12px; color:#64748b;">Instant cache hits on repeated visits. Never re-indexes unchanged folders.</div>
        </div>
      </div>
      <div style="font-size:12px; font-weight:600; color:#059669;">100% Async Swift Actor</div>
    </div>
  </div>

  <div class="footer-cta-block">
    <div class="btn-download-bar">
      <span>⬇</span>
      <span>Download Pathway (Free)</span>
      <span class="bio-pill">Link in Bio 🔗</span>
    </div>
    <div class="footer-caption-line">
      <span>Sort folders by real size on Mac</span>
      <span class="caption-dot"></span>
      <span>github.com/GopiKrishnaRakesh/indiesuite-mac</span>
    </div>
  </div>
</body>
</html>"""
    render_feature(html, "feature-2-folder-sizes")


# =============================================================
# 3. FEATURE RENDER: CONTEXT MENU BATCH CONVERSIONS
# =============================================================
def generate_render_3():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_CSS}
  .stage-box {{
    flex: 1;
    max-height: 660px;
    background: #ffffff;
    border-radius: 18px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 24px 60px rgba(0,0,0,0.08);
    padding: 24px;
    display: flex;
    flex-direction: column;
    position: relative;
    z-index: 10;
  }}
  .selection-area {{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
    margin-bottom: 20px;
  }}
  .asset-card {{
    background: #eff6ff;
    border: 1.5px solid #3b82f6;
    border-radius: 10px;
    padding: 16px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
  }}
  .asset-thumb {{
    width: 60px;
    height: 60px;
    background: #dbeafe;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 8px;
  }}
  .asset-title {{ font-size: 13px; font-weight: 600; color: #1e293b; }}
  .asset-meta {{ font-size: 11px; color: #64748b; }}

  /* Context Menu */
  .context-flyout-wrap {{
    display: flex;
    gap: 12px;
    margin-top: auto;
  }}
  .menu-column {{
    width: 280px;
    background: rgba(255, 255, 255, 0.96);
    border: 1px solid #cbd5e1;
    border-radius: 10px;
    padding: 6px;
    box-shadow: 0 16px 40px rgba(0,0,0,0.18);
    display: flex;
    flex-direction: column;
    gap: 2px;
    font-size: 13px;
  }}
  .m-item-row {{
    padding: 7px 10px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    color: #1e293b;
  }}
  .m-item-row.active {{
    background: #007aff;
    color: #ffffff;
  }}
  .submenu-column {{
    flex: 1;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 10px;
    padding: 14px;
    display: flex;
    flex-direction: column;
    gap: 8px;
  }}
  .format-tag {{
    display: flex;
    align-items: center;
    gap: 8px;
    background: #ffffff;
    border: 1px solid #e2e8f0;
    padding: 8px 12px;
    border-radius: 6px;
    font-size: 13px;
    font-weight: 500;
    color: #334155;
  }}
  .format-tag span.check {{ color: #0071e3; font-weight: 700; }}
</style>
</head>
<body>
  <div class="top-brand">
    <div class="brand-left">
      <img src="{ICON_B64}" alt="Pathway" class="brand-icon">
      <div>
        <div class="brand-name">Pathway</div>
        <div class="brand-sub">Native Graphics Tools</div>
      </div>
    </div>
    <div class="feature-tag-badge">FEATURE 03</div>
  </div>

  <div class="hero-headline-wrap">
    <div class="pill-eyebrow" style="background:#f5f3ff; color:#7c3aed;">1-Click Right-Click Conversions</div>
    <h1 class="title-main">Batch conversions.<br><span style="color:#7c3aed">Right inside context menu.</span></h1>
    <p class="desc-sub">Stop opening ad-supported websites or paying for third-party converter apps. Convert images, documents, and archives natively.</p>
  </div>

  <div class="stage-box">
    <!-- Selected Items Grid -->
    <div class="selection-area">
      <div class="asset-card">
        <div class="asset-thumb">{SVG_IMAGE}</div>
        <div class="asset-title">hero-render.png</div>
        <div class="asset-meta">PNG · 2.4 MB</div>
      </div>
      <div class="asset-card">
        <div class="asset-thumb">{SVG_IMAGE}</div>
        <div class="asset-title">mockup-dark.png</div>
        <div class="asset-meta">PNG · 1.8 MB</div>
      </div>
      <div class="asset-card">
        <div class="asset-thumb">{SVG_IMAGE}</div>
        <div class="asset-title">social-banner.heic</div>
        <div class="asset-meta">HEIC · 1.2 MB</div>
      </div>
    </div>

    <!-- Context Menu -->
    <div class="context-flyout-wrap">
      <div class="menu-column">
        <div class="m-item-row"><span>↗ Open</span><span style="font-size:11px; color:#64748b;">↵ Enter</span></div>
        <div class="m-item-row"><span>✂️ Cut</span><span style="font-size:11px; color:#64748b;">⌘X</span></div>
        <div class="m-item-row"><span>📋 Copy</span><span style="font-size:11px; color:#64748b;">⌘C</span></div>
        <div class="m-item-row"><span>✏️ Rename</span><span style="font-size:11px; color:#64748b;">F2</span></div>
        <div style="height:1px; background:#e2e8f0; margin:4px 0;"></div>
        <div class="m-item-row"><span>📦 Compress to ZIP</span></div>
        <div class="m-item-row active"><span>🖼 Convert Images (3 items)</span><span>▸</span></div>
        <div class="m-item-row"><span>📄 Convert Documents</span><span>▸</span></div>
        <div style="height:1px; background:#e2e8f0; margin:4px 0;"></div>
        <div class="m-item-row"><span>🔗 Copy Path</span><span style="font-size:11px; color:#64748b;">⌥⌘C</span></div>
      </div>

      <div class="submenu-column">
        <div style="font-size:12px; font-weight:700; color:#0f172a; text-transform:uppercase; letter-spacing:0.04em;">Supported Conversions</div>
        <div class="format-tag"><span class="check">✓</span><span>Convert to JPEG (Quality 90%)</span></div>
        <div class="format-tag"><span class="check">✓</span><span>Convert to PNG (Lossless)</span></div>
        <div class="format-tag"><span class="check">✓</span><span>Convert to HEIC (High Efficiency)</span></div>
        <div class="format-tag"><span class="check">✓</span><span>Convert to WebP format</span></div>
        <div class="format-tag"><span class="check">✓</span><span>Merge into Single Multi-Page PDF</span></div>
      </div>
    </div>
  </div>

  <div class="footer-cta-block">
    <div class="btn-download-bar">
      <span>⬇</span>
      <span>Download Pathway (Free)</span>
      <span class="bio-pill">Link in Bio 🔗</span>
    </div>
    <div class="footer-caption-line">
      <span>CoreGraphics & ImageIO · Zero cloud uploads</span>
      <span class="caption-dot"></span>
      <span>github.com/GopiKrishnaRakesh/indiesuite-mac</span>
    </div>
  </div>
</body>
</html>"""
    render_feature(html, "feature-3-context-conversions")


# =============================================================
# 4. FEATURE RENDER: KEYBOARD ERGONOMICS
# =============================================================
def generate_render_4():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_CSS}
  .key-matrix-frame {{
    flex: 1;
    max-height: 660px;
    background: #f8fafc;
    border-radius: 18px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 24px 60px rgba(0,0,0,0.08);
    padding: 28px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 16px;
    z-index: 10;
  }}
  .key-row-item {{
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    padding: 16px 20px;
    display: flex;
    align-items: center;
    gap: 20px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.02);
  }}
  .tactile-key {{
    min-width: 120px;
    height: 54px;
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-bottom: 4px solid #94a3b8;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    font-weight: 700;
    color: #0f172a;
    font-family: "SF Mono", Menlo, monospace;
    box-shadow: 0 4px 10px rgba(0,0,0,0.04);
  }}
  .key-detail-block h4 {{
    font-size: 17px;
    font-weight: 700;
    color: #0f172a;
    margin-bottom: 4px;
  }}
  .key-detail-block p {{
    font-size: 14px;
    color: #64748b;
  }}
</style>
</head>
<body>
  <div class="top-brand">
    <div class="brand-left">
      <img src="{ICON_B64}" alt="Pathway" class="brand-icon">
      <div>
        <div class="brand-name">Pathway</div>
        <div class="brand-sub">Muscle Memory Restored</div>
      </div>
    </div>
    <div class="feature-tag-badge">FEATURE 04</div>
  </div>

  <div class="hero-headline-wrap">
    <div class="pill-eyebrow" style="background:#e0f2fe; color:#0369a1;">Ergonomics Reclaimed</div>
    <h1 class="title-main">Every shortcut you know.<br><span style="color:#0284c7;">Active on day one.</span></h1>
    <p class="desc-sub">No more accidentally renaming on Enter or fighting Finder keyboard quirks. Standard keys work as expected.</p>
  </div>

  <div class="key-matrix-frame">
    <div class="key-row-item">
      <div class="tactile-key" style="background:#eff6ff; border-color:#93c5fd; color:#1d4ed8;">↵ ENTER</div>
      <div class="key-detail-block">
        <h4>Opens the File or Folder</h4>
        <p>Launches documents in their default app, or steps into folders. Never triggers a slow rename.</p>
      </div>
    </div>

    <div class="key-row-item">
      <div class="tactile-key" style="background:#fefce8; border-color:#fde047; color:#a16207;">F2</div>
      <div class="key-detail-block">
        <h4>Instant Inline Rename</h4>
        <p>Immediately focuses the text field with the basename selected, leaving the extension untouched.</p>
      </div>
    </div>

    <div class="key-row-item">
      <div class="tactile-key">⌘X / Ctrl+X</div>
      <div class="key-detail-block">
        <h4>True Cut & Paste with Undo</h4>
        <p>Cut items across folders with atomic move semantics and multi-level Undo/Redo (⌘Z).</p>
      </div>
    </div>

    <div class="key-row-item">
      <div class="tactile-key">⌫ Backspace</div>
      <div class="key-detail-block">
        <h4>Navigate Up & Back</h4>
        <p>Instantly step back to the enclosing parent directory with single-key speed.</p>
      </div>
    </div>
  </div>

  <div class="footer-cta-block">
    <div class="btn-download-bar">
      <span>⬇</span>
      <span>Download Pathway (Free)</span>
      <span class="bio-pill">Link in Bio 🔗</span>
    </div>
    <div class="footer-caption-line">
      <span>Press ⌘/ in app for full shortcut matrix</span>
      <span class="caption-dot"></span>
      <span>github.com/GopiKrishnaRakesh/indiesuite-mac</span>
    </div>
  </div>
</body>
</html>"""
    render_feature(html, "feature-4-keyboard-shortcuts")


# =============================================================
# 5. FEATURE RENDER: DARK & LIGHT MODE
# =============================================================
def generate_render_5():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_CSS}
  .duo-frame-container {{
    flex: 1;
    max-height: 660px;
    display: flex;
    flex-direction: column;
    gap: 16px;
    z-index: 10;
  }}
  .mode-half-card {{
    flex: 1;
    border-radius: 14px;
    border: 1px solid rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    box-shadow: 0 14px 35px rgba(0,0,0,0.06);
  }}
  .mode-half-card.light {{
    background: #ffffff;
  }}
  .mode-half-card.dark {{
    background: #181920;
    color: #ffffff;
    border-color: rgba(255,255,255,0.12);
  }}
  .mode-topbar {{
    height: 38px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 16px;
    font-size: 11px;
    font-weight: 600;
  }}
  .mode-topbar.light-bar {{ background: #f8fafc; border-bottom: 1px solid #e2e8f0; color: #475569; }}
  .mode-topbar.dark-bar {{ background: #22232c; border-bottom: 1px solid rgba(255,255,255,0.08); color: #cbd5e1; }}

  .mini-table {{
    flex: 1;
    display: flex;
    flex-direction: column;
    font-size: 12px;
    padding: 6px 16px;
  }}
  .mini-row {{
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 7px 0;
    border-bottom: 1px solid #f8fafc;
  }}
  .mode-half-card.dark .mini-row {{
    border-bottom-color: rgba(255,255,255,0.04);
  }}
  .chip-tag {{
    font-size: 11px;
    font-weight: 700;
    padding: 2px 7px;
    border-radius: 4px;
  }}
  .chip-light {{ background: #ecfdf5; color: #059669; }}
  .chip-dark {{ background: rgba(16, 185, 129, 0.2); color: #34d399; }}
</style>
</head>
<body>
  <div class="top-brand">
    <div class="brand-left">
      <img src="{ICON_B64}" alt="Pathway" class="brand-icon">
      <div>
        <div class="brand-name">Pathway</div>
        <div class="brand-sub">Native macOS Aesthetics</div>
      </div>
    </div>
    <div class="feature-tag-badge">FEATURE 05</div>
  </div>

  <div class="hero-headline-wrap">
    <div class="pill-eyebrow" style="background:#f1f5f9; color:#0f172a;">Native SwiftUI Adaptability</div>
    <h1 class="title-main">Designed for day & night.<br><span style="color:#0071e3;">Zero third-party UI bloat.</span></h1>
    <p class="desc-sub">Seamlessly adapts to macOS appearance with genuine Apple vibrancy, translucent sidebars, and dark mode contrast.</p>
  </div>

  <div class="duo-frame-container">
    <!-- Light Mode Window -->
    <div class="mode-half-card light">
      <div class="mode-topbar light-bar">
        <div class="traffic-group">
          <div class="t-dot t-red"></div>
          <div class="t-dot t-yellow"></div>
          <div class="t-dot t-green"></div>
        </div>
        <span>Pathway — Light Appearance</span>
        <span style="color:#64748b;">⌘1 Details</span>
      </div>
      <div class="mini-table">
        <div class="mini-row">
          <div style="display:flex; align-items:center; gap:8px;">{SVG_FOLDER} <strong style="color:#1e293b;">DerivedData</strong></div>
          <span style="color:#64748b;">Today, 18:30</span>
          <span class="chip-tag chip-light">✓ 1.84 GB</span>
        </div>
        <div class="mini-row">
          <div style="display:flex; align-items:center; gap:8px;">{SVG_SWIFT} <span>FileBrowserModel.swift</span></div>
          <span style="color:#64748b;">Today, 18:40</span>
          <span style="font-weight:600; color:#334155;">32.8 KB</span>
        </div>
      </div>
    </div>

    <!-- Dark Mode Window -->
    <div class="mode-half-card dark">
      <div class="mode-topbar dark-bar">
        <div class="traffic-group">
          <div class="t-dot t-red"></div>
          <div class="t-dot t-yellow"></div>
          <div class="t-dot t-green"></div>
        </div>
        <span>Pathway — Dark Appearance</span>
        <span style="color:#94a3b8;">⌘1 Details</span>
      </div>
      <div class="mini-table">
        <div class="mini-row">
          <div style="display:flex; align-items:center; gap:8px;">{SVG_FOLDER} <strong style="color:#ffffff;">node_modules</strong></div>
          <span style="color:#94a3b8;">Today, 17:15</span>
          <span class="chip-tag chip-dark">✓ 418.2 MB</span>
        </div>
        <div class="mini-row">
          <div style="display:flex; align-items:center; gap:8px;">{SVG_DMG} <span>Pathway-1.0.0.dmg</span></div>
          <span style="color:#94a3b8;">Today, 17:45</span>
          <span style="font-weight:600; color:#38bdf8;">1.8 MB</span>
        </div>
      </div>
    </div>
  </div>

  <div class="footer-cta-block">
    <div class="btn-download-bar">
      <span>⬇</span>
      <span>Download Pathway (Free)</span>
      <span class="bio-pill">Link in Bio 🔗</span>
    </div>
    <div class="footer-caption-line">
      <span>1.8 MB · Universal Binary · No Sandbox Jail</span>
      <span class="caption-dot"></span>
      <span>github.com/GopiKrishnaRakesh/indiesuite-mac</span>
    </div>
  </div>
</body>
</html>"""
    render_feature(html, "feature-5-dark-light-mode")


if __name__ == "__main__":
    print("Generating 5 Feature Renders for Instagram (1080x1350)...")
    generate_render_1()
    generate_render_2()
    generate_render_3()
    generate_render_4()
    generate_render_5()
    print("\n✓ All 5 Feature Renders created successfully in website/assets/instagram/features/!")
