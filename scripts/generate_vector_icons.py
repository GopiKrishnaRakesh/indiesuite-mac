#!/usr/bin/env python3
import os
import json

ICONS_DIR = "website/assets/icons"
os.makedirs(ICONS_DIR, exist_ok=True)

# Define color schemes and vector path definitions for all 130 apps
# Each icon is a 64x64 SVG with modern gradients and crisp Apple-like geometry

def get_svg(app_id, name, cat):
    # Gradients tailored to categories
    palettes = {
        "ai": ("#8B5CF6", "#EC4899", "#3B82F6"),        # Violet-Pink-Blue
        "dev": ("#3B82F6", "#06B6D4", "#10B981"),       # Blue-Cyan-Emerald
        "media": ("#F59E0B", "#EC4899", "#8B5CF6"),     # Amber-Pink-Violet
        "system": ("#06B6D4", "#3B82F6", "#6366F1"),    # Cyan-Blue-Indigo
        "pets": ("#F97316", "#F59E0B", "#EF4444"),      # Orange-Amber-Rose
        "focus": ("#10B981", "#06B6D4", "#3B82F6"),     # Emerald-Cyan-Blue
        "routine": ("#3B82F6", "#8B5CF6", "#10B981"),   # Blue-Violet-Emerald
        "social": ("#EC4899", "#F43F5E", "#F59E0B")     # Pink-Rose-Amber
    }
    
    grad1, grad2, grad3 = palettes.get(cat, ("#6366F1", "#A855F7", "#EC4899"))
    
    # Internal SVG graphic paths based on app function
    # Designed as clean, modern 64x64 vector icons
    inner_shapes = {
        "01-whispertap": """
            <rect x="26" y="16" width="12" height="22" rx="6" fill="url(#fgGrad)"/>
            <path d="M20 28C20 34.6 25.4 40 32 40C38.6 40 44 34.6 44 28" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
            <path d="M32 40V48M24 48H40" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
            <path d="M14 26C14 18 20 12 32 12M50 26C50 18 44 12 32 12" stroke="white" stroke-width="2" stroke-linecap="round" opacity="0.6"/>
        """,
        "02-tokenwatch": """
            <rect x="16" y="20" width="32" height="24" rx="5" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
            <circle cx="25" cy="32" r="4" fill="url(#fgGrad)"/>
            <path d="M34 26H42M34 32H40M34 38H42" stroke="white" stroke-width="2" stroke-linecap="round"/>
            <path d="M24 14V20M40 14V20M24 44V50M40 44V50" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
        """,
        "03-locallens-ocr": """
            <path d="M16 24V18C16 16.9 16.9 16 18 16H24M40 16H46C47.1 16 48 16.9 48 18V24M48 40V46C48 47.1 47.1 48 46 48H40M24 48H18C16.9 48 16 47.1 16 46V40" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
            <path d="M26 27L22 32L26 37M38 27L42 32L38 37M34 25L30 39" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
        """,
        "04-portsentry": """
            <rect x="18" y="22" width="28" height="20" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
            <path d="M24 22V28M32 22V28M40 22V28" stroke="url(#fgGrad)" stroke-width="2" stroke-linecap="round"/>
            <circle cx="32" cy="35" r="3" fill="#EF4444"/>
            <path d="M32 14V18M14 32H18M46 32H50" stroke="url(#fgGrad)" stroke-width="2" stroke-linecap="round"/>
        """,
        "05-shrinkmedia": """
            <rect x="18" y="16" width="28" height="32" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
            <path d="M28 24L36 32L28 40" fill="url(#fgGrad)"/>
            <path d="M14 32H18M46 32H50" stroke="white" stroke-width="3" stroke-linecap="round"/>
            <path d="M24 12L32 16L40 12M24 52L32 48L40 52" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
        """,
        "06-colorforge": """
            <path d="M42 16L48 22L32 38L24 40L26 32L42 16Z" fill="url(#fgGrad)" stroke="white" stroke-width="2"/>
            <circle cx="20" cy="44" r="3" fill="url(#fgGrad)"/>
            <circle cx="46" cy="44" r="5" fill="#F59E0B"/>
            <circle cx="48" cy="32" r="4" fill="#EC4899"/>
            <circle cx="40" cy="48" r="4" fill="#3B82F6"/>
        """,
        "07-notchshelf": """
            <path d="M14 18H50V22C50 24 48 26 46 26H38C36 26 36 32 32 32C28 32 28 26 26 26H18C16 26 14 24 14 22V18Z" fill="url(#fgGrad)"/>
            <rect x="20" y="36" width="24" height="14" rx="3" fill="none" stroke="white" stroke-width="2.5" stroke-dasharray="3 3"/>
            <path d="M32 38V46M28 42L32 46L36 42" stroke="white" stroke-width="2" stroke-linecap="round"/>
        """,
        "08-audiomix": """
            <line x1="22" y1="16" x2="22" y2="48" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
            <line x1="32" y1="16" x2="32" y2="48" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
            <line x1="42" y1="16" x2="42" y2="48" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
            <circle cx="22" cy="26" r="4" fill="white"/>
            <circle cx="32" cy="38" r="4" fill="white"/>
            <circle cx="42" cy="22" r="4" fill="white"/>
        """,
        "09-micmute-hud": """
            <rect x="26" y="16" width="12" height="20" rx="6" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
            <path d="M20 26C20 32.6 25.4 38 32 38C38.6 38 44 32.6 44 26" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
            <path d="M32 38V46M24 46H40" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
            <line x1="16" y1="16" x2="48" y2="48" stroke="#EF4444" stroke-width="3.5" stroke-linecap="round"/>
        """,
        "10-promptdock": """
            <path d="M22 42L40 24M40 24L36 20L44 16L48 24L44 28L40 24Z" fill="url(#fgGrad)" stroke="white" stroke-width="2"/>
            <path d="M18 20L20 14L22 20L28 22L22 24L20 30L18 24L12 22L18 20Z" fill="#F59E0B"/>
            <path d="M42 40L43 37L46 36L43 35L42 32L41 35L38 36L41 37L42 40Z" fill="white"/>
        """
    }

    # Universal generator for any app ID with procedural icon styling
    if app_id in inner_shapes:
        graphic = inner_shapes[app_id]
    else:
        # Generate domain-specific aesthetic vector glyph
        if "pet" in app_id or "hamster" in app_id or "cat" in app_id or "duck" in app_id or "otter" in app_id or "sloth" in app_id or "panda" in app_id:
            graphic = f"""
                <circle cx="32" cy="34" r="14" fill="url(#fgGrad)"/>
                <circle cx="24" cy="20" r="5" fill="url(#fgGrad)"/>
                <circle cx="40" cy="20" r="5" fill="url(#fgGrad)"/>
                <circle cx="27" cy="32" r="2.5" fill="white"/>
                <circle cx="37" cy="32" r="2.5" fill="white"/>
                <circle cx="32" cy="38" r="2" fill="#1F2937"/>
                <path d="M29 41C30.5 42.5 33.5 42.5 35 41" stroke="#1F2937" stroke-width="1.5" stroke-linecap="round"/>
            """
        elif "focus" in app_id or "zen" in app_id or "blocker" in app_id or "brain" in app_id:
            graphic = f"""
                <circle cx="32" cy="32" r="16" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
                <circle cx="32" cy="32" r="9" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
                <circle cx="32" cy="32" r="3.5" fill="white"/>
                <path d="M32 10V14M32 50V54M10 32H14M50 32H54" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
            """
        elif "git" in app_id or "code" in app_id or "dev" in app_id or "json" in app_id or "sql" in app_id or "kube" in app_id or "docker" in app_id:
            graphic = f"""
                <path d="M22 24L14 32L22 40M42 24L50 32L42 40" stroke="url(#fgGrad)" stroke-width="3.5" stroke-linecap="round" stroke-linejoin="round"/>
                <line x1="36" y1="18" x2="28" y2="46" stroke="white" stroke-width="3" stroke-linecap="round"/>
            """
        elif "ai" in app_id or "whisper" in app_id or "llm" in app_id or "token" in app_id or "summarize" in app_id:
            graphic = f"""
                <rect x="20" y="20" width="24" height="24" rx="6" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
                <circle cx="32" cy="32" r="4" fill="white"/>
                <path d="M32 14V20M32 44V50M14 32H20M44 32H50" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
                <circle cx="32" cy="12" r="2" fill="url(#fgGrad)"/>
                <circle cx="32" cy="52" r="2" fill="url(#fgGrad)"/>
                <circle cx="12" cy="32" r="2" fill="url(#fgGrad)"/>
                <circle cx="52" cy="32" r="2" fill="url(#fgGrad)"/>
            """
        elif "routine" in app_id or "habit" in app_id or "water" in app_id or "timer" in app_id or "clock" in app_id or "step" in app_id or "fasting" in app_id:
            graphic = f"""
                <circle cx="32" cy="34" r="15" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
                <path d="M32 24V34L39 39" stroke="white" stroke-width="3" stroke-linecap="round"/>
                <path d="M28 14H36M32 14V19" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
            """
        elif "social" in app_id or "tweet" in app_id or "chat" in app_id or "discord" in app_id or "poll" in app_id or "banner" in app_id:
            graphic = f"""
                <path d="M18 20H46C48.2 20 50 21.8 50 24V38C50 40.2 48.2 42 46 42H26L18 48V24C18 21.8 19.8 20 22 20Z" fill="none" stroke="url(#fgGrad)" stroke-width="3" stroke-linejoin="round"/>
                <circle cx="28" cy="31" r="2.5" fill="white"/>
                <circle cx="36" cy="31" r="2.5" fill="white"/>
                <circle cx="44" cy="31" r="2.5" fill="white"/>
            """
        elif "media" in app_id or "icon" in app_id or "font" in app_id or "color" in app_id or "design" in app_id or "mesh" in app_id:
            graphic = f"""
                <rect x="18" y="18" width="28" height="28" rx="6" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
                <circle cx="27" cy="27" r="4" fill="url(#fgGrad)"/>
                <path d="M18 40L28 32L36 38L42 34L46 38" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
            """
        else: # System, File, Clean, Battery, Hardware, Security
            graphic = f"""
                <path d="M32 16L46 22V32C46 41 39.5 48.5 32 51C24.5 48.5 18 41 18 32V22L32 16Z" fill="none" stroke="url(#fgGrad)" stroke-width="3" stroke-linejoin="round"/>
                <path d="M26 33L30 37L38 27" stroke="white" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
            """

    svg_str = f"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="64" height="64" fill="none">
    <defs>
        <linearGradient id="bgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stop-color="{grad1}" stop-opacity="0.2"/>
            <stop offset="100%" stop-color="{grad2}" stop-opacity="0.05"/>
        </linearGradient>
        <linearGradient id="fgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stop-color="{grad1}"/>
            <stop offset="50%" stop-color="{grad2}"/>
            <stop offset="100%" stop-color="{grad3}"/>
        </linearGradient>
        <filter id="glow" x="-20%" y="-20%" width="140%" height="140%">
            <feDropShadow dx="0" dy="4" stdDeviation="6" flood-color="{grad1}" flood-opacity="0.3"/>
        </filter>
    </defs>
    
    <!-- Base Squircle Container -->
    <rect x="4" y="4" width="56" height="56" rx="14" fill="url(#bgGrad)" stroke="url(#fgGrad)" stroke-width="1.5" filter="url(#glow)"/>
    
    <!-- Custom Vector Icon Glyph -->
    <g>
        {graphic.strip()}
    </g>
</svg>"""
    return svg_str

# Load all 130 apps from app.js or definition list
from scaffold_50_more_apps import new_50_apps as apps_31_to_80
from scaffold_apps_81_to_130 import apps_81_to_130
from update_website_data import first_30_apps

all_apps = first_30_apps + [
    {"id": a["dir"], "name": a["name"], "cat": a["category"]} for a in apps_31_to_80 + apps_81_to_130
]

for app in all_apps:
    app_id = app["id"]
    svg_code = get_svg(app_id, app["name"], app["cat"])
    with open(f"{ICONS_DIR}/{app_id}.svg", "w") as f:
        f.write(svg_code)

print(f"✅ Generated all {len(all_apps)} crisp SVG vector icons in website/assets/icons/")
