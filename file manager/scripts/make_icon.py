#!/usr/bin/env python3
"""Generates Pathway's app icon → Sources/Assets.xcassets/AppIcon.appiconset. Run: python3 scripts/make_icon.py"""
import json, math, os
from PIL import Image, ImageDraw, ImageFilter

S = 4                      # supersampling
N = 1024 * S
OUT = os.path.join(os.path.dirname(__file__), "..", "Sources", "Assets.xcassets", "AppIcon.appiconset")

def lerp(a, b, t): return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(len(a)))

def vgradient(w, h, top, bottom):
    strip = Image.new("RGBA", (1, h))
    for y in range(h):
        strip.putpixel((0, y), lerp(top, bottom, y / max(h - 1, 1)))
    return strip.resize((w, h))

def squircle_mask(size, n=5.0):
    m = Image.new("L", (size, size), 0)
    r = size / 2
    pts = []
    for i in range(720):
        t = i / 720 * 2 * math.pi
        c, s = math.cos(t), math.sin(t)
        pts.append((r + r * math.copysign(abs(c) ** (2 / n), c), r + r * math.copysign(abs(s) ** (2 / n), s)))
    ImageDraw.Draw(m).polygon(pts, fill=255)
    return m

canvas = Image.new("RGBA", (N, N), (0, 0, 0, 0))

# Apple's macOS template: 824pt squircle centred in 1024
body = 824 * S
off = (N - body) // 2
mask = squircle_mask(body)

# soft drop shadow
shadow = Image.new("RGBA", (N, N), (0, 0, 0, 0))
shadow.paste((0, 0, 0, 110), (off, off + 14 * S), mask)
canvas.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(22 * S)))

# background gradient
bg = vgradient(body, body, (86, 190, 255, 255), (22, 84, 226, 255))
tile = Image.new("RGBA", (body, body), (0, 0, 0, 0))
tile.paste(bg, (0, 0), mask)

# subtle top sheen
sheen = Image.new("RGBA", (body, body), (0, 0, 0, 0))
ImageDraw.Draw(sheen).ellipse((-body * 0.2, -body * 0.75, body * 1.2, body * 0.42), fill=(255, 255, 255, 60))
sheen = sheen.filter(ImageFilter.GaussianBlur(40 * S))
tile.alpha_composite(Image.composite(sheen, Image.new("RGBA", (body, body), (0, 0, 0, 0)), mask))

d = ImageDraw.Draw(tile)
cx = body // 2

# folder geometry (in tile coords)
fw, fh = 560 * S, 400 * S
fx, fy = cx - fw // 2, int(body * 0.5 - fh * 0.42)
r = 46 * S
tab_w, tab_h = 210 * S, 70 * S

# back panel + tab (light, slightly translucent blue-white)
d.rounded_rectangle((fx, fy - tab_h + r, fx + tab_w, fy + r * 2), r, fill=(206, 232, 255, 255))
d.rounded_rectangle((fx, fy, fx + fw, fy + fh), r, fill=(206, 232, 255, 255))

# front panel with vertical gradient
front_h = int(fh * 0.8)
fy2 = fy + fh - front_h
panel = vgradient(fw, front_h, (255, 255, 255, 255), (222, 238, 255, 255))
pmask = Image.new("L", (fw, front_h), 0)
ImageDraw.Draw(pmask).rounded_rectangle((0, 0, fw - 1, front_h - 1), r, fill=255)
# soft shadow under front panel top edge
edge = Image.new("RGBA", tile.size, (0, 0, 0, 0))
ImageDraw.Draw(edge).rounded_rectangle((fx, fy2 - 8 * S, fx + fw, fy2 + front_h), r, fill=(10, 50, 140, 70))
tile.alpha_composite(edge.filter(ImageFilter.GaussianBlur(10 * S)))
tile.paste(panel, (fx, fy2), pmask)

# breadcrumb trail: three chevrons, fading in toward the destination
def chevron(x, y, h, w, color):
    layer = Image.new("RGBA", tile.size, (0, 0, 0, 0))
    ld = ImageDraw.Draw(layer)
    width = 40 * S
    ld.line([(x - w, y - h), (x, y), (x - w, y + h)], fill=color, width=width, joint="curve")
    for px, py in [(x - w, y - h), (x, y), (x - w, y + h)]:
        ld.ellipse((px - width // 2, py - width // 2, px + width // 2, py + width // 2), fill=color)
    tile.alpha_composite(layer)

mid_y = fy2 + front_h // 2
ch_h, ch_w, gap = 62 * S, 46 * S, 92 * S
start_x = cx - gap + ch_w // 2
for i, alpha in enumerate((110, 190, 255)):
    chevron(start_x + i * gap, mid_y, ch_h, ch_w, (24, 92, 226, alpha))

canvas.alpha_composite(tile, (off, off))
master = canvas.resize((1024, 1024), Image.LANCZOS)

os.makedirs(OUT, exist_ok=True)
images = []
for pt in (16, 32, 128, 256, 512):
    for scale in (1, 2):
        px = pt * scale
        name = f"icon_{pt}x{pt}{'@2x' if scale == 2 else ''}.png"
        master.resize((px, px), Image.LANCZOS).save(os.path.join(OUT, name))
        images.append({"idiom": "mac", "size": f"{pt}x{pt}", "scale": f"{scale}x", "filename": name})
json.dump({"images": images, "info": {"version": 1, "author": "xcode"}}, open(os.path.join(OUT, "Contents.json"), "w"), indent=2)
master.save(os.path.join(os.path.dirname(__file__), "icon_preview_1024.png"))
print("wrote", len(images), "icon sizes")
