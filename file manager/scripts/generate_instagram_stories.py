#!/usr/bin/env python3
"""
Generates 6 high-end, professional Instagram Story carousel renders.
Format: 1080x1920 (9:16 vertical story aspect ratio).
Aesthetic: Minimalist, subtle colors, authentic macOS window chrome, tactile keycaps,
clean developer typography, and mobile safe zones.
Zero AI artifacts.
"""

import os
import subprocess
import base64
from PIL import Image

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(SCRIPT_DIR)
ASSETS_DIR = os.path.join(PROJECT_DIR, "website", "assets")
STORIES_DIR = os.path.join(ASSETS_DIR, "instagram", "stories")
os.makedirs(STORIES_DIR, exist_ok=True)
TMP_DIR = "/tmp/pathway_story_renders"
os.makedirs(TMP_DIR, exist_ok=True)

CHROME_BIN = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Base64 App Icon
icon_path = os.path.join(ASSETS_DIR, "app-icon.png")
with open(icon_path, "rb") as f:
    ICON_B64 = "data:image/png;base64," + base64.b64encode(f.read()).decode("utf-8")

# Common SVGs
SVG_FOLDER = """<svg width="22" height="22" viewBox="0 0 24 24" fill="#007aff"><path d="M20 18c0 1.1-.9 2-2 2H6c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2h4l2 2h6c1.1 0 2 .9 2 2v10z"/></svg>"""
SVG_SWIFT = """<svg width="22" height="22" viewBox="0 0 24 24" fill="#f05138"><path d="M20.9 14.8c-.8 2-2.3 3.6-4.3 4.8 2.2-.6 4-1.9 5.3-3.6-1 2.3-2.9 4-5.3 4.9 3.5-.7 6.4-3.1 7.4-6.6-1.5 1.5-3.3 2.5-5.3 3 1.9-1.2 3.4-3 4.2-5.1-1.2 1.3-2.7 2.2-4.3 2.7 1.8-1.7 2.9-4 3.1-6.6-.7 1.2-1.6 2.3-2.7 3.2C18 7.3 16 4.3 12.9 2c1.7 2.8 2.1 5.9 1.2 8.7-1.1-1.3-2.5-2.2-4.1-2.7 2.2 2.6 2.8 6.1 1.7 9.1-1.9-2.1-3-4.9-3.2-7.8-.8 1.4-1.2 3-1.2 4.7 0 5.4 4.4 9.8 9.8 9.8 3.5 0 6.6-1.8 8.4-4.6-1.6.4-3.1.2-4.6-.6z"/></svg>"""
SVG_DOC = """<svg width="22" height="22" viewBox="0 0 24 24" fill="#5ac8fa"><path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z"/></svg>"""
SVG_DMG = """<svg width="22" height="22" viewBox="0 0 24 24" fill="#af52de"><path d="M2 20h20v-4H2v4zm2-3h2v2H4v-2zM2 4v4h20V4H2zm4 3H4V5h2v2zm-4 7h20v-4H2v4zm2-3h2v2H4v-2z"/></svg>"""
SVG_IMAGE = """<svg width="22" height="22" viewBox="0 0 24 24" fill="#34c759"><path d="M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zM8.5 13.5l2.5 3.01L14.5 12l4.5 6H5l3.5-4.5z"/></svg>"""
SVG_LINK = """<svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>"""
SVG_DOWNLOAD = """<svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>"""

def render_story(html_content, filename):
    html_path = os.path.join(TMP_DIR, f"{filename}.html")
    png_path = os.path.join(TMP_DIR, f"{filename}.png")
    jpg_path = os.path.join(STORIES_DIR, f"{filename}.jpg")

    with open(html_path, "w", encoding="utf-8") as f:
        f.write(html_content)

    cmd = [
        CHROME_BIN,
        "--headless",
        "--disable-gpu",
        "--force-device-scale-factor=2",
        "--window-size=1080,1920",
        f"--screenshot={png_path}",
        f"file://{html_path}"
    ]
    subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    img = Image.open(png_path).convert("RGB")
    if img.width != 1080 or img.height != 1920:
        img = img.resize((1080, 1920), Image.Resampling.LANCZOS)
    img.save(jpg_path, "JPEG", quality=95, optimize=True)
    print(f"✓ Rendered Story {filename}.jpg (1080x1920) -> {jpg_path}")


def get_progress_bars(active_index, total=6):
    bars = []
    for i in range(total):
        if i == active_index:
            bars.append('<div class="prog-bar active"></div>')
        elif i < active_index:
            bars.append('<div class="prog-bar filled"></div>')
        else:
            bars.append('<div class="prog-bar"></div>')
    return "".join(bars)


SHARED_STORY_CSS = """
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1080px;
    height: 1920px;
    background: radial-gradient(circle at 50% 15%, #ffffff 0%, #f6f7f9 55%, #eaecef 100%);
    font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Inter", sans-serif;
    color: #121316;
    overflow: hidden;
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 100px 64px 130px 64px; /* Safe from Instagram Stories UI top & bottom */
  }

  /* Segmented Story Progress Bar */
  .story-progress-row {
    position: absolute;
    top: 50px;
    left: 64px;
    right: 64px;
    display: flex;
    gap: 8px;
    z-index: 100;
  }
  .prog-bar {
    flex: 1;
    height: 4px;
    background: rgba(0, 0, 0, 0.12);
    border-radius: 999px;
  }
  .prog-bar.filled {
    background: #121316;
  }
  .prog-bar.active {
    background: #0071e3;
    box-shadow: 0 0 8px rgba(0, 113, 227, 0.4);
  }

  /* Top Story Header */
  .story-top-nav {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    margin-bottom: 24px;
    z-index: 50;
  }
  .app-identity {
    display: flex;
    align-items: center;
    gap: 14px;
  }
  .app-icon-img {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    box-shadow: 0 4px 14px rgba(0,0,0,0.08);
  }
  .app-name-wrap {
    display: flex;
    flex-direction: column;
  }
  .app-name {
    font-size: 20px;
    font-weight: 700;
    letter-spacing: -0.02em;
    color: #121316;
  }
  .app-subtitle {
    font-size: 13px;
    color: #64748b;
    font-weight: 500;
  }
  .story-pill-tag {
    background: rgba(0,0,0,0.04);
    border: 1px solid rgba(0,0,0,0.08);
    padding: 6px 14px;
    border-radius: 999px;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.04em;
    text-transform: uppercase;
    color: #475569;
  }

  /* Headline Block */
  .story-headline-block {
    margin-bottom: 24px;
    z-index: 50;
  }
  .story-eyebrow {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: 13px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    padding: 6px 14px;
    border-radius: 999px;
    margin-bottom: 12px;
  }
  .eyebrow-blue {
    background: #eef6ff;
    color: #0066cc;
    border: 1px solid rgba(0, 102, 204, 0.15);
  }
  .eyebrow-teal {
    background: #ecfdf5;
    color: #059669;
    border: 1px solid rgba(5, 150, 105, 0.15);
  }
  .eyebrow-amber {
    background: #fffbeb;
    color: #d97706;
    border: 1px solid rgba(217, 119, 6, 0.15);
  }
  .eyebrow-purple {
    background: #f5f3ff;
    color: #7c3aed;
    border: 1px solid rgba(124, 58, 237, 0.15);
  }
  .story-title {
    font-size: 52px;
    font-weight: 700;
    line-height: 1.14;
    letter-spacing: -0.04em;
    color: #121316;
    margin-bottom: 12px;
  }
  .story-desc {
    font-size: 20px;
    font-weight: 400;
    color: #52545d;
    line-height: 1.48;
    max-width: 900px;
  }

  /* Traffic lights */
  .traffic-group { display: flex; gap: 8px; }
  .t-dot { width: 12px; height: 12px; border-radius: 50%; }
  .t-red { background: #ff5f56; }
  .t-yellow { background: #ffbd2e; }
  .t-green { background: #27c93f; }

  /* Story Bottom Sticker CTA */
  .story-footer-block {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 14px;
    z-index: 50;
    margin-top: 20px;
  }
  .story-link-sticker {
    width: 100%;
    height: 74px;
    background: #ffffff;
    border: 1.5px solid rgba(0, 113, 227, 0.3);
    border-radius: 20px;
    box-shadow: 0 14px 34px rgba(0, 113, 227, 0.12), 0 2px 6px rgba(0,0,0,0.04);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 24px;
    color: #121316;
  }
  .sticker-left {
    display: flex;
    align-items: center;
    gap: 14px;
  }
  .sticker-icon-circle {
    width: 44px;
    height: 44px;
    border-radius: 12px;
    background: #0071e3;
    color: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .sticker-text-group {
    display: flex;
    flex-direction: column;
  }
  .sticker-title {
    font-size: 19px;
    font-weight: 700;
    letter-spacing: -0.02em;
    color: #121316;
  }
  .sticker-sub {
    font-size: 13px;
    color: #64748b;
  }
  .sticker-pill {
    background: #121316;
    color: #ffffff;
    font-size: 14px;
    font-weight: 600;
    padding: 9px 18px;
    border-radius: 999px;
    display: flex;
    align-items: center;
    gap: 6px;
  }
  .story-sub-meta {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 13px;
    color: #64748b;
  }
  .meta-dot { width: 4px; height: 4px; border-radius: 50%; background: #94a3b8; }
"""

# =============================================================
# STORY 1: APP OVERVIEW & HERO STAGE
# =============================================================
def generate_story_1():
    prog = get_progress_bars(0)
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_STORY_CSS}
  .hero-window-card {{
    flex: 1;
    background: #ffffff;
    border-radius: 24px;
    border: 1px solid rgba(0,0,0,0.08);
    box-shadow: 0 30px 80px rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    position: relative;
    max-height: 1060px;
  }}
  .window-topbar {{
    height: 48px;
    background: #fafbfd;
    border-bottom: 1px solid #eef2f6;
    display: flex;
    align-items: center;
    padding: 0 20px;
    justify-content: space-between;
  }}
  .breadcrumb-bar {{
    height: 44px;
    background: #ffffff;
    border-bottom: 1px solid #f1f5f9;
    display: flex;
    align-items: center;
    padding: 0 20px;
    gap: 8px;
    font-size: 13px;
    color: #64748b;
  }}
  .b-pill {{
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 3px 10px;
    color: #1e293b;
    font-weight: 500;
  }}
  .action-ribbon {{
    height: 52px;
    background: #fafbfd;
    border-bottom: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    padding: 0 20px;
    gap: 8px;
  }}
  .r-btn {{
    font-size: 13px;
    font-weight: 600;
    color: #334155;
    background: #ffffff;
    border: 1px solid #cbd5e1;
    padding: 6px 13px;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.04);
  }}
  .r-btn-primary {{
    background: #eef6ff;
    color: #0071e3;
    border-color: rgba(0,113,227,0.3);
  }}
  .split-workspace {{
    display: flex;
    flex: 1;
    background: #ffffff;
  }}
  .sidebar {{
    width: 250px;
    background: #f8fafc;
    border-right: 1px solid #eef2f6;
    padding: 20px 16px;
    display: flex;
    flex-direction: column;
    gap: 18px;
  }}
  .side-sec-title {{
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 0.06em;
    color: #94a3b8;
    text-transform: uppercase;
  }}
  .side-item {{
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 14px;
    font-weight: 500;
    color: #334155;
    padding: 8px 10px;
    border-radius: 8px;
  }}
  .side-item.active {{
    background: #e0f0ff;
    color: #0071e3;
    font-weight: 600;
  }}
  .file-table-wrap {{
    flex: 1;
    display: flex;
    flex-direction: column;
  }}
  .table-header {{
    display: flex;
    align-items: center;
    padding: 12px 24px;
    font-size: 12px;
    font-weight: 600;
    color: #64748b;
    border-bottom: 1px solid #f1f5f9;
    text-transform: uppercase;
    letter-spacing: 0.04em;
  }}
  .file-row {{
    display: flex;
    align-items: center;
    padding: 14px 24px;
    border-bottom: 1px solid #f8fafc;
    font-size: 15px;
    color: #1e293b;
  }}
  .file-row.highlight {{
    background: #f0f7ff;
  }}
  .badge-size-teal {{
    background: #ecfdf5;
    color: #059669;
    font-size: 12px;
    font-weight: 700;
    padding: 3px 9px;
    border-radius: 999px;
    border: 1px solid rgba(5,150,105,0.2);
  }}
</style>
</head>
<body>
  <div class="story-progress-row">{prog}</div>

  <div class="story-top-nav">
    <div class="app-identity">
      <img src="{ICON_B64}" class="app-icon-img" alt="Pathway">
      <div class="app-name-wrap">
        <span class="app-name">Pathway</span>
        <span class="app-subtitle">Native File Manager for macOS</span>
      </div>
    </div>
    <span class="story-pill-tag">Story 1 / 6</span>
  </div>

  <div class="story-headline-block">
    <div class="story-eyebrow eyebrow-blue">EXPLORER'S MUSCLE MEMORY · MACOS ELEGANCE</div>
    <h1 class="story-title">The file manager your Mac was always missing.</h1>
    <p class="story-desc">
      Built for anyone frustrated with Finder. Enter opens files, F2 renames, full breadcrumb navigation, and real live folder weights.
    </p>
  </div>

  <!-- Hero Window Stage -->
  <div class="hero-window-card">
    <div class="window-topbar">
      <div class="traffic-group">
        <div class="t-dot t-red"></div>
        <div class="t-dot t-yellow"></div>
        <div class="t-dot t-green"></div>
      </div>
      <span style="font-size:13px; font-weight:600; color:#475569;">Pathway — indiesuite-mac</span>
      <span style="font-size:12px; color:#64748b;">⌘1 Details View</span>
    </div>

    <!-- Breadcrumb Capsule -->
    <div class="breadcrumb-bar">
      <span>◂ ▸</span>
      <span class="b-pill">Macintosh HD</span>
      <span>›</span>
      <span class="b-pill">Users</span>
      <span>›</span>
      <span class="b-pill">developer</span>
      <span>›</span>
      <span class="b-pill" style="color:#0071e3; font-weight:600;">Workspace</span>
    </div>

    <!-- Action Ribbon -->
    <div class="action-ribbon">
      <div class="r-btn r-btn-primary">+ New Folder</div>
      <div class="r-btn">✂ Cut (⌘X)</div>
      <div class="r-btn">⎘ Copy</div>
      <div class="r-btn">✎ Rename (F2)</div>
      <div class="r-btn">↕ Sort: Size ▼</div>
      <div class="r-btn">📁 Group: Type ▼</div>
    </div>

    <!-- Workspace Body -->
    <div class="split-workspace">
      <div class="sidebar">
        <div class="side-sec-title">Quick Access</div>
        <div class="side-item">📁 Desktop</div>
        <div class="side-item">📄 Documents</div>
        <div class="side-item">⬇ Downloads</div>
        <div class="side-item active">💼 Workspace</div>
        <div class="side-sec-title" style="margin-top:10px;">Drives</div>
        <div class="side-item">💾 Macintosh HD</div>
        <div class="side-item">⚡ External SSD</div>
      </div>

      <div class="file-table-wrap">
        <div class="table-header">
          <div style="flex:2;">Name</div>
          <div style="flex:1.2;">Date Modified</div>
          <div style="flex:1;">Type</div>
          <div style="flex:1; text-align:right;">Size</div>
        </div>

        <div class="file-row highlight">
          <div style="flex:2; display:flex; align-items:center; gap:10px; font-weight:600;">
            {SVG_FOLDER} DerivedData
          </div>
          <div style="flex:1.2; color:#64748b;">Today, 18:30</div>
          <div style="flex:1; color:#64748b;">Folder</div>
          <div style="flex:1; text-align:right;"><span class="badge-size-teal">✓ 1.84 GB</span></div>
        </div>

        <div class="file-row">
          <div style="flex:2; display:flex; align-items:center; gap:10px; font-weight:600;">
            {SVG_FOLDER} node_modules
          </div>
          <div style="flex:1.2; color:#64748b;">Today, 17:15</div>
          <div style="flex:1; color:#64748b;">Folder</div>
          <div style="flex:1; text-align:right;"><span class="badge-size-teal">✓ 418.2 MB</span></div>
        </div>

        <div class="file-row">
          <div style="flex:2; display:flex; align-items:center; gap:10px;">
            {SVG_SWIFT} FileBrowserModel.swift
          </div>
          <div style="flex:1.2; color:#64748b;">Today, 18:48</div>
          <div style="flex:1; color:#64748b;">Swift Source</div>
          <div style="flex:1; text-align:right; font-weight:600; color:#334155;">32.8 KB</div>
        </div>

        <div class="file-row">
          <div style="flex:2; display:flex; align-items:center; gap:10px;">
            {SVG_DMG} Pathway-1.0.0.dmg
          </div>
          <div style="flex:1.2; color:#64748b;">Today, 17:45</div>
          <div style="flex:1; color:#64748b;">Disk Image</div>
          <div style="flex:1; text-align:right; font-weight:600; color:#0071e3;">1.8 MB</div>
        </div>

        <div class="file-row">
          <div style="flex:2; display:flex; align-items:center; gap:10px;">
            {SVG_DOC} Project_Architecture.docx
          </div>
          <div style="flex:1.2; color:#64748b;">Today, 15:20</div>
          <div style="flex:1; color:#64748b;">Document</div>
          <div style="flex:1; text-align:right; font-weight:600; color:#334155;">1.4 MB</div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bottom CTA -->
  <div class="story-footer-block">
    <div class="story-link-sticker">
      <div class="sticker-left">
        <div class="sticker-icon-circle">{SVG_LINK}</div>
        <div class="sticker-text-group">
          <span class="sticker-title">Download Pathway for macOS</span>
          <span class="sticker-sub">Free · Universal Binary (M1–M4 & Intel)</span>
        </div>
      </div>
      <div class="sticker-pill">
        <span>Link in Bio</span>
        <span>→</span>
      </div>
    </div>
    <div class="story-sub-meta">
      <span>100% Native SwiftUI</span>
      <span class="meta-dot"></span>
      <span>No Sandbox Limitations</span>
      <span class="meta-dot"></span>
      <span>Swipe to see features</span>
    </div>
  </div>
</body>
</html>"""
    render_story(html, "story-1-overview")


# =============================================================
# STORY 2: ENTER OPENS & F2 RENAMES (REFINED LAYOUT)
# =============================================================
def generate_story_2():
    prog = get_progress_bars(1)
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_STORY_CSS}
  .keycap-showcase-stage {{
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    gap: 16px;
    max-height: 1080px;
  }}
  .key-comparison-card {{
    background: #ffffff;
    border-radius: 20px;
    border: 1px solid rgba(0,0,0,0.07);
    box-shadow: 0 16px 40px rgba(0,0,0,0.05);
    padding: 24px 28px;
    display: flex;
    flex-direction: column;
    gap: 14px;
  }}
  .key-card-top {{
    display: flex;
    align-items: center;
    gap: 20px;
  }}
  .tactile-key {{
    min-width: 140px;
    height: 64px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    font-weight: 700;
    box-shadow: 0 5px 0 rgba(0,0,0,0.12), 0 8px 18px rgba(0,0,0,0.06);
    border: 1px solid rgba(0,0,0,0.1);
  }}
  .key-enter {{
    background: linear-gradient(180deg, #f0f7ff 0%, #e0effe 100%);
    color: #0071e3;
    border-color: #bae6fd;
    box-shadow: 0 5px 0 #93c5fd, 0 8px 18px rgba(0,113,227,0.12);
  }}
  .key-f2 {{
    background: linear-gradient(180deg, #fffbeb 0%, #fef3c7 100%);
    color: #d97706;
    border-color: #fde68a;
    box-shadow: 0 5px 0 #fcd34d, 0 8px 18px rgba(217,119,6,0.12);
  }}
  .key-cut {{
    background: linear-gradient(180deg, #ecfdf5 0%, #d1fae5 100%);
    color: #059669;
    border-color: #a7f3d0;
    box-shadow: 0 5px 0 #6ee7b7, 0 8px 18px rgba(5,150,105,0.12);
  }}
  .key-back {{
    background: linear-gradient(180deg, #f5f3ff 0%, #ede9fe 100%);
    color: #7c3aed;
    border-color: #ddd6fe;
    box-shadow: 0 5px 0 #c4b5fd, 0 8px 18px rgba(124,58,237,0.12);
  }}
  .key-info-wrap {{
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 3px;
  }}
  .key-card-title {{
    font-size: 21px;
    font-weight: 700;
    color: #121316;
    letter-spacing: -0.02em;
  }}
  .key-card-desc {{
    font-size: 15px;
    color: #52545d;
    line-height: 1.35;
  }}
  .micro-stage-row {{
    background: #fafbfd;
    border: 1px solid #eef2f6;
    border-radius: 12px;
    padding: 10px 16px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 14px;
  }}
  .pill-status {{
    font-size: 12px;
    font-weight: 700;
    padding: 3px 10px;
    border-radius: 999px;
  }}
  .p-blue {{ background:#eef6ff; color:#0071e3; }}
  .p-amber {{ background:#fffbeb; color:#d97706; }}
  .p-green {{ background:#ecfdf5; color:#059669; }}
  .p-purple {{ background:#f5f3ff; color:#7c3aed; }}
</style>
</head>
<body>
  <div class="story-progress-row">{prog}</div>

  <div class="story-top-nav">
    <div class="app-identity">
      <img src="{ICON_B64}" class="app-icon-img" alt="Pathway">
      <div class="app-name-wrap">
        <span class="app-name">Pathway</span>
        <span class="app-subtitle">Keyboard Ergonomics Reclaimed</span>
      </div>
    </div>
    <span class="story-pill-tag">Story 2 / 6</span>
  </div>

  <div class="story-headline-block">
    <div class="story-eyebrow eyebrow-blue">MUSCLE MEMORY UNBROKEN</div>
    <h1 class="story-title">Stop accidentally renaming on Enter.</h1>
    <p class="story-desc">
      In Finder, pressing Enter renames instead of opening files. Pathway brings back the universal desktop ergonomics you know.
    </p>
  </div>

  <!-- Keycap Showcase Stage -->
  <div class="keycap-showcase-stage">
    <!-- Enter Card -->
    <div class="key-comparison-card">
      <div class="key-card-top">
        <div class="tactile-key key-enter">↵ ENTER</div>
        <div class="key-info-wrap">
          <span class="key-card-title">Launches Files & Opens Folders</span>
          <span class="key-card-desc">Instantly launches apps, opens documents, or steps into subfolders.</span>
        </div>
      </div>
      <div class="micro-stage-row">
        <div style="display:flex; align-items:center; gap:8px;">{SVG_DOC} <strong>Design_Brief.docx</strong></div>
        <span class="pill-status p-blue">✓ Opens instantly in Pages / Word</span>
      </div>
    </div>

    <!-- F2 Card -->
    <div class="key-comparison-card">
      <div class="key-card-top">
        <div class="tactile-key key-f2">F2</div>
        <div class="key-info-wrap">
          <span class="key-card-title">Instant Inline Rename</span>
          <span class="key-card-desc">Selects the basename automatically and protects the file extension.</span>
        </div>
      </div>
      <div class="micro-stage-row">
        <div style="display:flex; align-items:center; gap:6px;">
          <span>✎</span>
          <span style="background:#bfdbfe; padding:2px 6px; border-radius:4px; font-weight:600; color:#1e3a8a;">Release_v1.0</span>
          <span style="color:#64748b;">.swift</span>
        </div>
        <span class="pill-status p-amber">✓ Extension protected from edits</span>
      </div>
    </div>

    <!-- ⌘X / Ctrl+X Card -->
    <div class="key-comparison-card">
      <div class="key-card-top">
        <div class="tactile-key key-cut">⌘X / Ctrl+X</div>
        <div class="key-info-wrap">
          <span class="key-card-title">True Cut & Paste with Undo</span>
          <span class="key-card-desc">Stages files for atomic transfer with instant ⌘Z rollback history.</span>
        </div>
      </div>
      <div class="micro-stage-row">
        <div style="display:flex; align-items:center; gap:8px;">{SVG_DMG} <span style="opacity:0.65; border-bottom:1px dashed #059669;">Pathway-1.0.0.dmg</span></div>
        <span class="pill-status p-green">✓ Staged to move · ⌘V to paste</span>
      </div>
    </div>

    <!-- Backspace Card -->
    <div class="key-comparison-card">
      <div class="key-card-top">
        <div class="tactile-key key-back">⌫ Backspace</div>
        <div class="key-info-wrap">
          <span class="key-card-title">Navigate Up Enclosing Folder</span>
          <span class="key-card-desc">Step back up to the enclosing parent directory with single-key velocity.</span>
        </div>
      </div>
      <div class="micro-stage-row">
        <div style="font-size:13px; color:#64748b;">~/Projects/Pathway/Sources/ ➔ <strong>~/Projects/Pathway/</strong></div>
        <span class="pill-status p-purple">✓ Instant parent directory jump</span>
      </div>
    </div>
  </div>

  <!-- Bottom CTA -->
  <div class="story-footer-block">
    <div class="story-link-sticker">
      <div class="sticker-left">
        <div class="sticker-icon-circle">{SVG_LINK}</div>
        <div class="sticker-text-group">
          <span class="sticker-title">Download Pathway for Mac</span>
          <span class="sticker-sub">Try the tactile keyboard shortcuts free</span>
        </div>
      </div>
      <div class="sticker-pill">
        <span>Link in Bio</span>
        <span>→</span>
      </div>
    </div>
    <div class="story-sub-meta">
      <span>Universal Keymap</span>
      <span class="meta-dot"></span>
      <span>Customizable in Preferences</span>
      <span class="meta-dot"></span>
      <span>Swipe for storage →</span>
    </div>
  </div>
</body>
</html>"""
    render_story(html, "story-2-muscle-memory")


# =============================================================
# STORY 3: REAL FOLDER SIZES OFF-THREAD (REFINED FULL TABLE)
# =============================================================
def generate_story_3():
    prog = get_progress_bars(2)
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_STORY_CSS}
  .stage-storage-card {{
    flex: 1;
    background: #ffffff;
    border-radius: 24px;
    border: 1px solid rgba(0,0,0,0.08);
    box-shadow: 0 30px 80px rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    max-height: 1060px;
  }}
  .window-topbar {{
    height: 48px;
    background: #fafbfd;
    border-bottom: 1px solid #eef2f6;
    display: flex;
    align-items: center;
    padding: 0 20px;
    justify-content: space-between;
  }}
  .storage-toolbar {{
    height: 50px;
    background: #ffffff;
    border-bottom: 1px solid #f1f5f9;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 24px;
  }}
  .sort-chip {{
    background: #eef6ff;
    color: #0071e3;
    font-size: 13px;
    font-weight: 700;
    padding: 5px 12px;
    border-radius: 999px;
    border: 1px solid rgba(0,113,227,0.2);
  }}
  .storage-distribution-bar {{
    height: 10px;
    background: #f1f5f9;
    display: flex;
    overflow: hidden;
    border-bottom: 1px solid #e2e8f0;
  }}
  .bar-dev {{ width: 45%; background: #0071e3; }}
  .bar-cache {{ width: 25%; background: #059669; }}
  .bar-media {{ width: 15%; background: #d97706; }}
  .bar-free {{ width: 15%; background: #e2e8f0; }}

  .storage-row {{
    display: flex;
    align-items: center;
    padding: 14px 26px;
    border-bottom: 1px solid #f8fafc;
    font-size: 15px;
    color: #1e293b;
    justify-content: space-between;
  }}
  .size-pill-heavy {{
    background: #ecfdf5;
    color: #059669;
    font-size: 13px;
    font-weight: 700;
    padding: 3px 11px;
    border-radius: 999px;
    border: 1px solid rgba(5,150,105,0.25);
  }}
  .arch-banner {{
    background: #fafbfd;
    border-top: 1px solid #eef2f6;
    padding: 20px 24px;
    display: flex;
    gap: 16px;
    align-items: center;
    margin-top: auto;
  }}
  .arch-icon {{
    width: 44px;
    height: 44px;
    border-radius: 12px;
    background: #eef6ff;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #0071e3;
    font-size: 20px;
  }}
  .arch-title {{
    font-size: 15px;
    font-weight: 700;
    color: #121316;
  }}
  .arch-desc {{
    font-size: 13px;
    color: #64748b;
    margin-top: 2px;
  }}
</style>
</head>
<body>
  <div class="story-progress-row">{prog}</div>

  <div class="story-top-nav">
    <div class="app-identity">
      <img src="{ICON_B64}" class="app-icon-img" alt="Pathway">
      <div class="app-name-wrap">
        <span class="app-name">Pathway</span>
        <span class="app-subtitle">Storage Intelligence Engine</span>
      </div>
    </div>
    <span class="story-pill-tag">Story 3 / 6</span>
  </div>

  <div class="story-headline-block">
    <div class="story-eyebrow eyebrow-teal">ZERO BLANK FOLDER SIZES</div>
    <h1 class="story-title">Real folder weights. Off-thread Swift 6 actor.</h1>
    <p class="story-desc">
      Finder leaves folder sizes empty with "—". Pathway calculates true recursive weights in the background without dropping UI frames.
    </p>
  </div>

  <!-- Storage Stage Card -->
  <div class="stage-storage-card">
    <div class="window-topbar">
      <div class="traffic-group">
        <div class="t-dot t-red"></div>
        <div class="t-dot t-yellow"></div>
        <div class="t-dot t-green"></div>
      </div>
      <span style="font-size:13px; font-weight:600; color:#475569;">Developer Workspace — Real-time Size Inspector</span>
      <span style="font-size:12px; color:#059669; font-weight:600;">✓ Inode Cached</span>
    </div>

    <div class="storage-toolbar">
      <div class="sort-chip">↕ Sort by: Size (Descending ▼)</div>
      <div style="font-size:13px; color:#64748b; font-weight:500;">Calculated in Swift 6 Actor</div>
    </div>

    <!-- Storage Visual Bar -->
    <div class="storage-distribution-bar">
      <div class="bar-dev" title="Developer Files: 4.2 GB"></div>
      <div class="bar-cache" title="Build Caches: 2.1 GB"></div>
      <div class="bar-media" title="Media & Assets: 1.4 GB"></div>
      <div class="bar-free" title="Free Space: 112 GB"></div>
    </div>

    <div class="storage-row" style="background:#f8fafc;">
      <div style="display:flex; align-items:center; gap:12px; font-weight:700;">
        {SVG_FOLDER} DerivedData (Xcode Caches)
      </div>
      <span class="size-pill-heavy">✓ 1.84 GB</span>
    </div>

    <div class="storage-row">
      <div style="display:flex; align-items:center; gap:12px; font-weight:700;">
        {SVG_FOLDER} node_modules
      </div>
      <span class="size-pill-heavy">✓ 418.2 MB</span>
    </div>

    <div class="storage-row">
      <div style="display:flex; align-items:center; gap:12px; font-weight:600;">
        {SVG_FOLDER} build / Release
      </div>
      <span class="size-pill-heavy">✓ 312.0 MB</span>
    </div>

    <div class="storage-row">
      <div style="display:flex; align-items:center; gap:12px; font-weight:600;">
        {SVG_FOLDER} Assets / 4K Screencasts
      </div>
      <span class="size-pill-heavy">✓ 245.8 MB</span>
    </div>

    <div class="storage-row">
      <div style="display:flex; align-items:center; gap:12px; font-weight:600;">
        {SVG_FOLDER} Caches / CocoaPods
      </div>
      <span class="size-pill-heavy">✓ 89.4 MB</span>
    </div>

    <div class="storage-row">
      <div style="display:flex; align-items:center; gap:12px; font-weight:600;">
        {SVG_FOLDER} .git (Repository History)
      </div>
      <span class="size-pill-heavy">✓ 62.8 MB</span>
    </div>

    <div class="storage-row">
      <div style="display:flex; align-items:center; gap:12px; font-weight:600;">
        {SVG_FOLDER} Sources / Models & Views
      </div>
      <span class="size-pill-heavy">✓ 14.6 MB</span>
    </div>

    <div class="storage-row">
      <div style="display:flex; align-items:center; gap:12px;">
        {SVG_DMG} Pathway-1.0.0.dmg
      </div>
      <span style="font-weight:600; color:#0071e3;">1.8 MB</span>
    </div>

    <div class="storage-row">
      <div style="display:flex; align-items:center; gap:12px;">
        {SVG_DOC} System_Architecture.docx
      </div>
      <span style="font-weight:600; color:#475569;">1.2 MB</span>
    </div>

    <div class="storage-row">
      <div style="display:flex; align-items:center; gap:12px;">
        {SVG_SWIFT} FileBrowserModel.swift
      </div>
      <span style="font-weight:600; color:#475569;">32.8 KB</span>
    </div>

    <div class="arch-banner">
      <div class="arch-icon">⚡</div>
      <div>
        <div class="arch-title">Inode Timestamp Caching (0.4ms response)</div>
        <div class="arch-desc">Subsequent visits load instantly from memory cache. Unchanged directories are never re-indexed.</div>
      </div>
    </div>
  </div>

  <!-- Bottom CTA -->
  <div class="story-footer-block">
    <div class="story-link-sticker">
      <div class="sticker-left">
        <div class="sticker-icon-circle">{SVG_LINK}</div>
        <div class="sticker-text-group">
          <span class="sticker-title">Download Pathway (Free)</span>
          <span class="sticker-sub">Track down bloated folders in seconds</span>
        </div>
      </div>
      <div class="sticker-pill">
        <span>Link in Bio</span>
        <span>→</span>
      </div>
    </div>
    <div class="story-sub-meta">
      <span>100% Async Swift Actor</span>
      <span class="meta-dot"></span>
      <span>Smooth 120 FPS</span>
      <span class="meta-dot"></span>
      <span>Swipe for Cut & Paste →</span>
    </div>
  </div>
</body>
</html>"""
    render_story(html, "story-3-folder-sizes")


# =============================================================
# STORY 4: TRUE CUT & PASTE (REFINED DUAL-PANE VIEW)
# =============================================================
def generate_story_4():
    prog = get_progress_bars(3)
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_STORY_CSS}
  .stage-cut-card {{
    flex: 1;
    background: #ffffff;
    border-radius: 24px;
    border: 1px solid rgba(0,0,0,0.08);
    box-shadow: 0 30px 80px rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    max-height: 1060px;
  }}
  .window-topbar {{
    height: 48px;
    background: #fafbfd;
    border-bottom: 1px solid #eef2f6;
    display: flex;
    align-items: center;
    padding: 0 20px;
    justify-content: space-between;
  }}
  .cut-steps-grid {{
    padding: 20px 24px;
    display: flex;
    gap: 12px;
    background: #fafbfd;
    border-bottom: 1px solid #eef2f6;
  }}
  .cut-step {{
    flex: 1;
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    padding: 16px 14px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    gap: 8px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.02);
  }}
  .cut-key {{
    font-family: monospace;
    font-size: 14px;
    font-weight: 700;
    background: #f8fafc;
    border: 1px solid #cbd5e1;
    padding: 5px 12px;
    border-radius: 6px;
    box-shadow: 0 2px 0 #94a3b8;
    color: #1e293b;
  }}
  .cut-step-title {{
    font-size: 15px;
    font-weight: 700;
    color: #121316;
  }}
  .cut-step-sub {{
    font-size: 12px;
    color: #64748b;
  }}
  .cut-workspace-body {{
    padding: 24px;
    display: flex;
    flex-direction: column;
    gap: 16px;
    flex: 1;
  }}
  .folder-pane {{
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    overflow: hidden;
  }}
  .pane-header {{
    background: #f8fafc;
    padding: 10px 18px;
    font-size: 13px;
    font-weight: 600;
    color: #475569;
    border-bottom: 1px solid #eef2f6;
    display: flex;
    justify-content: space-between;
  }}
  .cut-row {{
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 14px 18px;
    border-bottom: 1px solid #f8fafc;
    font-size: 15px;
  }}
  .cut-row.staged {{
    background: #f0f7ff;
    border-left: 4px solid #0071e3;
    opacity: 0.85;
  }}
  .badge-cut {{
    background: #e0f0ff;
    color: #0071e3;
    font-size: 12px;
    font-weight: 700;
    padding: 4px 10px;
    border-radius: 999px;
  }}
  .target-drop-zone {{
    background: #fafbfd;
    border: 2px dashed #93c5fd;
    border-radius: 14px;
    padding: 20px;
    text-align: center;
    color: #0071e3;
    font-size: 14px;
    font-weight: 600;
  }}
</style>
</head>
<body>
  <div class="story-progress-row">{prog}</div>

  <div class="story-top-nav">
    <div class="app-identity">
      <img src="{ICON_B64}" class="app-icon-img" alt="Pathway">
      <div class="app-name-wrap">
        <span class="app-name">Pathway</span>
        <span class="app-subtitle">Atomic Filesystem Operations</span>
      </div>
    </div>
    <span class="story-pill-tag">Story 4 / 6</span>
  </div>

  <div class="story-headline-block">
    <div class="story-eyebrow eyebrow-amber">POWER USER WORKFLOW</div>
    <h1 class="story-title">True Cut & Paste with full multi-level Undo.</h1>
    <p class="story-desc">
      Stop fighting Finder's unintuitive copy-and-option-paste workflow. Cut with ⌘X, paste with ⌘V, and undo with ⌘Z.
    </p>
  </div>

  <!-- Cut & Paste Stage Card -->
  <div class="stage-cut-card">
    <div class="window-topbar">
      <div class="traffic-group">
        <div class="t-dot t-red"></div>
        <div class="t-dot t-yellow"></div>
        <div class="t-dot t-green"></div>
      </div>
      <span style="font-size:13px; font-weight:600; color:#475569;">Atomic Move Engine — Visual Feedback</span>
      <span style="font-size:12px; color:#0071e3; font-weight:600;">⌘Z Protected</span>
    </div>

    <div class="cut-steps-grid">
      <div class="cut-step">
        <div class="cut-key">⌘X / Ctrl+X</div>
        <div class="cut-step-title">1. Cut Item</div>
        <div class="cut-step-sub">Visual dimming shows item is in clipboard transit</div>
      </div>

      <div class="cut-step">
        <div class="cut-key">⌘V / Ctrl+V</div>
        <div class="cut-step-title">2. Paste Item</div>
        <div class="cut-step-sub">Instant atomic inode move with zero file corruption</div>
      </div>

      <div class="cut-step">
        <div class="cut-key">⌘Z / Undo</div>
        <div class="cut-step-title">3. Instant Undo</div>
        <div class="cut-step-sub">Full multi-level history reverses changes in 1-click</div>
      </div>
    </div>

    <div class="cut-workspace-body">
      <!-- Source Pane -->
      <div class="folder-pane">
        <div class="pane-header">
          <span>Source: ~/Downloads/Active</span>
          <span style="color:#0071e3;">1 item staged to move</span>
        </div>
        <div class="cut-row staged">
          <div style="display:flex; align-items:center; gap:12px;">
            {SVG_DOC}
            <strong>Client_Proposal_Final.pdf</strong>
          </div>
          <span class="badge-cut">✂ Cut Staged (Press ⌘V to paste)</span>
        </div>
        <div class="cut-row">
          <div style="display:flex; align-items:center; gap:12px;">
            {SVG_IMAGE}
            <span>Logo_Master.png</span>
          </div>
          <span style="color:#64748b; font-size:13px;">2.4 MB</span>
        </div>
      </div>

      <!-- Destination Pane -->
      <div class="folder-pane">
        <div class="pane-header">
          <span>Destination: ~/Documents/Archives/2026</span>
          <span style="color:#059669; font-weight:600;">Target directory</span>
        </div>
        <div class="cut-row">
          <div style="display:flex; align-items:center; gap:12px;">
            {SVG_DOC}
            <span>2025_Annual_Report.pdf</span>
          </div>
          <span style="color:#64748b; font-size:13px;">18.2 MB</span>
        </div>
        <div class="cut-row">
          <div style="display:flex; align-items:center; gap:12px;">
            {SVG_DMG}
            <span>Archive_Q2.zip</span>
          </div>
          <span style="color:#64748b; font-size:13px;">340 MB</span>
        </div>
        <div style="padding:14px;">
          <div class="target-drop-zone">
            <span>📥 Press ⌘V (or Right Click ➔ Paste) to move Client_Proposal_Final.pdf here</span>
          </div>
        </div>
      </div>
    </div>

    <div style="background:#fafbfd; border-top:1px solid #eef2f6; padding:16px 24px; display:flex; align-items:center; justify-content:space-between; font-size:13px; color:#334155; margin-top:auto;">
      <div style="display:flex; align-items:center; gap:8px;">
        <span style="color:#0071e3; font-weight:700;">⌘Z</span>
        <span>Multi-Level Undo History enabled: Atomic revert anytime</span>
      </div>
      <span style="color:#059669; font-weight:600;">✓ Safe & Non-Destructive</span>
    </div>
  </div>

  <!-- Bottom CTA -->
  <div class="story-footer-block">
    <div class="story-link-sticker">
      <div class="sticker-left">
        <div class="sticker-icon-circle">{SVG_LINK}</div>
        <div class="sticker-text-group">
          <span class="sticker-title">Download Pathway for macOS</span>
          <span class="sticker-sub">Universal Binary · Free & Open</span>
        </div>
      </div>
      <div class="sticker-pill">
        <span>Link in Bio</span>
        <span>→</span>
      </div>
    </div>
    <div class="story-sub-meta">
      <span>Atomic Moves</span>
      <span class="meta-dot"></span>
      <span>Multi-Level Undo History</span>
      <span class="meta-dot"></span>
      <span>Swipe for conversions →</span>
    </div>
  </div>
</body>
</html>"""
    render_story(html, "story-4-cut-paste")


# =============================================================
# STORY 5: 1-CLICK CONVERSIONS (REFINED WITH CONVERSION FEEDBACK)
# =============================================================
def generate_story_5():
    prog = get_progress_bars(4)
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_STORY_CSS}
  .stage-convert-card {{
    flex: 1;
    background: #ffffff;
    border-radius: 24px;
    border: 1px solid rgba(0,0,0,0.08);
    box-shadow: 0 30px 80px rgba(0,0,0,0.08);
    padding: 28px;
    display: flex;
    flex-direction: column;
    gap: 20px;
    max-height: 1060px;
  }}
  .selection-pill-tray {{
    display: flex;
    gap: 14px;
  }}
  .sel-chip {{
    flex: 1;
    background: #f8fafc;
    border: 1.5px solid #0071e3;
    border-radius: 14px;
    padding: 14px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
    box-shadow: 0 4px 12px rgba(0,113,227,0.06);
  }}
  .menu-simulation-row {{
    display: flex;
    gap: 18px;
  }}
  .context-main {{
    width: 270px;
    background: rgba(255,255,255,0.98);
    border: 1px solid rgba(0,0,0,0.1);
    border-radius: 12px;
    box-shadow: 0 16px 36px rgba(0,0,0,0.12);
    padding: 8px;
    display: flex;
    flex-direction: column;
    gap: 2px;
  }}
  .c-item {{
    padding: 8px 12px;
    font-size: 14px;
    border-radius: 6px;
    display: flex;
    justify-content: space-between;
    color: #1e293b;
  }}
  .c-item.active {{
    background: #0071e3;
    color: #ffffff;
    font-weight: 600;
  }}
  .c-sub {{
    flex: 1;
    background: #ffffff;
    border: 1px solid rgba(0,0,0,0.08);
    border-radius: 14px;
    padding: 16px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.05);
    display: flex;
    flex-direction: column;
    gap: 10px;
  }}
  .conv-option {{
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 14px;
    color: #334155;
    padding: 9px 12px;
    background: #fafbfd;
    border-radius: 8px;
    border: 1px solid #eef2f6;
  }}
  .output-drawer {{
    background: #fafbfd;
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    padding: 18px;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }}
  .output-row {{
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 13px;
    color: #334155;
    padding: 4px 0;
  }}
  .out-badge {{
    background: #ecfdf5;
    color: #059669;
    font-weight: 700;
    padding: 2px 8px;
    border-radius: 6px;
  }}
</style>
</head>
<body>
  <div class="story-progress-row">{prog}</div>

  <div class="story-top-nav">
    <div class="app-identity">
      <img src="{ICON_B64}" class="app-icon-img" alt="Pathway">
      <div class="app-name-wrap">
        <span class="app-name">Pathway</span>
        <span class="app-subtitle">Native Graphics Tools</span>
      </div>
    </div>
    <span class="story-pill-tag">Story 5 / 6</span>
  </div>

  <div class="story-headline-block">
    <div class="story-eyebrow eyebrow-purple">1-CLICK RIGHT-CLICK UTILITIES</div>
    <h1 class="story-title">Batch conversions right inside right-click.</h1>
    <p class="story-desc">
      Stop opening ad-supported websites or paying for third-party converter apps. Convert photos, documents, and archives natively.
    </p>
  </div>

  <!-- Stage Card -->
  <div class="stage-convert-card">
    <div class="selection-pill-tray">
      <div class="sel-chip">
        {SVG_IMAGE}
        <strong style="font-size:14px;">hero-render.png</strong>
        <span style="font-size:12px; color:#64748b;">2.4 MB</span>
      </div>
      <div class="sel-chip">
        {SVG_IMAGE}
        <strong style="font-size:14px;">mockup-dark.png</strong>
        <span style="font-size:12px; color:#64748b;">1.8 MB</span>
      </div>
      <div class="sel-chip">
        {SVG_IMAGE}
        <strong style="font-size:14px;">banner.heic</strong>
        <span style="font-size:12px; color:#64748b;">1.2 MB</span>
      </div>
    </div>

    <div class="menu-simulation-row">
      <div class="context-main">
        <div class="c-item"><span>Open</span> <span style="color:#94a3b8;">↵</span></div>
        <div class="c-item"><span>Cut</span> <span style="color:#94a3b8;">⌘X</span></div>
        <div class="c-item"><span>Copy</span> <span style="color:#94a3b8;">⌘C</span></div>
        <div class="c-item"><span>Rename</span> <span style="color:#94a3b8;">F2</span></div>
        <div style="height:1px; background:#e2e8f0; margin:3px 0;"></div>
        <div class="c-item active"><span>Convert Images (3 items)</span> <span>▶</span></div>
        <div class="c-item"><span>Convert Documents</span> <span>▶</span></div>
        <div class="c-item"><span>Compress to ZIP / TAR</span></div>
      </div>

      <div class="c-sub">
        <span style="font-size:12px; font-weight:700; color:#64748b; text-transform:uppercase;">Hardware-Accelerated Output</span>
        <div class="conv-option">✓ Convert to JPEG (High Quality 90%)</div>
        <div class="conv-option">✓ Convert to PNG (Lossless Alpha)</div>
        <div class="conv-option">✓ Convert to WebP Format</div>
        <div class="conv-option">✓ Merge into Single Multi-Page PDF</div>
      </div>
    </div>

    <div class="output-drawer">
      <span style="font-size:12px; font-weight:700; color:#475569; text-transform:uppercase;">Generated In Place (Zero Cloud Uploads)</span>
      <div class="output-row">
        <span>✓ <strong>hero-render.webp</strong> (420 KB · Web ready)</span>
        <span class="out-badge">-82% Smaller</span>
      </div>
      <div class="output-row">
        <span>✓ <strong>merged-portfolio.pdf</strong> (Single combined multi-page document)</span>
        <span class="out-badge">Combined</span>
      </div>
      <div class="output-row">
        <span>✓ <strong>Document_Transcode.docx ➔ PDF</strong> (Offline CoreGraphics engine)</span>
        <span class="out-badge">Instant</span>
      </div>
      <div class="output-row">
        <span>✓ <strong>Archive_Assets.zip</strong> (In-place multi-threaded compression)</span>
        <span class="out-badge">Native</span>
      </div>
    </div>
  </div>

  <!-- Bottom CTA -->
  <div class="story-footer-block">
    <div class="story-link-sticker">
      <div class="sticker-left">
        <div class="sticker-icon-circle">{SVG_LINK}</div>
        <div class="sticker-text-group">
          <span class="sticker-title">Download Pathway for macOS</span>
          <span class="sticker-sub">Zero cloud uploads · 100% On-Device</span>
        </div>
      </div>
      <div class="sticker-pill">
        <span>Link in Bio</span>
        <span>→</span>
      </div>
    </div>
    <div class="story-sub-meta">
      <span>CoreGraphics & ImageIO</span>
      <span class="meta-dot"></span>
      <span>Private & Offline</span>
      <span class="meta-dot"></span>
      <span>Swipe to download →</span>
    </div>
  </div>
</body>
</html>"""
    render_story(html, "story-5-conversions")


# =============================================================
# STORY 6: DOWNLOAD CALL TO ACTION (REFINED BALANCED CARD)
# =============================================================
def generate_story_6():
    prog = get_progress_bars(5)
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  {SHARED_STORY_CSS}
  .stage-download-card {{
    flex: 1;
    background: #ffffff;
    border-radius: 24px;
    border: 1px solid rgba(0,0,0,0.08);
    box-shadow: 0 30px 80px rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
    padding: 38px;
    max-height: 1060px;
    text-align: center;
  }}
  .app-icon-large {{
    width: 120px;
    height: 120px;
    border-radius: 28px;
    box-shadow: 0 18px 45px rgba(0,0,0,0.12);
  }}
  .specs-matrix {{
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
    width: 100%;
  }}
  .spec-box {{
    background: #f8fafc;
    border: 1px solid #eef2f6;
    border-radius: 16px;
    padding: 20px 16px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 6px;
  }}
  .spec-value {{
    font-size: 24px;
    font-weight: 700;
    color: #121316;
    letter-spacing: -0.02em;
  }}
  .spec-label {{
    font-size: 13px;
    color: #64748b;
  }}
  .features-checklist {{
    width: 100%;
    background: #fafbfd;
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    padding: 16px 20px;
    display: flex;
    flex-direction: column;
    gap: 8px;
    text-align: left;
  }}
  .check-item {{
    font-size: 14px;
    color: #334155;
    display: flex;
    align-items: center;
    gap: 10px;
  }}
  .download-hero-btn {{
    width: 100%;
    height: 76px;
    background: #121316;
    border-radius: 20px;
    color: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 14px;
    font-size: 20px;
    font-weight: 700;
    box-shadow: 0 16px 36px rgba(0,0,0,0.16);
  }}
</style>
</head>
<body>
  <div class="story-progress-row">{prog}</div>

  <div class="story-top-nav">
    <div class="app-identity">
      <img src="{ICON_B64}" class="app-icon-img" alt="Pathway">
      <div class="app-name-wrap">
        <span class="app-name">Pathway</span>
        <span class="app-subtitle">macOS 14 Sonoma & macOS 15 Sequoia</span>
      </div>
    </div>
    <span class="story-pill-tag">Story 6 / 6</span>
  </div>

  <div class="story-headline-block" style="text-align:center;">
    <div class="story-eyebrow eyebrow-blue" style="margin:0 auto 12px auto;">100% FREE & OPEN SOURCE</div>
    <h1 class="story-title">Feel at home on your Mac today.</h1>
    <p class="story-desc" style="margin:0 auto;">
      Download Pathway now. No subscriptions, no ads, no telemetry, and zero bloat.
    </p>
  </div>

  <!-- Download Center Stage Card -->
  <div class="stage-download-card">
    <div style="display:flex; flex-direction:column; align-items:center; gap:12px;">
      <img src="{ICON_B64}" class="app-icon-large" alt="Pathway App Icon">
      <h2 style="font-size:26px; font-weight:700; letter-spacing:-0.03em;">Pathway for Mac</h2>
      <p style="font-size:15px; color:#64748b;">The file manager your Mac was missing</p>
    </div>

    <div class="specs-matrix">
      <div class="spec-box">
        <span class="spec-value">1.8 MB</span>
        <span class="spec-label">Ultra-Lightweight Universal Binary</span>
      </div>
      <div class="spec-box">
        <span class="spec-value">No Jail</span>
        <span class="spec-label">Direct Root & Volume Access</span>
      </div>
      <div class="spec-box">
        <span class="spec-value">120 FPS</span>
        <span class="spec-label">Fluid ProMotion SwiftUI</span>
      </div>
      <div class="spec-box">
        <span class="spec-value">100% Free</span>
        <span class="spec-label">Public GitHub Release</span>
      </div>
    </div>

    <div class="features-checklist">
      <div class="check-item"><span style="color:#059669; font-weight:bold;">✓</span> <span>Enter opens files, F2 inline renames with extension protection</span></div>
      <div class="check-item"><span style="color:#059669; font-weight:bold;">✓</span> <span>Real recursive folder sizes calculated in Swift 6 background actor</span></div>
      <div class="check-item"><span style="color:#059669; font-weight:bold;">✓</span> <span>True Cut & Paste (⌘X / Ctrl+X) with atomic undo (⌘Z)</span></div>
      <div class="check-item"><span style="color:#059669; font-weight:bold;">✓</span> <span>Context menu conversions to JPEG, PNG, WebP, HEIC, and PDF</span></div>
    </div>

    <div class="download-hero-btn">
      <span>{SVG_DOWNLOAD}</span>
      <span>Download Pathway (Pathway-1.0.0.dmg)</span>
    </div>
  </div>

  <!-- Bottom CTA -->
  <div class="story-footer-block">
    <div class="story-link-sticker">
      <div class="sticker-left">
        <div class="sticker-icon-circle">{SVG_LINK}</div>
        <div class="sticker-text-group">
          <span class="sticker-title">Tap Link in Bio to Download</span>
          <span class="sticker-sub">github.com/GopiKrishnaRakesh/indiesuite-mac</span>
        </div>
      </div>
      <div class="sticker-pill">
        <span>Link in Bio</span>
        <span>🔗</span>
      </div>
    </div>
    <div class="story-sub-meta">
      <span>Apple Silicon (M1–M4) & Intel Supported</span>
      <span class="meta-dot"></span>
      <span>macOS 14+</span>
    </div>
  </div>
</body>
</html>"""
    render_story(html, "story-6-download")


if __name__ == "__main__":
    print("Generating 6 Instagram Story Carousel Renders (1080x1920)...")
    generate_story_1()
    generate_story_2()
    generate_story_3()
    generate_story_4()
    generate_story_5()
    generate_story_6()
    print("\n✓ All 6 Instagram Stories rendered successfully into website/assets/instagram/stories/!")
