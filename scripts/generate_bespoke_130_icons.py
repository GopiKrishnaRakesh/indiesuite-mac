#!/usr/bin/env python3
import os

ICONS_DIR = "website/assets/icons"
os.makedirs(ICONS_DIR, exist_ok=True)

# 130 Unique, Tailored Vector SVG Glyphs
# Each app has an individually designed SVG illustration tailored to its specific name and functional mechanics

def create_svg(app_id, g1, g2, g3, glyph_svg):
    return f"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="64" height="64" fill="none">
    <defs>
        <linearGradient id="bgGrad_{app_id.replace('-', '_')}" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stop-color="{g1}" stop-opacity="0.22"/>
            <stop offset="100%" stop-color="{g2}" stop-opacity="0.06"/>
        </linearGradient>
        <linearGradient id="fgGrad_{app_id.replace('-', '_')}" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stop-color="{g1}"/>
            <stop offset="50%" stop-color="{g2}"/>
            <stop offset="100%" stop-color="{g3}"/>
        </linearGradient>
        <filter id="glow_{app_id.replace('-', '_')}" x="-20%" y="-20%" width="140%" height="140%">
            <feDropShadow dx="0" dy="4" stdDeviation="6" flood-color="{g1}" flood-opacity="0.35"/>
        </filter>
    </defs>
    
    <!-- Base Squircle Container -->
    <rect x="4" y="4" width="56" height="56" rx="14" fill="url(#bgGrad_{app_id.replace('-', '_')})" stroke="url(#fgGrad_{app_id.replace('-', '_')})" stroke-width="1.5" filter="url(#glow_{app_id.replace('-', '_')})"/>
    
    <!-- Custom Vector Icon Glyph -->
    <g>
        {glyph_svg.strip().replace("fgGrad", f"fgGrad_{app_id.replace('-', '_')}")}
    </g>
</svg>"""

# Dictionary of all 130 unique bespoke vector glyphs
icons_db = {
    # 01-10
    "01-whispertap": ("#8B5CF6", "#EC4899", "#3B82F6", """
        <rect x="26" y="16" width="12" height="22" rx="6" fill="url(#fgGrad)"/>
        <path d="M20 28C20 34.6 25.4 40 32 40C38.6 40 44 34.6 44 28" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <path d="M32 40V48M24 48H40" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <path d="M14 26C14 18 20 12 32 12M50 26C50 18 44 12 32 12" stroke="white" stroke-width="2" stroke-linecap="round" opacity="0.6"/>
    """),
    "02-tokenwatch": ("#3B82F6", "#8B5CF6", "#10B981", """
        <rect x="16" y="20" width="32" height="24" rx="5" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <circle cx="25" cy="32" r="4" fill="url(#fgGrad)"/>
        <path d="M34 26H42M34 32H40M34 38H42" stroke="white" stroke-width="2" stroke-linecap="round"/>
        <path d="M24 14V20M40 14V20M24 44V50M40 44V50" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "03-locallens-ocr": ("#06B6D4", "#3B82F6", "#8B5CF6", """
        <path d="M16 24V18C16 16.9 16.9 16 18 16H24M40 16H46C47.1 16 48 16.9 48 18V24M48 40V46C48 47.1 47.1 48 46 48H40M24 48H18C16.9 48 16 47.1 16 46V40" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <path d="M26 27L22 32L26 37M38 27L42 32L38 37M34 25L30 39" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "04-portsentry": ("#EF4444", "#F59E0B", "#3B82F6", """
        <rect x="18" y="22" width="28" height="20" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <path d="M24 22V28M32 22V28M40 22V28" stroke="url(#fgGrad)" stroke-width="2" stroke-linecap="round"/>
        <circle cx="32" cy="35" r="3" fill="#EF4444"/>
        <path d="M32 14V18M14 32H18M46 32H50" stroke="url(#fgGrad)" stroke-width="2" stroke-linecap="round"/>
    """),
    "05-shrinkmedia": ("#F59E0B", "#EC4899", "#8B5CF6", """
        <rect x="18" y="16" width="28" height="32" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <path d="M28 24L36 32L28 40" fill="url(#fgGrad)"/>
        <path d="M14 32H18M46 32H50" stroke="white" stroke-width="3" stroke-linecap="round"/>
        <path d="M24 12L32 16L40 12M24 52L32 48L40 52" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "06-colorforge": ("#EC4899", "#8B5CF6", "#F59E0B", """
        <path d="M42 16L48 22L32 38L24 40L26 32L42 16Z" fill="url(#fgGrad)" stroke="white" stroke-width="2"/>
        <circle cx="20" cy="44" r="3" fill="url(#fgGrad)"/>
        <circle cx="46" cy="44" r="5" fill="#F59E0B"/>
        <circle cx="48" cy="32" r="4" fill="#EC4899"/>
        <circle cx="40" cy="48" r="4" fill="#3B82F6"/>
    """),
    "07-notchshelf": ("#06B6D4", "#3B82F6", "#6366F1", """
        <path d="M14 18H50V22C50 24 48 26 46 26H38C36 26 36 32 32 32C28 32 28 26 26 26H18C16 26 14 24 14 22V18Z" fill="url(#fgGrad)"/>
        <rect x="20" y="36" width="24" height="14" rx="3" fill="none" stroke="white" stroke-width="2.5" stroke-dasharray="3 3"/>
        <path d="M32 38V46M28 42L32 46L36 42" stroke="white" stroke-width="2" stroke-linecap="round"/>
    """),
    "08-audiomix": ("#10B981", "#06B6D4", "#3B82F6", """
        <line x1="22" y1="16" x2="22" y2="48" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <line x1="32" y1="16" x2="32" y2="48" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <line x1="42" y1="16" x2="42" y2="48" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <circle cx="22" cy="26" r="4" fill="white"/>
        <circle cx="32" cy="38" r="4" fill="white"/>
        <circle cx="42" cy="22" r="4" fill="white"/>
    """),
    "09-micmute-hud": ("#EF4444", "#F43F5E", "#F59E0B", """
        <rect x="26" y="16" width="12" height="20" rx="6" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <path d="M20 26C20 32.6 25.4 38 32 38C38.6 38 44 32.6 44 26" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <path d="M32 38V46M24 46H40" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <line x1="16" y1="16" x2="48" y2="48" stroke="#EF4444" stroke-width="3.5" stroke-linecap="round"/>
    """),
    "10-promptdock": ("#8B5CF6", "#EC4899", "#F59E0B", """
        <path d="M22 42L40 24M40 24L36 20L44 16L48 24L44 28L40 24Z" fill="url(#fgGrad)" stroke="white" stroke-width="2"/>
        <path d="M18 20L20 14L22 20L28 22L22 24L20 30L18 24L12 22L18 20Z" fill="#F59E0B"/>
        <path d="M42 40L43 37L46 36L43 35L42 32L41 35L38 36L41 37L42 40Z" fill="white"/>
    """),
    # 11-20
    "11-snaptile": ("#3B82F6", "#06B6D4", "#10B981", """
        <rect x="16" y="16" width="14" height="14" rx="3" fill="url(#fgGrad)"/>
        <rect x="34" y="16" width="14" height="14" rx="3" fill="none" stroke="white" stroke-width="2"/>
        <rect x="16" y="34" width="14" height="14" rx="3" fill="none" stroke="white" stroke-width="2"/>
        <rect x="34" y="34" width="14" height="14" rx="3" fill="url(#fgGrad)"/>
    """),
    "12-purgeapp": ("#EF4444", "#F59E0B", "#EC4899", """
        <path d="M22 22L24 46H40L42 22M18 22H46M28 22V16H36V22" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
        <line x1="28" y1="28" x2="28" y2="40" stroke="white" stroke-width="2" stroke-linecap="round"/>
        <line x1="36" y1="28" x2="36" y2="40" stroke="white" stroke-width="2" stroke-linecap="round"/>
    """),
    "13-chargeguard": ("#10B981", "#3B82F6", "#06B6D4", """
        <rect x="16" y="22" width="28" height="20" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <path d="M44 28V36" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <rect x="20" y="26" width="15" height="12" rx="2" fill="#10B981"/>
        <path d="M30 20V24M30 40V44" stroke="#F59E0B" stroke-width="2.5"/>
    """),
    "14-envvault": ("#F59E0B", "#EF4444", "#8B5CF6", """
        <rect x="18" y="26" width="28" height="22" rx="5" fill="url(#fgGrad)"/>
        <path d="M24 26V20C24 15.6 27.6 12 32 12C36.4 12 40 15.6 40 20V26" stroke="white" stroke-width="3" stroke-linecap="round"/>
        <circle cx="32" cy="37" r="3" fill="#1E293B"/>
    """),
    "15-devtunnel-hud": ("#06B6D4", "#3B82F6", "#8B5CF6", """
        <path d="M16 48C16 30 22 16 32 16C42 16 48 30 48 48" stroke="url(#fgGrad)" stroke-width="3.5" stroke-linecap="round"/>
        <path d="M22 48C22 36 26 24 32 24C38 24 42 36 42 48" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
        <line x1="14" y1="48" x2="50" y2="48" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
    """),
    "16-gitpulse": ("#10B981", "#3B82F6", "#8B5CF6", """
        <circle cx="20" cy="40" r="4" fill="url(#fgGrad)"/>
        <circle cx="44" cy="24" r="4" fill="url(#fgGrad)"/>
        <circle cx="44" cy="40" r="4" fill="url(#fgGrad)"/>
        <path d="M20 36V20M20 40H40M20 32C30 32 34 24 40 24" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "17-regexforge": ("#EC4899", "#8B5CF6", "#3B82F6", """
        <path d="M18 20L26 14L34 20M30 44L38 50L46 44" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <text x="21" y="36" fill="white" font-size="14" font-weight="bold" font-family="monospace">.*$</text>
    """),
    "18-svgoptim": ("#F59E0B", "#10B981", "#06B6D4", """
        <circle cx="20" cy="20" r="4" fill="url(#fgGrad)"/>
        <circle cx="44" cy="20" r="4" fill="url(#fgGrad)"/>
        <circle cx="32" cy="44" r="4" fill="url(#fgGrad)"/>
        <path d="M20 20C26 34 38 34 44 20M20 20L32 44L44 20" stroke="white" stroke-width="2"/>
    """),
    "19-fontinspect": ("#8B5CF6", "#3B82F6", "#EC4899", """
        <text x="18" y="44" fill="url(#fgGrad)" font-size="34" font-weight="bold" font-family="serif">A</text>
        <line x1="12" y1="46" x2="52" y2="46" stroke="#06B6D4" stroke-width="2" stroke-dasharray="2 2"/>
        <line x1="12" y1="16" x2="52" y2="16" stroke="#06B6D4" stroke-width="2" stroke-dasharray="2 2"/>
    """),
    "20-presentercam": ("#EC4899", "#F59E0B", "#8B5CF6", """
        <circle cx="32" cy="32" r="16" fill="url(#fgGrad)"/>
        <circle cx="32" cy="28" r="6" fill="white"/>
        <path d="M22 42C22 38 26 36 32 36C38 36 42 38 42 42" fill="white"/>
        <circle cx="44" cy="20" r="3" fill="#EF4444"/>
    """),
    # 21-30
    "21-cleandesk-pro": ("#10B981", "#06B6D4", "#3B82F6", """
        <line x1="20" y1="44" x2="44" y2="20" stroke="url(#fgGrad)" stroke-width="4" stroke-linecap="round"/>
        <path d="M16 48L24 40L28 44L20 52Z" fill="#F59E0B"/>
        <path d="M38 18L40 14L42 18L46 20L42 22L40 26L38 22L34 20Z" fill="white"/>
    """),
    "22-screenruler": ("#F59E0B", "#EC4899", "#3B82F6", """
        <rect x="14" y="24" width="36" height="16" rx="3" fill="url(#fgGrad)"/>
        <line x1="20" y1="24" x2="20" y2="30" stroke="white" stroke-width="2"/>
        <line x1="26" y1="24" x2="26" y2="34" stroke="white" stroke-width="2"/>
        <line x1="32" y1="24" x2="32" y2="30" stroke="white" stroke-width="2"/>
        <line x1="38" y1="24" x2="38" y2="34" stroke="white" stroke-width="2"/>
        <line x1="44" y1="24" x2="44" y2="30" stroke="white" stroke-width="2"/>
    """),
    "23-apphop": ("#3B82F6", "#8B5CF6", "#EC4899", """
        <rect x="16" y="22" width="20" height="24" rx="4" fill="url(#fgGrad)" opacity="0.7"/>
        <rect x="28" y="16" width="20" height="24" rx="4" fill="url(#fgGrad)"/>
        <path d="M22 36L34 24M34 24H26M34 24V32" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "24-scratchpad-hud": ("#F59E0B", "#10B981", "#3B82F6", """
        <rect x="18" y="16" width="28" height="32" rx="4" fill="url(#fgGrad)"/>
        <line x1="24" y1="24" x2="36" y2="24" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
        <line x1="24" y1="30" x2="40" y2="30" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
        <line x1="24" y1="36" x2="32" y2="36" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "25-timebridge": ("#06B6D4", "#3B82F6", "#8B5CF6", """
        <circle cx="22" cy="32" r="8" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <circle cx="42" cy="32" r="8" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <path d="M22 24C28 20 36 20 42 24" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "26-menucleaner": ("#6366F1", "#A855F7", "#EC4899", """
        <rect x="14" y="26" width="36" height="12" rx="3" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <line x1="28" y1="24" x2="28" y2="40" stroke="#EF4444" stroke-width="3" stroke-linecap="round"/>
        <circle cx="21" cy="32" r="2" fill="white"/>
        <circle cx="35" cy="32" r="2" fill="white" opacity="0.3"/>
        <circle cx="42" cy="32" r="2" fill="white" opacity="0.3"/>
    """),
    "27-metascrub": ("#10B981", "#3B82F6", "#06B6D4", """
        <path d="M32 14L46 20V32C46 41 39.5 48.5 32 51C24.5 48.5 18 41 18 32V20L32 14Z" fill="url(#fgGrad)"/>
        <line x1="24" y1="26" x2="40" y2="40" stroke="white" stroke-width="3" stroke-linecap="round"/>
    """),
    "28-bandwidthradar": ("#06B6D4", "#10B981", "#3B82F6", """
        <circle cx="32" cy="32" r="16" fill="none" stroke="url(#fgGrad)" stroke-width="2"/>
        <circle cx="32" cy="32" r="8" fill="none" stroke="url(#fgGrad)" stroke-width="2"/>
        <line x1="32" y1="32" x2="44" y2="20" stroke="#10B981" stroke-width="2.5" stroke-linecap="round"/>
        <circle cx="32" cy="32" r="3" fill="white"/>
    """),
    "29-bluetoothautohop": ("#3B82F6", "#8B5CF6", "#06B6D4", """
        <path d="M26 20L38 32L32 38V14L38 20L26 32" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M42 26C45 28 45 36 42 38" stroke="white" stroke-width="2" stroke-linecap="round"/>
    """),
    "30-privatellm-bar": ("#8B5CF6", "#EC4899", "#3B82F6", """
        <rect x="18" y="18" width="28" height="28" rx="6" fill="url(#fgGrad)"/>
        <path d="M28 26C28 24 30 22 32 22C34 22 36 24 36 26C36 28 34 29 32 31V34M32 38V40" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    # 31-40
    "31-petpals-desktop": ("#F97316", "#F59E0B", "#EF4444", """
        <circle cx="32" cy="36" r="12" fill="url(#fgGrad)"/>
        <circle cx="22" cy="22" r="5" fill="url(#fgGrad)"/>
        <circle cx="42" cy="22" r="5" fill="url(#fgGrad)"/>
        <circle cx="28" cy="34" r="2" fill="white"/>
        <circle cx="36" cy="34" r="2" fill="white"/>
        <circle cx="32" cy="39" r="2" fill="#1F2937"/>
    """),
    "32-bonsaigrow": ("#10B981", "#059669", "#F59E0B", """
        <path d="M22 46H42L39 52H25L22 46Z" fill="#D97706"/>
        <path d="M32 46V36C32 34 30 32 26 30" stroke="#78350F" stroke-width="3" stroke-linecap="round"/>
        <circle cx="24" cy="28" r="8" fill="#10B981"/>
        <circle cx="36" cy="24" r="10" fill="#059669"/>
    """),
    "33-deskfish-aquarium": ("#06B6D4", "#3B82F6", "#10B981", """
        <circle cx="32" cy="34" r="16" fill="url(#fgGrad)" opacity="0.3"/>
        <ellipse cx="32" cy="34" rx="8" ry="5" fill="#F97316"/>
        <path d="M38 34L44 30V38L38 34Z" fill="#F97316"/>
        <circle cx="28" cy="33" r="1.5" fill="white"/>
        <circle cx="30" cy="22" r="2" fill="white" opacity="0.6"/>
    """),
    "34-pomodorodragon": ("#EF4444", "#F59E0B", "#7C3AED", """
        <ellipse cx="32" cy="34" rx="12" ry="16" fill="url(#fgGrad)"/>
        <path d="M26 28L32 34L38 28" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
        <path d="M32 10C32 10 36 14 36 18C36 20 34 22 32 22C30 22 28 20 28 18C28 14 32 10 32 10Z" fill="#F59E0B"/>
    """),
    "35-codecat": ("#8B5CF6", "#3B82F6", "#EC4899", """
        <path d="M20 42C20 32 24 26 32 26C40 26 44 32 44 42" fill="url(#fgGrad)"/>
        <polygon points="20,28 20,18 28,26" fill="url(#fgGrad)"/>
        <polygon points="44,28 44,18 36,26" fill="url(#fgGrad)"/>
        <circle cx="27" cy="33" r="2" fill="#10B981"/>
        <circle cx="37" cy="33" r="2" fill="#10B981"/>
    """),
    "36-deepflow-blocker": ("#1E293B", "#334155", "#EF4444", """
        <circle cx="32" cy="32" r="16" fill="url(#fgGrad)"/>
        <circle cx="32" cy="32" r="10" fill="#0F172A"/>
        <line x1="20" y1="20" x2="44" y2="44" stroke="#EF4444" stroke-width="3.5" stroke-linecap="round"/>
    """),
    "37-zenaudio-ambience": ("#06B6D4", "#8B5CF6", "#10B981", """
        <path d="M26 16V30C26 34 29 37 32 37C35 37 38 34 38 30V16" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <path d="M32 37V48M26 48H38" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <circle cx="32" cy="18" r="2" fill="#06B6D4"/>
    """),
    "38-screendimmer-focus": ("#F59E0B", "#3B82F6", "#1E293B", """
        <polygon points="32,14 16,48 48,48" fill="url(#fgGrad)" opacity="0.35"/>
        <circle cx="32" cy="14" r="5" fill="#F59E0B"/>
        <rect x="24" y="38" width="16" height="10" rx="2" fill="white"/>
    """),
    "39-breakreminder": ("#10B981", "#06B6D4", "#3B82F6", """
        <ellipse cx="32" cy="32" rx="16" ry="10" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <circle cx="32" cy="32" r="5" fill="url(#fgGrad)"/>
        <circle cx="34" cy="30" r="1.5" fill="white"/>
    """),
    "40-monospace-flow": ("#64748B", "#334155", "#0EA5E9", """
        <rect x="18" y="18" width="28" height="28" rx="6" fill="url(#fgGrad)"/>
        <text x="24" y="39" fill="white" font-size="20" font-weight="bold" font-family="monospace">F_</text>
    """),
    # 41-50
    "41-habitgrid": ("#10B981", "#059669", "#34D399", """
        <rect x="16" y="16" width="8" height="8" rx="2" fill="#10B981"/>
        <rect x="28" y="16" width="8" height="8" rx="2" fill="#10B981"/>
        <rect x="40" y="16" width="8" height="8" rx="2" fill="#059669"/>
        <rect x="16" y="28" width="8" height="8" rx="2" fill="#059669"/>
        <rect x="28" y="28" width="8" height="8" rx="2" fill="#34D399"/>
        <rect x="40" y="28" width="8" height="8" rx="2" fill="#10B981"/>
        <rect x="16" y="40" width="8" height="8" rx="2" fill="#10B981"/>
        <rect x="28" y="40" width="8" height="8" rx="2" fill="#10B981"/>
        <rect x="40" y="40" width="8" height="8" rx="2" fill="#34D399"/>
    """),
    "42-waterdrop-hud": ("#06B6D4", "#3B82F6", "#60A5FA", """
        <path d="M32 14C32 14 18 30 18 38C18 45.7 24.3 52 32 52C39.7 52 46 45.7 46 38C46 30 32 14 32 14Z" fill="url(#fgGrad)"/>
        <circle cx="28" cy="38" r="3" fill="white" opacity="0.6"/>
    """),
    "43-postureguard": ("#3B82F6", "#8B5CF6", "#10B981", """
        <circle cx="32" cy="18" r="5" fill="url(#fgGrad)"/>
        <path d="M32 24V46M32 30L24 38M32 30L40 38M32 46L26 54M32 46L38 54" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "44-standup-timer": ("#F59E0B", "#10B981", "#3B82F6", """
        <rect x="16" y="32" width="32" height="4" rx="2" fill="url(#fgGrad)"/>
        <line x1="20" y1="36" x2="20" y2="48" stroke="url(#fgGrad)" stroke-width="3"/>
        <line x1="44" y1="36" x2="44" y2="48" stroke="url(#fgGrad)" stroke-width="3"/>
        <path d="M32 26V16M28 20L32 16L36 20" stroke="#10B981" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "45-dayplanner-notch": ("#8B5CF6", "#EC4899", "#3B82F6", """
        <rect x="14" y="16" width="36" height="32" rx="6" fill="url(#fgGrad)"/>
        <rect x="18" y="24" width="8" height="6" rx="2" fill="#F59E0B"/>
        <rect x="28" y="24" width="18" height="6" rx="2" fill="#10B981"/>
        <rect x="18" y="34" width="20" height="6" rx="2" fill="#3B82F6"/>
    """),
    "46-statussync": ("#EC4899", "#3B82F6", "#10B981", """
        <circle cx="32" cy="32" r="14" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <path d="M32 18L36 22L32 26M32 46L28 42L32 38" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "47-quicktweet-x": ("#0284C7", "#38BDF8", "#F43F5E", """
        <path d="M16 32L48 18L36 46L30 36L16 32Z" fill="url(#fgGrad)"/>
        <path d="M30 36L48 18" stroke="white" stroke-width="2"/>
    """),
    "48-dminbox-unified": ("#6366F1", "#EC4899", "#F59E0B", """
        <path d="M16 22H48V38H38L32 44L26 38H16V22Z" fill="url(#fgGrad)"/>
        <circle cx="46" cy="18" r="4" fill="#EF4444"/>
    """),
    "49-streamerbanner": ("#EF4444", "#F59E0B", "#3B82F6", """
        <rect x="14" y="20" width="36" height="24" rx="4" fill="url(#fgGrad)"/>
        <circle cx="22" cy="32" r="3" fill="#EF4444"/>
        <text x="28" y="36" fill="white" font-size="10" font-weight="bold">LIVE</text>
    """),
    "50-emojiforge": ("#F59E0B", "#EC4899", "#8B5CF6", """
        <circle cx="32" cy="32" r="16" fill="url(#fgGrad)"/>
        <circle cx="26" cy="28" r="2.5" fill="#1F2937"/>
        <circle cx="38" cy="28" r="2.5" fill="#1F2937"/>
        <path d="M26 36C28 40 36 40 38 36" stroke="#1F2937" stroke-width="2.5" stroke-linecap="round"/>
    """),
    # 51-60
    "51-pdfwhisper-ai": ("#DC2626", "#F87171", "#8B5CF6", """
        <rect x="18" y="16" width="28" height="32" rx="4" fill="url(#fgGrad)"/>
        <text x="22" y="36" fill="white" font-size="11" font-weight="bold">PDF</text>
        <circle cx="42" cy="20" r="4" fill="#8B5CF6"/>
    """),
    "52-gitcommit-ai": ("#10B981", "#3B82F6", "#8B5CF6", """
        <circle cx="32" cy="32" r="8" fill="url(#fgGrad)"/>
        <path d="M32 14V24M32 40V50" stroke="white" stroke-width="3" stroke-linecap="round"/>
        <path d="M42 22L44 18L46 22L50 24L46 26L44 30L42 26L38 24Z" fill="#F59E0B"/>
    """),
    "53-codeexplainer-hud": ("#F59E0B", "#10B981", "#3B82F6", """
        <path d="M22 26L16 32L22 38M42 26L48 32L42 38" stroke="white" stroke-width="3" stroke-linecap="round"/>
        <circle cx="32" cy="30" r="5" fill="#F59E0B"/>
        <line x1="32" y1="35" x2="32" y2="40" stroke="#F59E0B" stroke-width="2"/>
    """),
    "54-voicetranscribe-batch": ("#8B5CF6", "#06B6D4", "#3B82F6", """
        <circle cx="24" cy="30" r="6" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <circle cx="40" cy="30" r="6" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <line x1="24" y1="36" x2="40" y2="36" stroke="white" stroke-width="2"/>
        <rect x="20" y="42" width="24" height="8" rx="2" fill="url(#fgGrad)"/>
    """),
    "55-aiwallpaper-generator": ("#EC4899", "#8B5CF6", "#06B6D4", """
        <rect x="16" y="18" width="32" height="24" rx="4" fill="url(#fgGrad)"/>
        <path d="M20 38L28 28L36 36L40 32L44 38Z" fill="white" opacity="0.8"/>
        <circle cx="38" cy="24" r="3" fill="#F59E0B"/>
    """),
    "56-jsonmaster-pro": ("#06B6D4", "#3B82F6", "#10B981", """
        <text x="18" y="39" fill="url(#fgGrad)" font-size="24" font-weight="bold" font-family="monospace">{ }</text>
    """),
    "57-cronvisualizer": ("#F59E0B", "#EF4444", "#3B82F6", """
        <circle cx="32" cy="32" r="16" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <path d="M32 20V32L40 32" stroke="white" stroke-width="3" stroke-linecap="round"/>
        <circle cx="32" cy="16" r="2" fill="#F59E0B"/>
        <circle cx="48" cy="32" r="2" fill="#F59E0B"/>
    """),
    "58-dockerquick-hud": ("#0284C7", "#0EA5E9", "#38BDF8", """
        <rect x="24" y="24" width="4" height="4" fill="white"/>
        <rect x="30" y="24" width="4" height="4" fill="white"/>
        <rect x="36" y="24" width="4" height="4" fill="white"/>
        <rect x="30" y="18" width="4" height="4" fill="white"/>
        <path d="M16 34C18 42 36 44 46 36C48 34 48 30 46 30H16V34Z" fill="url(#fgGrad)"/>
    """),
    "59-hostsmanager": ("#10B981", "#3B82F6", "#6366F1", """
        <rect x="18" y="18" width="28" height="28" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <line x1="18" y1="28" x2="46" y2="28" stroke="url(#fgGrad)" stroke-width="2"/>
        <path d="M26 36L32 42L38 36" stroke="#10B981" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "60-certsentry": ("#10B981", "#F59E0B", "#3B82F6", """
        <path d="M32 14L46 20V32C46 41 39.5 48.5 32 51C24.5 48.5 18 41 18 32V20L32 14Z" fill="url(#fgGrad)"/>
        <circle cx="32" cy="30" r="4" fill="white"/>
        <path d="M32 34V38" stroke="white" stroke-width="2"/>
    """),
    # 61-70
    "61-keychainquick": ("#F59E0B", "#D97706", "#B45309", """
        <circle cx="26" cy="28" r="8" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <path d="M32 32L46 46M42 42L46 38M38 46L42 42" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
    """),
    "62-curlcraft": ("#06B6D4", "#3B82F6", "#8B5CF6", """
        <path d="M16 42C16 30 26 22 36 22C44 22 48 26 48 32C48 38 42 40 36 40C30 40 28 36 28 32" stroke="url(#fgGrad)" stroke-width="3.5" stroke-linecap="round"/>
    """),
    "63-sqlitelens": ("#3B82F6", "#06B6D4", "#10B981", """
        <ellipse cx="28" cy="22" rx="10" ry="4" fill="url(#fgGrad)"/>
        <path d="M18 22V38C18 40.2 22.5 42 28 42C33.5 42 38 40.2 38 38V22" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <circle cx="42" cy="42" r="6" fill="none" stroke="#F59E0B" stroke-width="2.5"/>
        <line x1="46" y1="46" x2="52" y2="52" stroke="#F59E0B" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "64-npmoutdated-hud": ("#EF4444", "#F59E0B", "#8B5CF6", """
        <polygon points="32,16 48,25 48,43 32,52 16,43 16,25" fill="url(#fgGrad)"/>
        <text x="28" y="39" fill="white" font-size="16" font-weight="bold">!</text>
    """),
    "65-taillogs": ("#10B981", "#3B82F6", "#06B6D4", """
        <rect x="16" y="16" width="32" height="32" rx="4" fill="#0F172A"/>
        <line x1="22" y1="24" x2="36" y2="24" stroke="#10B981" stroke-width="2"/>
        <line x1="22" y1="30" x2="42" y2="30" stroke="#38BDF8" stroke-width="2"/>
        <line x1="22" y1="36" x2="30" y2="36" stroke="#F59E0B" stroke-width="2"/>
    """),
    "66-mockupsnap": ("#6366F1", "#8B5CF6", "#EC4899", """
        <rect x="18" y="18" width="28" height="20" rx="3" fill="url(#fgGrad)"/>
        <path d="M14 42H50V44H14V42Z" fill="white"/>
        <circle cx="32" cy="28" r="3" fill="white"/>
    """),
    "67-appiconforge": ("#EC4899", "#F59E0B", "#3B82F6", """
        <rect x="18" y="18" width="28" height="28" rx="8" fill="url(#fgGrad)"/>
        <circle cx="32" cy="32" r="8" fill="none" stroke="white" stroke-width="2"/>
    """),
    "68-lottiepreview": ("#06B6D4", "#10B981", "#F59E0B", """
        <polygon points="28,22 42,32 28,42" fill="url(#fgGrad)"/>
        <circle cx="32" cy="32" r="16" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
    """),
    "69-aspectratio-calc": ("#F59E0B", "#EF4444", "#8B5CF6", """
        <rect x="16" y="22" width="32" height="20" rx="3" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <text x="22" y="36" fill="white" font-size="11" font-weight="bold">16:9</text>
    """),
    "70-shadowstudio": ("#64748B", "#334155", "#8B5CF6", """
        <rect x="22" y="18" width="24" height="24" rx="4" fill="url(#fgGrad)"/>
        <rect x="18" y="24" width="24" height="24" rx="4" fill="black" opacity="0.4"/>
    """),
    # 71-80
    "71-duplicatefinder": ("#3B82F6", "#8B5CF6", "#EF4444", """
        <rect x="16" y="20" width="18" height="24" rx="3" fill="url(#fgGrad)" opacity="0.8"/>
        <rect x="30" y="20" width="18" height="24" rx="3" fill="url(#fgGrad)"/>
        <path d="M26 32H38" stroke="white" stroke-width="3" stroke-linecap="round"/>
    """),
    "72-caffeinebar": ("#D97706", "#F59E0B", "#EF4444", """
        <path d="M20 26H40V38C40 42 36 46 30 46C24 46 20 42 20 38V26Z" fill="url(#fgGrad)"/>
        <path d="M40 28H44C46 28 48 30 48 32C48 34 46 36 44 36H40" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <path d="M26 16C26 20 28 20 28 24M34 16C34 20 36 20 36 24" stroke="white" stroke-width="2" stroke-linecap="round"/>
    """),
    "73-hiddenfiles-toggle": ("#64748B", "#94A3B8", "#38BDF8", """
        <circle cx="24" cy="32" r="3" fill="white"/>
        <circle cx="32" cy="32" r="3" fill="white"/>
        <circle cx="40" cy="32" r="3" fill="white"/>
        <circle cx="32" cy="32" r="16" fill="none" stroke="url(#fgGrad)" stroke-width="2.5" stroke-dasharray="4 4"/>
    """),
    "74-archiveextractor": ("#F59E0B", "#10B981", "#3B82F6", """
        <rect x="18" y="24" width="28" height="24" rx="3" fill="url(#fgGrad)"/>
        <path d="M14 24L32 14L50 24" stroke="white" stroke-width="2.5" stroke-linejoin="round"/>
        <path d="M32 28V38M28 32L32 28L36 32" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "75-clipboarddiff": ("#10B981", "#EF4444", "#3B82F6", """
        <rect x="18" y="16" width="28" height="32" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <line x1="24" y1="26" x2="36" y2="26" stroke="#10B981" stroke-width="2.5"/>
        <line x1="24" y1="34" x2="36" y2="34" stroke="#EF4444" stroke-width="2.5"/>
    """),
    "76-apppermission-auditor": ("#3B82F6", "#10B981", "#8B5CF6", """
        <path d="M32 14L46 20V32C46 41 39.5 48.5 32 51C24.5 48.5 18 41 18 32V20L32 14Z" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <circle cx="32" cy="30" r="4" fill="#3B82F6"/>
        <path d="M26 38L30 42L38 34" stroke="#10B981" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "77-wifiradar": ("#06B6D4", "#3B82F6", "#10B981", """
        <path d="M18 24C26 18 38 18 46 24M22 30C28 26 36 26 42 30M27 36C30 34 34 34 37 36" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <circle cx="32" cy="44" r="3" fill="url(#fgGrad)"/>
    """),
    "78-quickshare-local": ("#10B981", "#06B6D4", "#3B82F6", """
        <circle cx="22" cy="32" r="6" fill="url(#fgGrad)"/>
        <circle cx="42" cy="32" r="6" fill="url(#fgGrad)"/>
        <path d="M28 32H36M32 28L36 32L32 36" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "79-audiorecord-hud": ("#EF4444", "#F43F5E", "#8B5CF6", """
        <rect x="16" y="20" width="32" height="24" rx="4" fill="url(#fgGrad)"/>
        <circle cx="26" cy="32" r="4" fill="#1E293B"/>
        <circle cx="38" cy="32" r="4" fill="#1E293B"/>
        <circle cx="42" cy="16" r="3" fill="#EF4444"/>
    """),
    "80-memorypurge-pro": ("#8B5CF6", "#3B82F6", "#06B6D4", """
        <rect x="16" y="26" width="32" height="14" rx="3" fill="url(#fgGrad)"/>
        <line x1="22" y1="40" x2="22" y2="46" stroke="white" stroke-width="2"/>
        <line x1="28" y1="40" x2="28" y2="46" stroke="white" stroke-width="2"/>
        <line x1="34" y1="40" x2="34" y2="46" stroke="white" stroke-width="2"/>
        <line x1="40" y1="40" x2="40" y2="46" stroke="white" stroke-width="2"/>
        <path d="M32 16L36 22H28L32 16Z" fill="#10B981"/>
    """),
    # 81-90
    "81-pixelhamster-desktop": ("#F97316", "#F59E0B", "#EF4444", """
        <circle cx="32" cy="32" r="16" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <circle cx="32" cy="32" r="10" fill="url(#fgGrad)" opacity="0.3"/>
        <ellipse cx="32" cy="36" rx="6" ry="4" fill="#F97316"/>
        <circle cx="30" cy="34" r="1" fill="white"/>
        <circle cx="34" cy="34" r="1" fill="white"/>
    """),
    "82-cybergochi": ("#EC4899", "#8B5CF6", "#3B82F6", """
        <ellipse cx="32" cy="34" rx="14" ry="16" fill="url(#fgGrad)"/>
        <rect x="24" y="26" width="16" height="12" rx="2" fill="#1E293B"/>
        <rect x="28" y="30" width="3" height="3" fill="#10B981"/>
        <rect x="33" y="30" width="3" height="3" fill="#10B981"/>
    """),
    "83-deskduck": ("#F59E0B", "#FBBF24", "#EF4444", """
        <circle cx="28" cy="26" r="8" fill="url(#fgGrad)"/>
        <ellipse cx="34" cy="38" rx="12" ry="8" fill="url(#fgGrad)"/>
        <path d="M34 26L44 28L34 32Z" fill="#EF4444"/>
        <circle cx="26" cy="24" r="1.5" fill="#1E293B"/>
    """),
    "84-plantnursery-hud": ("#10B981", "#059669", "#34D399", """
        <path d="M22 40H42L39 48H25L22 40Z" fill="#D97706"/>
        <path d="M32 40V24C32 20 26 18 26 24C26 30 32 34 32 40Z" fill="#10B981"/>
        <path d="M32 34C32 28 38 26 38 30C38 36 32 36 32 40Z" fill="#34D399"/>
    """),
    "85-focussloth": ("#A16207", "#CA8A04", "#10B981", """
        <path d="M14 20C24 20 40 24 50 20" stroke="#78350F" stroke-width="4" stroke-linecap="round"/>
        <ellipse cx="32" cy="32" rx="10" ry="7" fill="url(#fgGrad)"/>
        <circle cx="24" cy="34" r="4" fill="url(#fgGrad)"/>
        <circle cx="23" cy="34" r="1" fill="#1E293B"/>
    """),
    "86-zenpanda": ("#1E293B", "#475569", "#10B981", """
        <circle cx="32" cy="34" r="12" fill="white"/>
        <circle cx="22" cy="24" r="4" fill="#1E293B"/>
        <circle cx="42" cy="24" r="4" fill="#1E293B"/>
        <circle cx="28" cy="32" r="2.5" fill="#1E293B"/>
        <circle cx="36" cy="32" r="2.5" fill="#1E293B"/>
        <ellipse cx="32" cy="38" rx="2" ry="1.5" fill="#1E293B"/>
    """),
    "87-codeotter": ("#0284C7", "#0EA5E9", "#F59E0B", """
        <ellipse cx="32" cy="34" rx="12" ry="8" fill="url(#fgGrad)"/>
        <circle cx="22" cy="32" r="5" fill="url(#fgGrad)"/>
        <ellipse cx="34" cy="32" rx="5" ry="3" fill="#F59E0B"/>
        <circle cx="20" cy="31" r="1" fill="#1E293B"/>
    """),
    "88-brainwave-sync": ("#06B6D4", "#8B5CF6", "#EC4899", """
        <path d="M16 32C20 20 24 44 28 32C32 20 36 44 40 32C44 20 48 44 52 32" stroke="url(#fgGrad)" stroke-width="3" stroke-linecap="round"/>
        <circle cx="32" cy="18" r="3" fill="#06B6D4"/>
    """),
    "89-singletask-spotlight": ("#F59E0B", "#EF4444", "#1E293B", """
        <polygon points="32,14 18,48 46,48" fill="url(#fgGrad)" opacity="0.4"/>
        <circle cx="32" cy="14" r="4" fill="#F59E0B"/>
        <rect x="28" y="42" width="8" height="8" rx="2" fill="white"/>
    """),
    "90-antiprocrastinate-friction": ("#F59E0B", "#EF4444", "#8B5CF6", """
        <path d="M22 18H42L34 32L42 46H22L30 32L22 18Z" fill="url(#fgGrad)"/>
        <circle cx="32" cy="40" r="2" fill="white"/>
    """),
    # 91-100
    "91-whitenoise-mixer": ("#10B981", "#06B6D4", "#3B82F6", """
        <path d="M16 26C18 22 22 22 24 26C26 30 30 30 32 26C34 22 38 22 40 26C42 30 46 30 48 26" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
        <path d="M16 34C18 30 22 30 24 34C26 38 30 38 32 34C34 30 38 30 40 34C42 38 46 38 48 34" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
        <path d="M16 42C18 38 22 38 24 42C26 46 30 46 32 42C34 38 38 38 40 42C42 46 46 46 48 42" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "92-tablimiter-pro": ("#EF4444", "#F59E0B", "#3B82F6", """
        <rect x="14" y="22" width="36" height="22" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <line x1="14" y1="28" x2="50" y2="28" stroke="url(#fgGrad)" stroke-width="2"/>
        <circle cx="20" cy="25" r="1.5" fill="#EF4444"/>
        <circle cx="25" cy="25" r="1.5" fill="#F59E0B"/>
        <circle cx="30" cy="25" r="1.5" fill="#10B981"/>
        <text x="27" y="40" fill="#EF4444" font-size="10" font-weight="bold">MAX 5</text>
    """),
    "93-eyeblink-coach": ("#06B6D4", "#3B82F6", "#8B5CF6", """
        <ellipse cx="32" cy="32" rx="16" ry="9" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <circle cx="32" cy="32" r="4.5" fill="#06B6D4"/>
        <line x1="32" y1="14" x2="32" y2="18" stroke="white" stroke-width="2" stroke-linecap="round"/>
    """),
    "94-focusheatmap": ("#EF4444", "#F59E0B", "#10B981", """
        <rect x="16" y="20" width="32" height="24" rx="4" fill="url(#fgGrad)"/>
        <circle cx="24" cy="28" r="4" fill="#EF4444"/>
        <circle cx="36" cy="34" r="5" fill="#F59E0B"/>
        <circle cx="28" cy="36" r="3" fill="#10B981"/>
    """),
    "95-morningkickoff-hud": ("#F59E0B", "#EF4444", "#FBBF24", """
        <circle cx="32" cy="36" r="12" fill="url(#fgGrad)"/>
        <line x1="16" y1="38" x2="48" y2="38" stroke="white" stroke-width="3" stroke-linecap="round"/>
        <line x1="32" y1="16" x2="32" y2="20" stroke="#F59E0B" stroke-width="2.5" stroke-linecap="round"/>
        <line x1="20" y1="20" x2="23" y2="23" stroke="#F59E0B" stroke-width="2.5" stroke-linecap="round"/>
        <line x1="44" y1="20" x2="41" y2="23" stroke="#F59E0B" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "96-microjournal-bar": ("#8B5CF6", "#EC4899", "#3B82F6", """
        <path d="M22 44L40 18L44 22L26 48L20 48L22 44Z" fill="url(#fgGrad)"/>
        <line x1="20" y1="52" x2="44" y2="52" stroke="white" stroke-width="2" stroke-linecap="round"/>
    """),
    "97-sugar-fasting-tracker": ("#10B981", "#F59E0B", "#EF4444", """
        <circle cx="32" cy="32" r="16" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <path d="M32 24C32 24 28 28 28 32C28 34.2 29.8 36 32 36C34.2 36 36 34.2 36 32C36 28 32 24 32 24Z" fill="#F59E0B"/>
    """),
    "98-sleephygiene-nudge": ("#6366F1", "#8B5CF6", "#F59E0B", """
        <path d="M36 18C28 18 22 24 22 32C22 40 28 46 36 46C39 46 42 45 44 43C38 42 34 38 34 32C34 26 38 22 44 21C42 19 39 18 36 18Z" fill="url(#fgGrad)"/>
        <circle cx="44" cy="20" r="1.5" fill="#F59E0B"/>
    """),
    "99-meetingprep-countdown": ("#EF4444", "#F59E0B", "#3B82F6", """
        <path d="M22 22H36V42H22V22Z" fill="url(#fgGrad)"/>
        <polygon points="36,28 44,22 44,42 36,36" fill="url(#fgGrad)"/>
        <circle cx="20" cy="18" r="4" fill="#EF4444"/>
    """),
    "100-stepcounter-sync": ("#10B981", "#3B82F6", "#06B6D4", """
        <path d="M18 38C22 38 24 34 28 34C32 34 34 38 46 38C46 42 42 46 36 46H22C18 46 16 42 18 38Z" fill="url(#fgGrad)"/>
        <line x1="22" y1="30" x2="26" y2="34" stroke="white" stroke-width="2"/>
        <line x1="28" y1="30" x2="32" y2="34" stroke="white" stroke-width="2"/>
    """),
    # 101-110
    "101-caffeinedecay-curve": ("#D97706", "#F59E0B", "#3B82F6", """
        <path d="M18 18V46H46" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
        <path d="M20 22C24 24 28 36 44 42" stroke="url(#fgGrad)" stroke-width="3.5" stroke-linecap="round"/>
    """),
    "102-cliptomarkdown-thread": ("#06B6D4", "#3B82F6", "#8B5CF6", """
        <rect x="18" y="16" width="28" height="32" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <text x="22" y="32" fill="url(#fgGrad)" font-size="12" font-weight="bold">#</text>
        <line x1="30" y1="28" x2="40" y2="28" stroke="white" stroke-width="2"/>
        <line x1="22" y1="38" x2="40" y2="38" stroke="white" stroke-width="2"/>
    """),
    "103-podcastchapter-marker": ("#8B5CF6", "#EC4899", "#F59E0B", """
        <line x1="16" y1="32" x2="48" y2="32" stroke="white" stroke-width="2"/>
        <path d="M26 32V20L34 24L26 28" fill="#F59E0B"/>
        <path d="M40 32V22L46 25L40 28" fill="#10B981"/>
    """),
    "104-teleprompter-hud": ("#10B981", "#06B6D4", "#3B82F6", """
        <rect x="16" y="18" width="32" height="28" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <line x1="22" y1="26" x2="42" y2="26" stroke="#10B981" stroke-width="2"/>
        <line x1="22" y1="32" x2="38" y2="32" stroke="#10B981" stroke-width="2"/>
        <line x1="22" y1="38" x2="40" y2="38" stroke="#10B981" stroke-width="2"/>
        <path d="M32 14V18M28 16L32 14L36 16" stroke="white" stroke-width="2"/>
    """),
    "105-quickpoll-creator": ("#F59E0B", "#EF4444", "#8B5CF6", """
        <rect x="18" y="34" width="6" height="14" rx="2" fill="#F59E0B"/>
        <rect x="29" y="24" width="6" height="24" rx="2" fill="#EF4444"/>
        <rect x="40" y="16" width="6" height="32" rx="2" fill="#10B981"/>
    """),
    "106-videothumbnail-tester": ("#EC4899", "#F43F5E", "#F59E0B", """
        <rect x="16" y="20" width="32" height="22" rx="4" fill="url(#fgGrad)"/>
        <circle cx="32" cy="31" r="6" fill="white"/>
        <circle cx="32" cy="31" r="3" fill="#EC4899"/>
    """),
    "107-discordrole-autoping": ("#5865F2", "#8B5CF6", "#EC4899", """
        <circle cx="32" cy="32" r="16" fill="url(#fgGrad)"/>
        <text x="24" y="39" fill="white" font-size="18" font-weight="bold">@</text>
    """),
    "108-watermarkmaster": ("#06B6D4", "#3B82F6", "#64748B", """
        <rect x="16" y="18" width="32" height="28" rx="4" fill="url(#fgGrad)" opacity="0.5"/>
        <path d="M20 40L44 24" stroke="white" stroke-width="3" stroke-linecap="round"/>
        <text x="24" y="30" fill="white" font-size="8" font-weight="bold">© PRO</text>
    """),
    "109-whispersubtitles-srt": ("#8B5CF6", "#EC4899", "#3B82F6", """
        <rect x="14" y="20" width="36" height="24" rx="4" fill="url(#fgGrad)"/>
        <rect x="20" y="34" width="24" height="6" rx="2" fill="white"/>
        <text x="22" y="39" fill="#1E293B" font-size="5" font-weight="bold">00:01:24</text>
    """),
    "110-summarizeurl-ai": ("#10B981", "#3B82F6", "#8B5CF6", """
        <rect x="18" y="16" width="28" height="32" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <circle cx="24" cy="24" r="2" fill="#10B981"/>
        <circle cx="24" cy="30" r="2" fill="#10B981"/>
        <circle cx="24" cy="36" r="2" fill="#10B981"/>
        <line x1="28" y1="24" x2="38" y2="24" stroke="white" stroke-width="2"/>
        <line x1="28" y1="30" x2="40" y2="30" stroke="white" stroke-width="2"/>
        <line x1="28" y1="36" x2="36" y2="36" stroke="white" stroke-width="2"/>
    """),
    # 111-120
    "111-sqlquery-ai": ("#06B6D4", "#3B82F6", "#10B981", """
        <ellipse cx="32" cy="20" rx="14" ry="5" fill="url(#fgGrad)"/>
        <path d="M18 20V32C18 34.5 24 37 32 37C40 37 46 34.5 46 32V20" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <text x="22" y="46" fill="white" font-size="8" font-family="monospace">SELECT *</text>
    """),
    "112-localembeddings-search": ("#8B5CF6", "#3B82F6", "#06B6D4", """
        <circle cx="22" cy="24" r="3" fill="#8B5CF6"/>
        <circle cx="42" cy="22" r="3" fill="#EC4899"/>
        <circle cx="36" cy="40" r="3" fill="#06B6D4"/>
        <circle cx="24" cy="42" r="3" fill="#10B981"/>
        <line x1="22" y1="24" x2="42" y2="22" stroke="white" stroke-width="1.5" opacity="0.6"/>
        <line x1="42" y1="22" x2="36" y2="40" stroke="white" stroke-width="1.5" opacity="0.6"/>
        <line x1="36" y1="40" x2="24" y2="42" stroke="white" stroke-width="1.5" opacity="0.6"/>
    """),
    "113-diffexplainer-ai": ("#F59E0B", "#10B981", "#EF4444", """
        <rect x="16" y="18" width="32" height="28" rx="4" fill="#0F172A"/>
        <text x="22" y="28" fill="#10B981" font-size="10" font-family="monospace">+ Added</text>
        <text x="22" y="38" fill="#EF4444" font-size="10" font-family="monospace">- Fix</text>
    """),
    "114-readaloud-tts": ("#EC4899", "#8B5CF6", "#3B82F6", """
        <path d="M18 26H26L34 20V44L26 38H18V26Z" fill="url(#fgGrad)"/>
        <path d="M38 26C41 28 41 36 38 38M42 22C46 26 46 38 42 42" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "115-regexgenerator-ai": ("#06B6D4", "#8B5CF6", "#EC4899", """
        <rect x="16" y="20" width="32" height="24" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <text x="20" y="35" fill="white" font-size="11" font-family="monospace">/[A-Z]+/</text>
    """),
    "116-kubecluster-quick": ("#326CE5", "#38BDF8", "#60A5FA", """
        <polygon points="32,16 46,24 46,40 32,48 18,40 18,24" fill="url(#fgGrad)"/>
        <circle cx="32" cy="32" r="5" fill="white"/>
    """),
    "117-redislens": ("#DC2626", "#EF4444", "#F87171", """
        <polygon points="32,16 48,24 32,32 16,24" fill="url(#fgGrad)"/>
        <polygon points="32,24 48,32 32,40 16,32" fill="url(#fgGrad)" opacity="0.8"/>
        <polygon points="32,32 48,40 32,48 16,40" fill="url(#fgGrad)" opacity="0.6"/>
    """),
    "118-gitstash-manager": ("#D97706", "#F59E0B", "#10B981", """
        <rect x="18" y="24" width="28" height="24" rx="3" fill="url(#fgGrad)"/>
        <path d="M22 24V18H42V24" stroke="white" stroke-width="2.5"/>
        <circle cx="32" cy="36" r="3" fill="#1E293B"/>
    """),
    "119-portforwarder-pro": ("#06B6D4", "#3B82F6", "#10B981", """
        <circle cx="20" cy="32" r="6" fill="url(#fgGrad)"/>
        <circle cx="44" cy="32" r="6" fill="url(#fgGrad)"/>
        <path d="M26 32H38M34 28L38 32L34 36" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
    """),
    "120-apimock-server": ("#10B981", "#06B6D4", "#3B82F6", """
        <rect x="16" y="20" width="32" height="24" rx="4" fill="url(#fgGrad)"/>
        <text x="21" y="35" fill="white" font-size="10" font-weight="bold" font-family="monospace">200 OK</text>
    """),
    # 121-130
    "121-dotenv-diff": ("#8B5CF6", "#3B82F6", "#F59E0B", """
        <rect x="16" y="18" width="14" height="28" rx="3" fill="url(#fgGrad)" opacity="0.6"/>
        <rect x="34" y="18" width="14" height="28" rx="3" fill="url(#fgGrad)"/>
        <line x1="20" y1="26" x2="26" y2="26" stroke="white" stroke-width="2"/>
        <line x1="38" y1="26" x2="44" y2="26" stroke="#F59E0B" stroke-width="2"/>
    """),
    "122-dnslookup-hud": ("#06B6D4", "#3B82F6", "#10B981", """
        <circle cx="32" cy="32" r="16" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <ellipse cx="32" cy="32" rx="7" ry="16" fill="none" stroke="url(#fgGrad)" stroke-width="2"/>
        <line x1="16" y1="32" x2="48" y2="32" stroke="url(#fgGrad)" stroke-width="2"/>
    """),
    "123-httpheader-inspector": ("#EF4444", "#F59E0B", "#3B82F6", """
        <rect x="16" y="18" width="32" height="28" rx="4" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <text x="20" y="32" fill="#10B981" font-size="8" font-family="monospace">HTTP/2</text>
        <text x="20" y="40" fill="white" font-size="7" font-family="monospace">SSL: OK</text>
    """),
    "124-icongrid-overlay": ("#6366F1", "#8B5CF6", "#06B6D4", """
        <rect x="16" y="16" width="32" height="32" rx="8" fill="none" stroke="url(#fgGrad)" stroke-width="2"/>
        <circle cx="32" cy="32" r="16" fill="none" stroke="white" stroke-width="1" stroke-dasharray="2 2"/>
        <circle cx="32" cy="32" r="8" fill="none" stroke="white" stroke-width="1" stroke-dasharray="2 2"/>
        <line x1="32" y1="16" x2="32" y2="48" stroke="white" stroke-width="1" stroke-dasharray="2 2"/>
        <line x1="16" y1="32" x2="48" y2="32" stroke="white" stroke-width="1" stroke-dasharray="2 2"/>
    """),
    "125-contrastpalette-studio": ("#10B981", "#3B82F6", "#F59E0B", """
        <rect x="16" y="20" width="14" height="24" rx="3" fill="#1E293B"/>
        <rect x="34" y="20" width="14" height="24" rx="3" fill="#F8FAFC"/>
        <text x="20" y="34" fill="#10B981" font-size="8" font-weight="bold">AAA</text>
        <text x="37" y="34" fill="#0F172A" font-size="8" font-weight="bold">7.4</text>
    """),
    "126-gradientmesh-maker": ("#EC4899", "#8B5CF6", "#06B6D4", """
        <circle cx="22" cy="22" r="6" fill="#EC4899"/>
        <circle cx="42" cy="22" r="6" fill="#F59E0B"/>
        <circle cx="22" cy="42" r="6" fill="#06B6D4"/>
        <circle cx="42" cy="42" r="6" fill="#10B981"/>
        <line x1="22" y1="22" x2="42" y2="22" stroke="white" stroke-width="1.5"/>
        <line x1="22" y1="42" x2="42" y2="42" stroke="white" stroke-width="1.5"/>
        <line x1="22" y1="22" x2="22" y2="42" stroke="white" stroke-width="1.5"/>
        <line x1="42" y1="22" x2="42" y2="42" stroke="white" stroke-width="1.5"/>
    """),
    "127-diskscleaner-mini": ("#EF4444", "#F59E0B", "#3B82F6", """
        <circle cx="32" cy="32" r="16" fill="url(#fgGrad)"/>
        <path d="M32 32L48 32A16 16 0 0 0 32 16Z" fill="#EF4444"/>
    """),
    "128-bluetoothsignal-radar": ("#06B6D4", "#3B82F6", "#10B981", """
        <path d="M26 22L36 32L32 36V16L36 20L26 30" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
        <path d="M42 24C46 28 46 36 42 40M46 20C52 26 52 44 46 50" stroke="white" stroke-width="2" stroke-linecap="round"/>
    """),
    "129-batterycycle-telemetry": ("#10B981", "#3B82F6", "#06B6D4", """
        <rect x="18" y="24" width="26" height="16" rx="3" fill="none" stroke="url(#fgGrad)" stroke-width="2.5"/>
        <path d="M44 29V35" stroke="url(#fgGrad)" stroke-width="2.5" stroke-linecap="round"/>
        <path d="M22 34C26 34 28 28 32 28C36 28 38 34 40 34" stroke="#10B981" stroke-width="2" stroke-linecap="round"/>
    """),
    "130-appquarantine-inspector": ("#F59E0B", "#EF4444", "#8B5CF6", """
        <polygon points="32,16 48,44 16,44" fill="none" stroke="url(#fgGrad)" stroke-width="3"/>
        <line x1="32" y1="26" x2="32" y2="34" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
        <circle cx="32" cy="39" r="1.5" fill="white"/>
    """)
}

# Write each SVG
count = 0
for app_id, (g1, g2, g3, glyph) in icons_db.items():
    svg_code = create_svg(app_id, g1, g2, g3, glyph)
    with open(f"{ICONS_DIR}/{app_id}.svg", "w") as f:
        f.write(svg_code)
    count += 1

print(f"🎨 Successfully generated {count} 100% bespoke, individual, creative SVG vector icons in {ICONS_DIR}/")
