#!/usr/bin/env python3
"""
Generates pixel-perfect, 100% realistic developer-grade product renders for Pathway.
Renders authentic macOS UI components, window chrome, and MacBook hardware mockups
using Google Chrome headless at 2x Retina resolution.
"""

import os
import subprocess
import base64
from PIL import Image

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(SCRIPT_DIR)
ASSETS_DIR = os.path.join(PROJECT_DIR, "website", "assets")
TMP_DIR = "/tmp/pathway_renders"
os.makedirs(TMP_DIR, exist_ok=True)

CHROME_BIN = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Read app icon as base64
icon_path = os.path.join(ASSETS_DIR, "app-icon.png")
with open(icon_path, "rb") as f:
    ICON_B64 = "data:image/png;base64," + base64.b64encode(f.read()).decode("utf-8")

def render_html_to_image(html_content, output_name, width, height, target_w, target_h):
    html_file = os.path.join(TMP_DIR, f"{output_name}.html")
    png_file = os.path.join(TMP_DIR, f"{output_name}.png")
    jpg_dest = os.path.join(ASSETS_DIR, f"{output_name}.jpg")

    with open(html_file, "w", encoding="utf-8") as f:
        f.write(html_content)

    cmd = [
        CHROME_BIN,
        "--headless",
        "--disable-gpu",
        "--force-device-scale-factor=2",
        f"--window-size={width},{height}",
        f"--screenshot={png_file}",
        f"file://{html_file}"
    ]
    subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    # Load PNG, convert to RGB JPG with high quality
    img = Image.open(png_file)
    img = img.convert("RGB")
    if target_w > 0 and target_h > 0 and (img.width != target_w or img.height != target_h):
        img = img.resize((target_w, target_h), Image.Resampling.LANCZOS)
    img.save(jpg_dest, "JPEG", quality=95, optimize=True)
    print(f"✓ Rendered {output_name}.jpg ({img.width}x{img.height}) -> {jpg_dest}")

# -------------------------------------------------------------
# SVG Icons helper
# -------------------------------------------------------------
SVG_FOLDER = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#007aff"><path d="M20 18c0 1.1-.9 2-2 2H6c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2h4l2 2h6c1.1 0 2 .9 2 2v10z"/></svg>"""
SVG_SWIFT = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#f05138"><path d="M20.9 14.8c-.8 2-2.3 3.6-4.3 4.8 2.2-.6 4-1.9 5.3-3.6-1 2.3-2.9 4-5.3 4.9 3.5-.7 6.4-3.1 7.4-6.6-1.5 1.5-3.3 2.5-5.3 3 1.9-1.2 3.4-3 4.2-5.1-1.2 1.3-2.7 2.2-4.3 2.7 1.8-1.7 2.9-4 3.1-6.6-.7 1.2-1.6 2.3-2.7 3.2C18 7.3 16 4.3 12.9 2c1.7 2.8 2.1 5.9 1.2 8.7-1.1-1.3-2.5-2.2-4.1-2.7 2.2 2.6 2.8 6.1 1.7 9.1-1.9-2.1-3-4.9-3.2-7.8-.8 1.4-1.2 3-1.2 4.7 0 5.4 4.4 9.8 9.8 9.8 3.5 0 6.6-1.8 8.4-4.6-1.6.4-3.1.2-4.6-.6z"/></svg>"""
SVG_DOC = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#5ac8fa"><path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z"/></svg>"""
SVG_IMAGE = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#34c759"><path d="M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zM8.5 13.5l2.5 3.01L14.5 12l4.5 6H5l3.5-4.5z"/></svg>"""
SVG_ZIP = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#ff9500"><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 6h-2V7h2v2zm0 4h-2v-2h2v2zm-2 2h2v2h-2v-2zm-2-6h2V7h-2v2zm0 4h2v-2h-2v2zm0 4h2v-2h-2v2z"/></svg>"""
SVG_DMG = """<svg width="18" height="18" viewBox="0 0 24 24" fill="#af52de"><path d="M2 20h20v-4H2v4zm2-3h2v2H4v-2zM2 4v4h20V4H2zm4 3H4V5h2v2zm-4 7h20v-4H2v4zm2-3h2v2H4v-2z"/></svg>"""

# =============================================================
# 1. HERO MACBOOK PRO RENDER
# =============================================================
def generate_hero_macbook():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    width: 2400px;
    height: 1400px;
    background: radial-gradient(circle at 50% 35%, #ffffff 0%, #f4f5f8 60%, #e8ebf0 100%);
    font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Inter", sans-serif;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    color: #1d1d1f;
  }}

  /* Top developer highlight badge */
  .badge-header {{
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 10px 24px;
    background: #ffffff;
    border: 1px solid rgba(0,0,0,0.08);
    border-radius: 999px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.04);
    margin-bottom: 34px;
  }}
  .badge-header img {{ width: 22px; height: 22px; border-radius: 5px; }}
  .badge-title {{ font-size: 15px; font-weight: 600; color: #1d1d1f; letter-spacing: -0.01em; }}
  .badge-sep {{ color: #d1d5db; }}
  .badge-pill {{
    background: #eef2ff;
    color: #4f46e5;
    font-size: 12px;
    font-weight: 600;
    padding: 3px 10px;
    border-radius: 999px;
  }}

  /* Floating callouts left & right */
  .scene-container {{
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
  }}
  .floating-callout {{
    position: absolute;
    background: rgba(255, 255, 255, 0.94);
    backdrop-filter: blur(20px);
    border: 1px solid rgba(0, 0, 0, 0.08);
    border-radius: 14px;
    padding: 14px 20px;
    box-shadow: 0 16px 36px rgba(0, 0, 0, 0.08), 0 2px 6px rgba(0,0,0,0.04);
    display: flex;
    align-items: center;
    gap: 14px;
    z-index: 10;
  }}
  .callout-left-1 {{ top: 120px; left: -140px; }}
  .callout-left-2 {{ bottom: 180px; left: -110px; }}
  .callout-right-1 {{ top: 140px; right: -130px; }}
  .callout-right-2 {{ bottom: 200px; right: -100px; }}
  
  .callout-icon {{
    width: 38px;
    height: 38px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
  }}
  .callout-text h4 {{ font-size: 14px; font-weight: 600; color: #111827; }}
  .callout-text p {{ font-size: 12px; color: #6b7280; margin-top: 2px; }}

  /* MacBook Hardware Mockup */
  .macbook {{
    width: 1720px;
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
  }}

  /* Screen Lid */
  .macbook-lid {{
    width: 1600px;
    height: 1010px;
    background: #080809;
    border-radius: 26px 26px 0 0;
    padding: 14px 14px 0 14px;
    box-shadow: 0 0 0 2px #262729, 0 30px 80px rgba(0, 0, 0, 0.25);
    position: relative;
  }}

  /* Camera notch */
  .camera-notch {{
    position: absolute;
    top: 14px;
    left: 50%;
    transform: translateX(-50%);
    width: 170px;
    height: 24px;
    background: #080809;
    border-radius: 0 0 12px 12px;
    z-index: 50;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
  }}
  .camera-lens {{
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: radial-gradient(circle at 35% 35%, #2a3b5c, #070b14);
    box-shadow: inset 0 0 2px rgba(255,255,255,0.4);
  }}
  .camera-led {{
    width: 4px;
    height: 4px;
    border-radius: 50%;
    background: #111;
  }}

  /* Liquid Retina Screen */
  .macbook-screen {{
    width: 100%;
    height: 996px;
    background: #f1f2f6;
    border-radius: 14px 14px 0 0;
    overflow: hidden;
    position: relative;
    display: flex;
    flex-direction: column;
  }}

  /* macOS Menu Bar */
  .macos-menubar {{
    height: 28px;
    background: rgba(255, 255, 255, 0.85);
    backdrop-filter: blur(25px);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 18px;
    font-size: 13px;
    font-weight: 500;
    color: #1d1d1f;
    border-bottom: 1px solid rgba(0,0,0,0.06);
    z-index: 40;
  }}
  .menu-left {{ display: flex; align-items: center; gap: 18px; }}
  .menu-left .apple-logo {{ font-size: 15px; font-weight: 600; margin-right: -4px; }}
  .menu-left .app-name {{ font-weight: 600; }}
  .menu-right {{ display: flex; align-items: center; gap: 14px; font-size: 12px; color: #4b5563; }}

  /* Screen Wallpaper / Content Area */
  .screen-desktop {{
    flex: 1;
    background: radial-gradient(circle at 50% 30%, #fbfbfc 0%, #e9edf4 100%);
    padding: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
  }}

  /* Pathway Native Window */
  .pathway-window {{
    width: 1460px;
    height: 870px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 25px 70px rgba(0, 0, 0, 0.18), 0 0 0 1px rgba(0, 0, 0, 0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }}

  /* Window Titlebar */
  .win-titlebar {{
    height: 48px;
    background: #f7f7f9;
    border-bottom: 1px solid #e5e7eb;
    display: flex;
    align-items: center;
    padding: 0 16px;
    justify-content: space-between;
  }}
  .traffic-lights {{ display: flex; gap: 8px; }}
  .traffic-dot {{ width: 12px; height: 12px; border-radius: 50%; }}
  .dot-red {{ background: #ff5f56; border: 1px solid #e0443e; }}
  .dot-yellow {{ background: #ffbd2e; border: 1px solid #dea123; }}
  .dot-green {{ background: #27c93f; border: 1px solid #1aab29; }}

  .win-title {{
    font-size: 13px;
    font-weight: 600;
    color: #374151;
    display: flex;
    align-items: center;
    gap: 8px;
  }}
  .win-title img {{ width: 16px; height: 16px; border-radius: 3px; }}

  .win-search {{
    display: flex;
    align-items: center;
    gap: 8px;
    background: #ffffff;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 5px 12px;
    font-size: 12px;
    color: #9ca3af;
    width: 220px;
  }}

  /* Breadcrumb Address Bar */
  .breadcrumb-bar {{
    height: 38px;
    background: #ffffff;
    border-bottom: 1px solid #f0f0f2;
    display: flex;
    align-items: center;
    padding: 0 16px;
    gap: 10px;
    font-size: 13px;
  }}
  .nav-btns {{ display: flex; gap: 4px; color: #4b5563; font-weight: 600; }}
  .nav-btn {{
    width: 26px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 4px;
    cursor: default;
  }}
  .nav-btn:hover {{ background: #f3f4f6; }}
  .path-capsule {{
    flex: 1;
    display: flex;
    align-items: center;
    background: #f9fafb;
    border: 1px solid #e5e7eb;
    border-radius: 6px;
    height: 28px;
    padding: 0 10px;
    gap: 6px;
    color: #4b5563;
    font-size: 12px;
  }}
  .path-seg {{ font-weight: 500; color: #1f2937; }}
  .path-arrow {{ color: #9ca3af; font-size: 10px; }}

  /* Command Bar (Explorer Ribbon) */
  .command-bar {{
    height: 44px;
    background: #fafbfc;
    border-bottom: 1px solid #e5e7eb;
    display: flex;
    align-items: center;
    padding: 0 14px;
    gap: 6px;
    font-size: 12px;
    font-weight: 500;
    color: #374151;
  }}
  .cmd-btn {{
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 6px 10px;
    border-radius: 6px;
    background: transparent;
    border: 1px solid transparent;
  }}
  .cmd-btn.highlight {{
    background: #eef2ff;
    border-color: #c7d2fe;
    color: #4338ca;
  }}
  .cmd-btn:hover {{ background: #f3f4f6; }}
  .cmd-divider {{ width: 1px; height: 22px; background: #e5e7eb; margin: 0 6px; }}
  .cmd-badge {{
    background: #e0e7ff;
    color: #3730a3;
    font-size: 10px;
    padding: 1px 5px;
    border-radius: 4px;
    font-weight: 600;
  }}

  /* Main Two-Pane View */
  .win-body {{
    flex: 1;
    display: flex;
    overflow: hidden;
  }}

  /* Sidebar */
  .win-sidebar {{
    width: 220px;
    background: #f8fafc;
    border-right: 1px solid #e5e7eb;
    padding: 16px 12px;
    display: flex;
    flex-direction: column;
    gap: 18px;
  }}
  .sb-section-title {{
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #9ca3af;
    padding-left: 8px;
    margin-bottom: 6px;
  }}
  .sb-item {{
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 6px 8px;
    border-radius: 6px;
    font-size: 13px;
    color: #4b5563;
    font-weight: 500;
  }}
  .sb-item.active {{
    background: #e0e7ff;
    color: #3730a3;
    font-weight: 600;
  }}

  /* Content Table */
  .win-content {{
    flex: 1;
    display: flex;
    flex-direction: column;
    background: #ffffff;
  }}
  .details-header {{
    display: grid;
    grid-template-columns: 360px 170px 170px 140px 1fr;
    padding: 8px 16px;
    font-size: 11px;
    font-weight: 600;
    color: #6b7280;
    border-bottom: 1px solid #e5e7eb;
    background: #fafbfc;
  }}
  .details-row {{
    display: grid;
    grid-template-columns: 360px 170px 170px 140px 1fr;
    padding: 10px 16px;
    font-size: 13px;
    color: #1f2937;
    border-bottom: 1px solid #f3f4f6;
    align-items: center;
  }}
  .details-row.selected {{
    background: #eff6ff;
  }}
  .file-col {{
    display: flex;
    align-items: center;
    gap: 10px;
    font-weight: 500;
  }}
  .size-calc-tag {{
    font-weight: 600;
    color: #059669;
    background: #ecfdf5;
    padding: 2px 7px;
    border-radius: 4px;
    font-size: 11px;
    display: inline-flex;
    align-items: center;
    gap: 4px;
  }}
  .group-header {{
    padding: 10px 16px 6px;
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.04em;
    color: #4b5563;
    background: #f9fafb;
    border-bottom: 1px solid #f0f0f2;
    display: flex;
    align-items: center;
    gap: 6px;
  }}

  /* Status Bar */
  .win-statusbar {{
    height: 28px;
    background: #f9fafb;
    border-top: 1px solid #e5e7eb;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 16px;
    font-size: 11px;
    color: #6b7280;
  }}

  /* Laptop Base & Keyboard Well */
  .macbook-base {{
    width: 1720px;
    height: 24px;
    background: #1e1e20;
    border-radius: 0 0 24px 24px;
    box-shadow: 0 18px 40px rgba(0, 0, 0, 0.45);
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
  }}
  .macbook-notch-handle {{
    width: 140px;
    height: 7px;
    background: #2c2d30;
    border-radius: 0 0 6px 6px;
  }}
  .macbook-shadow {{
    width: 1620px;
    height: 30px;
    background: radial-gradient(ellipse at 50% 50%, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0) 70%);
    margin-top: 4px;
  }}
</style>
</head>
<body>

  <div class="badge-header">
    <img src="{ICON_B64}" alt="Pathway">
    <span class="badge-title">Pathway for macOS</span>
    <span class="badge-sep">•</span>
    <span style="font-size: 13px; color: #4b5563;">Windows Muscle Memory · 100% Native Swift</span>
    <span class="badge-pill">v1.0.0 Universal</span>
  </div>

  <div class="scene-container">
    <!-- Floating developer callout badges -->
    <div class="floating-callout callout-left-1">
      <div class="callout-icon" style="background: #eef2ff; color: #4f46e5;">⚡️</div>
      <div class="callout-text">
        <h4>Real Folder Sizes in List View</h4>
        <p>Swift 6 background actor calculates byte weight off-thread</p>
      </div>
    </div>

    <div class="floating-callout callout-left-2">
      <div class="callout-icon" style="background: #ecfdf5; color: #059669;">↵</div>
      <div class="callout-text">
        <h4>Enter to Open · F2 to Rename</h4>
        <p>No more accidental renaming when launching files</p>
      </div>
    </div>

    <div class="floating-callout callout-right-1">
      <div class="callout-icon" style="background: #eff6ff; color: #2563eb;">✂️</div>
      <div class="callout-text">
        <h4>Ctrl+X / ⌘X Native Cut & Paste</h4>
        <p>Atomic file moves with multi-level Undo & Redo</p>
      </div>
    </div>

    <div class="floating-callout callout-right-2">
      <div class="callout-icon" style="background: #fdf2f8; color: #db2777;">🪄</div>
      <div class="callout-text">
        <h4>Right-Click Batch Conversions</h4>
        <p>Convert images to PNG/JPEG & docs to PDF in 1 click</p>
      </div>
    </div>

    <!-- MacBook Mockup -->
    <div class="macbook">
      <div class="macbook-lid">
        <div class="camera-notch">
          <div class="camera-lens"></div>
          <div class="camera-led"></div>
        </div>

        <div class="macbook-screen">
          <!-- macOS Menubar -->
          <div class="macos-menubar">
            <div class="menu-left">
              <span class="apple-logo"></span>
              <span class="app-name">Pathway</span>
              <span>File</span>
              <span>Edit</span>
              <span>View</span>
              <span>Go</span>
              <span>Window</span>
              <span>Help</span>
            </div>
            <div class="menu-right">
              <span>94%</span>
              <span>Wi-Fi</span>
              <span>Sun Sep 27</span>
              <span>18:50</span>
            </div>
          </div>

          <!-- Desktop Workspace with Pathway App -->
          <div class="screen-desktop">
            <div class="pathway-window">
              <!-- Window Chrome -->
              <div class="win-titlebar">
                <div class="traffic-lights">
                  <div class="traffic-dot dot-red"></div>
                  <div class="traffic-dot dot-yellow"></div>
                  <div class="traffic-dot dot-green"></div>
                </div>
                <div class="win-title">
                  <img src="{ICON_B64}" alt="Pathway">
                  <span>Pathway — file manager</span>
                </div>
                <div class="win-search">
                  <span>🔍</span>
                  <span>Search file manager...</span>
                  <span style="margin-left: auto; font-size: 10px; background: #f3f4f6; padding: 1px 4px; border-radius: 3px;">⌘F</span>
                </div>
              </div>

              <!-- Breadcrumb Address Bar -->
              <div class="breadcrumb-bar">
                <div class="nav-btns">
                  <span class="nav-btn">◀</span>
                  <span class="nav-btn">▶</span>
                  <span class="nav-btn">▲</span>
                  <span class="nav-btn">⟳</span>
                </div>
                <div class="path-capsule">
                  <span class="path-seg">This PC</span>
                  <span class="path-arrow">›</span>
                  <span class="path-seg">Macintosh HD</span>
                  <span class="path-arrow">›</span>
                  <span class="path-seg">Users</span>
                  <span class="path-arrow">›</span>
                  <span class="path-seg">developer</span>
                  <span class="path-arrow">›</span>
                  <span class="path-seg">indiesuite-mac</span>
                  <span class="path-arrow">›</span>
                  <span class="path-seg" style="font-weight: 700; color: #111827;">file manager</span>
                </div>
              </div>

              <!-- Command Bar Ribbon -->
              <div class="command-bar">
                <div class="cmd-btn"><span>➕</span><span>New</span><span>▾</span></div>
                <div class="cmd-divider"></div>
                <div class="cmd-btn"><span>✂️</span><span>Cut (⌘X)</span></div>
                <div class="cmd-btn"><span>📋</span><span>Copy (⌘C)</span></div>
                <div class="cmd-btn"><span>📥</span><span>Paste (⌘V)</span></div>
                <div class="cmd-btn"><span>✏️</span><span>Rename</span><span class="cmd-badge">F2</span></div>
                <div class="cmd-btn"><span>🗑</span><span>Delete</span></div>
                <div class="cmd-divider"></div>
                <div class="cmd-btn highlight"><span>↕️</span><span>Sort: Size (Desc) ▾</span></div>
                <div class="cmd-btn highlight"><span>🗂</span><span>Group: Type ▾</span></div>
                <div class="cmd-divider"></div>
                <div class="cmd-btn"><span>☷</span><span>Details ▾</span></div>
              </div>

              <!-- Two pane container -->
              <div class="win-body">
                <!-- Sidebar -->
                <div class="win-sidebar">
                  <div>
                    <div class="sb-section-title">Quick Access</div>
                    <div class="sb-item"><span>💻</span><span>Desktop</span></div>
                    <div class="sb-item"><span>📄</span><span>Documents</span></div>
                    <div class="sb-item"><span>📥</span><span>Downloads</span></div>
                    <div class="sb-item active"><span>📂</span><span>Projects</span></div>
                  </div>
                  <div>
                    <div class="sb-section-title">Storage Devices</div>
                    <div class="sb-item"><span>💾</span><span>Macintosh HD</span></div>
                    <div class="sb-item"><span>🔌</span><span>Samsung T7 (2 TB)</span></div>
                  </div>
                  <div>
                    <div class="sb-section-title">Tags</div>
                    <div class="sb-item"><span style="color: #ef4444;">●</span><span>Work</span></div>
                    <div class="sb-item"><span style="color: #10b981;">●</span><span>Production</span></div>
                    <div class="sb-item"><span style="color: #3b82f6;">●</span><span>Current Sprint</span></div>
                  </div>
                </div>

                <!-- Main File Table -->
                <div class="win-content">
                  <div class="details-header">
                    <div>Name</div>
                    <div>Date modified</div>
                    <div>Type</div>
                    <div>Size</div>
                    <div>Status</div>
                  </div>

                  <!-- Group: Folders -->
                  <div class="group-header">
                    <span>▼</span>
                    <span>Folders (4 items)</span>
                  </div>

                  <div class="details-row selected">
                    <div class="file-col">
                      {SVG_FOLDER}
                      <span style="font-weight: 600;">DerivedData</span>
                    </div>
                    <div>Today, 18:30</div>
                    <div>Folder</div>
                    <div><span class="size-calc-tag">✓ 1.84 GB</span></div>
                    <div style="font-size: 11px; color: #059669;">Calculated</div>
                  </div>

                  <div class="details-row">
                    <div class="file-col">
                      {SVG_FOLDER}
                      <span>node_modules</span>
                    </div>
                    <div>Today, 17:15</div>
                    <div>Folder</div>
                    <div><span class="size-calc-tag">✓ 418.2 MB</span></div>
                    <div style="font-size: 11px; color: #059669;">Calculated</div>
                  </div>

                  <div class="details-row">
                    <div class="file-col">
                      {SVG_FOLDER}
                      <span>Sources</span>
                    </div>
                    <div>Today, 18:48</div>
                    <div>Folder</div>
                    <div><span class="size-calc-tag">✓ 148 KB</span></div>
                    <div style="font-size: 11px; color: #059669;">Calculated</div>
                  </div>

                  <div class="details-row">
                    <div class="file-col">
                      {SVG_FOLDER}
                      <span>Tests</span>
                    </div>
                    <div>Today, 17:30</div>
                    <div>Folder</div>
                    <div><span class="size-calc-tag">✓ 48 KB</span></div>
                    <div style="font-size: 11px; color: #059669;">Calculated</div>
                  </div>

                  <!-- Group: Swift Sources -->
                  <div class="group-header">
                    <span>▼</span>
                    <span>Swift Source Files (3 items)</span>
                  </div>

                  <div class="details-row">
                    <div class="file-col">
                      {SVG_SWIFT}
                      <span>FolderSizeCalculator.swift</span>
                    </div>
                    <div>Today, 17:15</div>
                    <div>Swift Source</div>
                    <div>14.2 KB</div>
                    <div style="font-size: 11px; color: #6b7280;">Ready</div>
                  </div>

                  <div class="details-row">
                    <div class="file-col">
                      {SVG_SWIFT}
                      <span>FileBrowserModel.swift</span>
                    </div>
                    <div>Today, 18:40</div>
                    <div>Swift Source</div>
                    <div>32.8 KB</div>
                    <div style="font-size: 11px; color: #6b7280;">Ready</div>
                  </div>

                  <div class="details-row">
                    <div class="file-col">
                      {SVG_SWIFT}
                      <span>CommandBar.swift</span>
                    </div>
                    <div>Today, 16:10</div>
                    <div>Swift Source</div>
                    <div>8.3 KB</div>
                    <div style="font-size: 11px; color: #6b7280;">Ready</div>
                  </div>

                  <!-- Group: Distributables -->
                  <div class="group-header">
                    <span>▼</span>
                    <span>Installers & Scripts (2 items)</span>
                  </div>

                  <div class="details-row">
                    <div class="file-col">
                      {SVG_DMG}
                      <span>Pathway-1.0.0.dmg</span>
                    </div>
                    <div>Today, 17:45</div>
                    <div>Apple Disk Image</div>
                    <div>1.8 MB</div>
                    <div style="font-size: 11px; color: #2563eb;">Universal Binary</div>
                  </div>

                  <div class="details-row">
                    <div class="file-col">
                      {SVG_DOC}
                      <span>install.sh</span>
                    </div>
                    <div>Today, 18:10</div>
                    <div>Shell Script</div>
                    <div>4.2 KB</div>
                    <div style="font-size: 11px; color: #6b7280;">Executable</div>
                  </div>

                </div>
              </div>

              <!-- Status Bar -->
              <div class="win-statusbar">
                <span>9 items in folder · 1 item selected (1.84 GB)</span>
                <span style="color: #059669; font-weight: 500;">● Real-time folder size calculator active (4 folders calculated)</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Laptop Base -->
      <div class="macbook-base">
        <div class="macbook-notch-handle"></div>
      </div>
      <div class="macbook-shadow"></div>
    </div>
  </div>

</body>
</html>"""
    render_html_to_image(html, "hero-macbook", 2400, 1400, 2400, 1400)


# =============================================================
# 2. FEATURES SHOWCASE RENDER (Folder Sizes & Grouping)
# =============================================================
def generate_features_showcase():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    width: 1600px;
    height: 1050px;
    background: #ffffff;
    font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Inter", sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px;
  }}

  .card-frame {{
    width: 100%;
    height: 100%;
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 18px;
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }}

  /* Window Header */
  .win-header {{
    height: 52px;
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    padding: 0 20px;
    justify-content: space-between;
  }}
  .traffic-lights {{ display: flex; gap: 8px; }}
  .traffic-dot {{ width: 12px; height: 12px; border-radius: 50%; }}
  .dot-red {{ background: #ff5f56; border: 1px solid #e0443e; }}
  .dot-yellow {{ background: #ffbd2e; border: 1px solid #dea123; }}
  .dot-green {{ background: #27c93f; border: 1px solid #1aab29; }}

  .header-title {{
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    display: flex;
    align-items: center;
    gap: 8px;
  }}
  .header-title img {{ width: 18px; height: 18px; border-radius: 4px; }}

  /* Active Toolbar Highlights */
  .toolbar {{
    height: 48px;
    background: #ffffff;
    border-bottom: 1px solid #f1f5f9;
    display: flex;
    align-items: center;
    padding: 0 20px;
    gap: 12px;
    font-size: 13px;
    font-weight: 500;
  }}
  .pill-action {{
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    background: #f1f5f9;
    border-radius: 8px;
    color: #334155;
  }}
  .pill-active {{
    background: #eff6ff;
    color: #2563eb;
    border: 1px solid #bfdbfe;
    font-weight: 600;
  }}

  /* Table */
  .table-header {{
    display: grid;
    grid-template-columns: 460px 220px 220px 180px 1fr;
    padding: 12px 24px;
    font-size: 12px;
    font-weight: 600;
    color: #64748b;
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
  }}
  .sort-indicator {{
    display: inline-flex;
    align-items: center;
    gap: 4px;
    color: #2563eb;
    font-weight: 700;
  }}

  .group-title {{
    padding: 14px 24px 8px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #475569;
    background: #f8fafc;
    border-bottom: 1px solid #f1f5f9;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }}
  .group-badge {{
    font-size: 11px;
    font-weight: 600;
    background: #e2e8f0;
    color: #334155;
    padding: 2px 8px;
    border-radius: 999px;
  }}

  .table-row {{
    display: grid;
    grid-template-columns: 460px 220px 220px 180px 1fr;
    padding: 14px 24px;
    font-size: 14px;
    color: #1e293b;
    border-bottom: 1px solid #f8fafc;
    align-items: center;
  }}
  .table-row.hovered {{ background: #f8fafc; }}
  .table-row.selected {{ background: #eff6ff; }}

  .col-name {{ display: flex; align-items: center; gap: 12px; font-weight: 500; }}
  
  .size-pill-calc {{
    display: inline-flex;
    align-items: center;
    gap: 6px;
    background: #ecfdf5;
    color: #059669;
    padding: 4px 10px;
    border-radius: 6px;
    font-weight: 600;
    font-size: 12px;
    border: 1px solid #a7f3d0;
  }}

  /* Bottom Callout banner inside card */
  .footer-banner {{
    margin-top: auto;
    background: #f8fafc;
    border-top: 1px solid #e2e8f0;
    padding: 16px 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }}
  .banner-left {{ display: flex; align-items: center; gap: 12px; }}
  .banner-icon {{
    width: 32px;
    height: 32px;
    border-radius: 8px;
    background: #ecfdf5;
    color: #059669;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
  }}
  .banner-text h5 {{ font-size: 13px; font-weight: 600; color: #0f172a; }}
  .banner-text p {{ font-size: 12px; color: #64748b; }}
</style>
</head>
<body>

  <div class="card-frame">
    <!-- Header -->
    <div class="win-header">
      <div class="traffic-lights">
        <div class="traffic-dot dot-red"></div>
        <div class="traffic-dot dot-yellow"></div>
        <div class="traffic-dot dot-green"></div>
      </div>
      <div class="header-title">
        <img src="{ICON_B64}" alt="Pathway">
        <span>Pathway — Folder Weights & Grouping</span>
      </div>
      <div style="font-size: 12px; color: #64748b; font-weight: 500;">
        Details View (⌘1)
      </div>
    </div>

    <!-- Active Filter/Grouping Bar -->
    <div class="toolbar">
      <div class="pill-action pill-active">
        <span>↕️</span>
        <span>Sort by: <strong>Size</strong> (Descending ▾)</span>
      </div>
      <div class="pill-action pill-active">
        <span>🗂</span>
        <span>Group by: <strong>Type</strong> ▾</span>
      </div>
      <div class="pill-action">
        <span>👁</span>
        <span>Calculate: <strong>All Folders</strong> ✓</span>
      </div>
      <div style="margin-left: auto; font-size: 12px; color: #64748b;">
        Off-thread Swift Actor · Zero UI Hitch
      </div>
    </div>

    <!-- Table Header -->
    <div class="table-header">
      <div>Name</div>
      <div>Date modified</div>
      <div>Type</div>
      <div class="sort-indicator">Size ▾</div>
      <div>Calculation Status</div>
    </div>

    <!-- Group 1: Folders -->
    <div class="group-title">
      <span>📁 Folders</span>
      <span class="group-badge">4 items · 2.34 GB Total</span>
    </div>

    <div class="table-row selected">
      <div class="col-name">
        {SVG_FOLDER}
        <span style="font-weight: 600;">DerivedData</span>
      </div>
      <div>Today, 18:30</div>
      <div>Folder</div>
      <div><span class="size-pill-calc">✓ 1.84 GB</span></div>
      <div style="color: #059669; font-size: 12px; font-weight: 500;">Cached (14,812 files)</div>
    </div>

    <div class="table-row">
      <div class="col-name">
        {SVG_FOLDER}
        <span>node_modules</span>
      </div>
      <div>Today, 17:15</div>
      <div>Folder</div>
      <div><span class="size-pill-calc">✓ 418.2 MB</span></div>
      <div style="color: #059669; font-size: 12px; font-weight: 500;">Cached (9,240 files)</div>
    </div>

    <div class="table-row">
      <div class="col-name">
        {SVG_FOLDER}
        <span>.git</span>
      </div>
      <div>Today, 09:30</div>
      <div>Folder</div>
      <div><span class="size-pill-calc">✓ 62.8 MB</span></div>
      <div style="color: #059669; font-size: 12px; font-weight: 500;">Cached (412 objects)</div>
    </div>

    <div class="table-row">
      <div class="col-name">
        {SVG_FOLDER}
        <span>Sources</span>
      </div>
      <div>Today, 18:48</div>
      <div>Folder</div>
      <div><span class="size-pill-calc">✓ 148 KB</span></div>
      <div style="color: #059669; font-size: 12px; font-weight: 500;">Cached (18 files)</div>
    </div>

    <!-- Group 2: Swift Source Code -->
    <div class="group-title">
      <span>📄 Swift Source Code</span>
      <span class="group-badge">3 items</span>
    </div>

    <div class="table-row">
      <div class="col-name">
        {SVG_SWIFT}
        <span>FolderSizeCalculator.swift</span>
      </div>
      <div>Today, 17:15</div>
      <div>Swift Source</div>
      <div style="font-weight: 600; color: #334155;">14.2 KB</div>
      <div style="color: #64748b; font-size: 12px;">Swift 6 Actor</div>
    </div>

    <div class="table-row">
      <div class="col-name">
        {SVG_SWIFT}
        <span>FileBrowserModel.swift</span>
      </div>
      <div>Today, 18:40</div>
      <div>Swift Source</div>
      <div style="font-weight: 600; color: #334155;">32.8 KB</div>
      <div style="color: #64748b; font-size: 12px;">Observable Object</div>
    </div>

    <!-- Footer Banner -->
    <div class="footer-banner">
      <div class="banner-left">
        <div class="banner-icon">✓</div>
        <div class="banner-text">
          <h5>Instant Sorting by True Byte Weights</h5>
          <p>Folders are sorted by real contents, not empty default placeholders. Inode mtime cache prevents redundant disk scans.</p>
        </div>
      </div>
      <div style="font-size: 12px; font-weight: 600; color: #2563eb;">
        Pathway Exclusive Feature
      </div>
    </div>
  </div>

</body>
</html>"""
    render_html_to_image(html, "features-showcase", 1600, 1050, 1600, 1050)


# =============================================================
# 3. CONTEXT ACTIONS RENDER (Right Click Conversions & Menu)
# =============================================================
def generate_context_actions():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    width: 1600px;
    height: 1050px;
    background: #ffffff;
    font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Inter", sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px;
  }}

  .card-frame {{
    width: 100%;
    height: 100%;
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 18px;
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    position: relative;
  }}

  /* Window Header */
  .win-header {{
    height: 52px;
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    padding: 0 20px;
    justify-content: space-between;
  }}
  .traffic-lights {{ display: flex; gap: 8px; }}
  .traffic-dot {{ width: 12px; height: 12px; border-radius: 50%; }}
  .dot-red {{ background: #ff5f56; border: 1px solid #e0443e; }}
  .dot-yellow {{ background: #ffbd2e; border: 1px solid #dea123; }}
  .dot-green {{ background: #27c93f; border: 1px solid #1aab29; }}

  .header-title {{
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    display: flex;
    align-items: center;
    gap: 8px;
  }}
  .header-title img {{ width: 18px; height: 18px; border-radius: 4px; }}

  /* Background Grid of items being multi-selected */
  .content-area {{
    flex: 1;
    padding: 30px;
    background: #ffffff;
    position: relative;
  }}

  .file-grid {{
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 24px;
  }}
  .grid-card {{
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    background: #ffffff;
    position: relative;
  }}
  .grid-card.selected {{
    background: #eff6ff;
    border-color: #3b82f6;
    box-shadow: 0 0 0 1px #3b82f6;
  }}
  .grid-thumb {{
    width: 64px;
    height: 64px;
    border-radius: 8px;
    background: #f8fafc;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 12px;
  }}
  .grid-name {{ font-size: 13px; font-weight: 600; color: #1e293b; }}
  .grid-meta {{ font-size: 11px; color: #64748b; margin-top: 4px; }}

  /* Rubber-band Marquee Drag Selection Box */
  .marquee-box {{
    position: absolute;
    top: 20px;
    left: 20px;
    width: 820px;
    height: 380px;
    background: rgba(59, 130, 246, 0.08);
    border: 1.5px dashed #3b82f6;
    border-radius: 6px;
    pointer-events: none;
    z-index: 5;
  }}

  /* Authentic macOS Context Menu */
  .context-menu-container {{
    position: absolute;
    top: 130px;
    left: 480px;
    display: flex;
    gap: 6px;
    z-index: 50;
  }}

  .mac-menu {{
    width: 270px;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(25px);
    border: 1px solid rgba(0, 0, 0, 0.12);
    border-radius: 10px;
    box-shadow: 0 16px 40px rgba(0, 0, 0, 0.2), 0 2px 6px rgba(0,0,0,0.05);
    padding: 6px;
    font-size: 13px;
    color: #1e293b;
    display: flex;
    flex-direction: column;
    gap: 2px;
  }}

  .menu-item {{
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 6px 10px;
    border-radius: 6px;
    cursor: default;
    font-weight: 450;
  }}
  .menu-item:hover, .menu-item.active {{
    background: #007aff;
    color: #ffffff;
  }}
  .menu-item:hover .menu-shortcut, .menu-item.active .menu-shortcut {{
    color: rgba(255, 255, 255, 0.8);
  }}
  .menu-item-left {{
    display: flex;
    align-items: center;
    gap: 8px;
  }}
  .menu-shortcut {{
    font-size: 11px;
    color: #64748b;
  }}
  .menu-sep {{
    height: 1px;
    background: #e2e8f0;
    margin: 4px 6px;
  }}

  /* Submenu */
  .mac-submenu {{
    width: 250px;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(25px);
    border: 1px solid rgba(0, 0, 0, 0.12);
    border-radius: 10px;
    box-shadow: 0 16px 40px rgba(0, 0, 0, 0.2);
    padding: 6px;
    font-size: 13px;
    color: #1e293b;
    display: flex;
    flex-direction: column;
    gap: 2px;
    margin-top: 100px;
  }}

  /* Explanatory Bottom Bar */
  .footer-callout {{
    background: #f8fafc;
    border-top: 1px solid #e2e8f0;
    padding: 18px 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    z-index: 10;
  }}
  .footer-callout h4 {{ font-size: 14px; font-weight: 600; color: #0f172a; }}
  .footer-callout p {{ font-size: 12px; color: #64748b; margin-top: 2px; }}
</style>
</head>
<body>

  <div class="card-frame">
    <!-- Header -->
    <div class="win-header">
      <div class="traffic-lights">
        <div class="traffic-dot dot-red"></div>
        <div class="traffic-dot dot-yellow"></div>
        <div class="traffic-dot dot-green"></div>
      </div>
      <div class="header-title">
        <img src="{ICON_B64}" alt="Pathway">
        <span>Pathway — Context Actions & Batch Conversion</span>
      </div>
      <div style="font-size: 12px; color: #64748b;">
        3 Items Selected (Marquee Drag)
      </div>
    </div>

    <!-- Main Content Area -->
    <div class="content-area">
      <!-- Drag Marquee Selection Box -->
      <div class="marquee-box"></div>

      <!-- File Grid -->
      <div class="file-grid">
        <div class="grid-card selected">
          <div class="grid-thumb" style="background: #e0f2fe;">{SVG_IMAGE}</div>
          <div class="grid-name">hero-macbook.png</div>
          <div class="grid-meta">PNG · 2.4 MB · 2400×1400</div>
        </div>

        <div class="grid-card selected">
          <div class="grid-thumb" style="background: #e0f2fe;">{SVG_IMAGE}</div>
          <div class="grid-name">features-showcase.png</div>
          <div class="grid-meta">PNG · 1.8 MB · 1600×1050</div>
        </div>

        <div class="grid-card selected">
          <div class="grid-thumb" style="background: #e0f2fe;">{SVG_IMAGE}</div>
          <div class="grid-name">context-actions.png</div>
          <div class="grid-meta">PNG · 1.5 MB · 1600×1050</div>
        </div>

        <div class="grid-card">
          <div class="grid-thumb">{SVG_DOC}</div>
          <div class="grid-name">README.md</div>
          <div class="grid-meta">Markdown · 8 KB</div>
        </div>
      </div>

      <!-- Context Menu Float -->
      <div class="context-menu-container">
        <!-- Main Context Menu -->
        <div class="mac-menu">
          <div class="menu-item">
            <span class="menu-item-left"><span>↗</span><span>Open</span></span>
            <span class="menu-shortcut">↵ Enter</span>
          </div>
          <div class="menu-item">
            <span class="menu-item-left"><span>✂️</span><span>Cut</span></span>
            <span class="menu-shortcut">⌘X / Ctrl+X</span>
          </div>
          <div class="menu-item">
            <span class="menu-item-left"><span>📋</span><span>Copy</span></span>
            <span class="menu-shortcut">⌘C / Ctrl+C</span>
          </div>
          <div class="menu-item">
            <span class="menu-item-left"><span>✏️</span><span>Rename</span></span>
            <span class="menu-shortcut">F2</span>
          </div>
          <div class="menu-sep"></div>
          <div class="menu-item">
            <span class="menu-item-left"><span>📦</span><span>Compress to ZIP</span></span>
          </div>
          <div class="menu-item">
            <span class="menu-item-left"><span>🗜</span><span>Compress to TAR.GZ</span></span>
          </div>
          <div class="menu-item active">
            <span class="menu-item-left"><span>🖼</span><span>Convert Images (3 items)</span></span>
            <span>▸</span>
          </div>
          <div class="menu-item">
            <span class="menu-item-left"><span>📄</span><span>Convert Documents</span></span>
            <span>▸</span>
          </div>
          <div class="menu-sep"></div>
          <div class="menu-item">
            <span class="menu-item-left"><span>🔗</span><span>Copy Full Path</span></span>
            <span class="menu-shortcut">⌥⌘C</span>
          </div>
          <div class="menu-item">
            <span class="menu-item-left"><span>🗑</span><span>Move to Trash</span></span>
            <span class="menu-shortcut">Delete</span>
          </div>
        </div>

        <!-- Submenu for Image Conversions -->
        <div class="mac-submenu">
          <div class="menu-item active">
            <span>Convert to JPEG (Quality 90%)</span>
          </div>
          <div class="menu-item">
            <span>Convert to PNG (Lossless)</span>
          </div>
          <div class="menu-item">
            <span>Convert to HEIC (High Efficiency)</span>
          </div>
          <div class="menu-item">
            <span>Convert to WebP</span>
          </div>
          <div class="menu-sep"></div>
          <div class="menu-item">
            <span>Merge into Single PDF Document...</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <div class="footer-callout">
      <div>
        <h4>Native macOS ImageIO & PDFKit Graphics Pipeline</h4>
        <p>No Python runtime, no ImageMagick CLI, no cloud uploads. 100% on-device hardware accelerated conversion.</p>
      </div>
      <div style="font-size: 13px; font-weight: 600; color: #007aff; background: #e0f2fe; padding: 6px 14px; border-radius: 8px;">
        1-Click Batch Conversion
      </div>
    </div>
  </div>

</body>
</html>"""
    render_html_to_image(html, "context-actions", 1600, 1050, 1600, 1050)


# =============================================================
# 4. SOCIAL BANNER RENDER (OpenGraph 1200x630)
# =============================================================
def generate_social_banner():
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    width: 1200px;
    height: 630px;
    background: #090a0f;
    font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Inter", sans-serif;
    display: flex;
    align-items: center;
    padding: 60px;
    color: #ffffff;
    position: relative;
    overflow: hidden;
  }}

  /* Ambient light background meshes */
  .ambient-glow {{
    position: absolute;
    width: 600px;
    height: 600px;
    background: radial-gradient(circle, rgba(59, 130, 246, 0.18) 0%, rgba(99, 102, 241, 0.08) 50%, rgba(0,0,0,0) 70%);
    top: -100px;
    right: -100px;
    pointer-events: none;
  }}
  .ambient-glow-2 {{
    position: absolute;
    width: 500px;
    height: 500px;
    background: radial-gradient(circle, rgba(16, 185, 129, 0.12) 0%, rgba(0,0,0,0) 70%);
    bottom: -150px;
    left: 200px;
    pointer-events: none;
  }}

  /* Left column */
  .left-col {{
    width: 580px;
    display: flex;
    flex-direction: column;
    z-index: 10;
  }}

  .brand-row {{
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 24px;
  }}
  .brand-icon {{
    width: 64px;
    height: 64px;
    border-radius: 14px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
  }}
  .brand-name {{
    font-size: 28px;
    font-weight: 700;
    letter-spacing: -0.02em;
    color: #ffffff;
  }}
  .badge-tag {{
    font-size: 12px;
    font-weight: 600;
    background: rgba(255, 255, 255, 0.1);
    color: #93c5fd;
    padding: 4px 10px;
    border-radius: 999px;
    border: 1px solid rgba(255, 255, 255, 0.12);
  }}

  .hero-headline {{
    font-size: 40px;
    font-weight: 700;
    line-height: 1.15;
    letter-spacing: -0.03em;
    margin-bottom: 16px;
    background: linear-gradient(180deg, #ffffff 0%, #cbd5e1 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }}

  .hero-sub {{
    font-size: 17px;
    color: #94a3b8;
    line-height: 1.5;
    margin-bottom: 28px;
  }}

  .features-grid {{
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px 16px;
    margin-bottom: 30px;
  }}
  .feature-pill {{
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    color: #e2e8f0;
    font-weight: 500;
  }}
  .feature-dot {{
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: #38bdf8;
  }}

  .cmd-pill {{
    display: flex;
    align-items: center;
    gap: 10px;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 8px;
    padding: 10px 16px;
    font-family: "SF Mono", Menlo, Consolas, monospace;
    font-size: 12px;
    color: #38bdf8;
    width: fit-content;
  }}

  /* Right column: 3D perspective window */
  .right-col {{
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    z-index: 10;
  }}

  .preview-card {{
    width: 500px;
    height: 480px;
    background: rgba(18, 20, 29, 0.95);
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 14px;
    box-shadow: 0 30px 80px rgba(0, 0, 0, 0.6), 0 0 40px rgba(59, 130, 246, 0.15);
    transform: perspective(1000px) rotateY(-8deg) rotateX(4deg);
    overflow: hidden;
    display: flex;
    flex-direction: column;
  }}

  .preview-top {{
    height: 38px;
    background: rgba(255, 255, 255, 0.04);
    border-bottom: 1px solid rgba(255, 255, 255, 0.08);
    display: flex;
    align-items: center;
    padding: 0 14px;
    gap: 8px;
  }}
  .p-dot {{ width: 10px; height: 10px; border-radius: 50%; }}
  .p-red {{ background: #ff5f56; }}
  .p-yellow {{ background: #ffbd2e; }}
  .p-green {{ background: #27c93f; }}

  .preview-table {{
    flex: 1;
    padding: 14px;
    display: flex;
    flex-direction: column;
    gap: 8px;
    font-size: 12px;
  }}
  .p-row {{
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 8px 10px;
    border-radius: 6px;
    background: rgba(255, 255, 255, 0.03);
    color: #e2e8f0;
  }}
  .p-row.active {{
    background: rgba(59, 130, 246, 0.15);
    border: 1px solid rgba(59, 130, 246, 0.3);
  }}
  .p-calc {{
    color: #34d399;
    font-weight: 600;
  }}
</style>
</head>
<body>

  <div class="ambient-glow"></div>
  <div class="ambient-glow-2"></div>

  <div class="left-col">
    <div class="brand-row">
      <img src="{ICON_B64}" alt="Pathway" class="brand-icon">
      <div>
        <div class="brand-name">Pathway</div>
        <div style="font-size: 13px; color: #94a3b8;">The Windows-Style File Manager for macOS</div>
      </div>
      <span class="badge-tag">v1.0.0</span>
    </div>

    <h1 class="hero-headline">Windows muscle memory.<br>Native macOS speed.</h1>
    <p class="hero-sub">Enter to open, F2 to rename, recursive folder weights in List view, and native CoreGraphics batch image transcoding.</p>

    <div class="features-grid">
      <div class="feature-pill"><span class="feature-dot"></span><span>↵ Enter opens, never renames</span></div>
      <div class="feature-pill"><span class="feature-dot"></span><span>F2 instant inline rename</span></div>
      <div class="feature-pill"><span class="feature-dot"></span><span>Real folder sizes in List view</span></div>
      <div class="feature-pill"><span class="feature-dot"></span><span>Sort Ascending / Descending</span></div>
      <div class="feature-pill"><span class="feature-dot"></span><span>⌘X / Ctrl+X Cut & Paste</span></div>
      <div class="feature-pill"><span class="feature-dot"></span><span>Batch Image & Doc conversions</span></div>
    </div>

    <div class="cmd-pill">
      <span>$</span>
      <span>curl -fsSL https://raw.githubusercontent.com/.../install.sh | bash</span>
    </div>
  </div>

  <div class="right-col">
    <div class="preview-card">
      <div class="preview-top">
        <div class="p-dot p-red"></div>
        <div class="p-dot p-yellow"></div>
        <div class="p-dot p-green"></div>
        <span style="margin-left: 8px; font-size: 11px; color: #94a3b8;">Pathway — indiesuite-mac</span>
      </div>

      <div class="preview-table">
        <div style="font-size: 10px; font-weight: 700; text-transform: uppercase; color: #64748b; letter-spacing: 0.05em; padding-left: 4px;">Folders (Sorted by Size ▾)</div>

        <div class="p-row active">
          <div style="display: flex; align-items: center; gap: 8px;">
            <span>📁</span>
            <span style="font-weight: 600;">DerivedData</span>
          </div>
          <span class="p-calc">✓ 1.84 GB</span>
        </div>

        <div class="p-row">
          <div style="display: flex; align-items: center; gap: 8px;">
            <span>📁</span>
            <span>node_modules</span>
          </div>
          <span class="p-calc">✓ 418.2 MB</span>
        </div>

        <div class="p-row">
          <div style="display: flex; align-items: center; gap: 8px;">
            <span>📁</span>
            <span>.git</span>
          </div>
          <span class="p-calc">✓ 62.8 MB</span>
        </div>

        <div style="margin-top: 10px; font-size: 10px; font-weight: 700; text-transform: uppercase; color: #64748b; letter-spacing: 0.05em; padding-left: 4px;">Context Actions</div>

        <div style="background: rgba(0,0,0,0.4); border: 1px solid rgba(255,255,255,0.1); border-radius: 8px; padding: 8px; display: flex; flex-direction: column; gap: 6px;">
          <div style="display: flex; justify-content: space-between; color: #38bdf8; font-weight: 600;">
            <span>🖼 Convert Images (3 items) ▸</span>
          </div>
          <div style="font-size: 11px; color: #94a3b8; padding-left: 12px; display: flex; flex-direction: column; gap: 3px;">
            <span>• Convert to PNG (Lossless)</span>
            <span>• Convert to JPEG (90%)</span>
            <span>• Merge into Single PDF</span>
          </div>
        </div>

        <div style="margin-top: auto; padding-top: 8px; border-top: 1px solid rgba(255,255,255,0.08); font-size: 11px; color: #64748b; display: flex; justify-content: space-between;">
          <span>Swift 6 Actor · Off-Thread</span>
          <span style="color: #38bdf8;">100% Native</span>
        </div>
      </div>
    </div>
  </div>

</body>
</html>"""
    render_html_to_image(html, "social-banner", 1200, 630, 1200, 630)


if __name__ == "__main__":
    print("Generating Hero MacBook Pro render...")
    generate_hero_macbook()
    
    print("Generating Features Showcase render...")
    generate_features_showcase()
    
    print("Generating Context Actions render...")
    generate_context_actions()
    
    print("Generating Social Banner render...")
    generate_social_banner()

    print("\nAll 4 professional developer renders created successfully!")
