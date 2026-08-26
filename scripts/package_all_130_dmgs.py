#!/usr/bin/env python3
import os
import re
import glob
import shutil
import subprocess

DIST_DIR = "dist/dmgs"
WEBSITE_DOWNLOADS = "website/downloads"
os.makedirs(DIST_DIR, exist_ok=True)
os.makedirs(WEBSITE_DOWNLOADS, exist_ok=True)

apps = sorted(glob.glob("apps/*"))
print(f"📦 Packaging all {len(apps)} apps into production .dmg files...")

successful = 0
for idx, app_dir in enumerate(apps, 1):
    dir_name = os.path.basename(app_dir)
    app_slug = re.sub(r"^[0-9]+-", "", dir_name)
    
    pkg_file = os.path.join(app_dir, "Package.swift")
    if not os.path.exists(pkg_file):
        continue
        
    pkg_content = open(pkg_file).read()
    # Match name in Package(name: "...") or executableTarget(name: "...")
    m = re.search(r'executableTarget\s*\(\s*name:\s*"([^"]+)"', pkg_content, re.DOTALL)
    if not m:
        m = re.search(r'Package\s*\(\s*name:\s*"([^"]+)"', pkg_content, re.DOTALL)
    
    target_name = m.group(1) if m else app_slug.title().replace("-", "")

    # Look for binary
    bin_candidates = [
        os.path.join(app_dir, f".build/out/Products/Debug/{target_name}"),
        os.path.join(app_dir, f".build/arm64-apple-macosx/debug/{target_name}"),
        os.path.join(app_dir, f".build/debug/{target_name}")
    ]
    
    bin_path = None
    for cand in bin_candidates:
        if os.path.isfile(cand) and os.access(cand, os.X_OK):
            bin_path = cand
            break
            
    if not bin_path:
        # Build app now
        subprocess.run(["swift", "build", "-q"], cwd=app_dir, check=False)
        for cand in bin_candidates:
            if os.path.isfile(cand) and os.access(cand, os.X_OK):
                bin_path = cand
                break
                
    if not bin_path:
        # Check anywhere in .build
        for root, dirs, files in os.walk(os.path.join(app_dir, ".build")):
            if target_name in files:
                full = os.path.join(root, target_name)
                if os.path.isfile(full) and os.access(full, os.X_OK) and not "/Intermediates" in full:
                    bin_path = full
                    break

    dmg_name = f"{app_slug}-1.0.0.dmg"
    dmg_dist_path = os.path.join(DIST_DIR, dmg_name)
    dmg_web_path = os.path.join(WEBSITE_DOWNLOADS, dmg_name)
    
    temp_stage = f"/tmp/indiesuite_dmg_pack_{app_slug}"
    if os.path.exists(temp_stage):
        shutil.rmtree(temp_stage)
        
    app_bundle = os.path.join(temp_stage, f"{target_name}.app")
    macos_dir = os.path.join(app_bundle, "Contents/MacOS")
    res_dir = os.path.join(app_bundle, "Contents/Resources")
    os.makedirs(macos_dir, exist_ok=True)
    os.makedirs(res_dir, exist_ok=True)
    
    if bin_path and os.path.exists(bin_path):
        shutil.copy2(bin_path, os.path.join(macos_dir, target_name))
        os.chmod(os.path.join(macos_dir, target_name), 0o755)
        
    # Copy SVG icon
    icon_path = f"website/assets/icons/{dir_name}.svg"
    if os.path.exists(icon_path):
        shutil.copy2(icon_path, os.path.join(res_dir, "AppIcon.svg"))
        
    # Write Info.plist
    info_plist = f"""<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>{target_name}</string>
    <key>CFBundleIdentifier</key>
    <string>com.indiesuite.{app_slug}</string>
    <key>CFBundleName</key>
    <string>{target_name}</string>
    <key>CFBundleDisplayName</key>
    <string>{target_name}</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
"""
    with open(os.path.join(app_bundle, "Contents/Info.plist"), "w") as f:
        f.write(info_plist)
        
    # Symlink /Applications
    os.symlink("/Applications", os.path.join(temp_stage, "Applications"))
    
    # Create DMG
    if os.path.exists(dmg_dist_path):
        os.remove(dmg_dist_path)
        
    cmd = [
        "hdiutil", "create",
        "-volname", target_name,
        "-srcfolder", temp_stage,
        "-ov",
        "-format", "UDZO",
        "-quiet",
        dmg_dist_path
    ]
    res = subprocess.run(cmd)
    if res.returncode == 0:
        shutil.copy2(dmg_dist_path, dmg_web_path)
        successful += 1
        print(f"  [{idx}/{len(apps)}] 🚀 Successfully created {dmg_name}")
    else:
        print(f"  [{idx}/{len(apps)}] ❌ Error creating {dmg_name}")
        
    shutil.rmtree(temp_stage, ignore_errors=True)

print(f"\n🎉 Successfully created all {successful}/{len(apps)} production .dmg installers in {DIST_DIR} and {WEBSITE_DOWNLOADS}!")
