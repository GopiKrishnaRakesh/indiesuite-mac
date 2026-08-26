#!/usr/bin/env bash
# package_all_dmgs.sh - High-speed DMG Packager for all 130 apps
set -e

DIST_DIR="./dist/dmgs"
WEBSITE_DOWNLOADS="./website/downloads"
mkdir -p "$DIST_DIR"
mkdir -p "$WEBSITE_DOWNLOADS"

echo "📦 Packaging all 130 macOS Apps into production .dmg files..."

COUNT=0
for app_dir in apps/*; do
    if [ -d "$app_dir" ]; then
        dir_name=$(basename "$app_dir")
        app_slug=$(echo "$dir_name" | sed -E 's/^[0-9]+-//')
        
        # Get target name from Package.swift
        target_name=$(grep -E 'executableTarget\(name: "[^"]+"' "$app_dir/Package.swift" | sed -E 's/.*name: "([^"]+)".*/\1/')
        if [ -z "$target_name" ]; then
            target_name=$(grep -E 'products: \[\.executable\(name: "[^"]+"' "$app_dir/Package.swift" | sed -E 's/.*name: "([^"]+)".*/\1/')
        fi
        if [ -z "$target_name" ]; then
            target_name=$(echo "$app_slug" | awk -F'-' '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1' OFS='')
        fi

        # Locate binary in common SPM build folders
        bin_path=""
        for candidate in \
            "$app_dir/.build/out/Products/Debug/$target_name" \
            "$app_dir/.build/out/Products/Release/$target_name" \
            "$app_dir/.build/arm64-apple-macosx/debug/$target_name" \
            "$app_dir/.build/debug/$target_name"; do
            if [ -f "$candidate" ] && [ -x "$candidate" ]; then
                bin_path="$candidate"
                break
            fi
        done

        # If not found, build now
        if [ -z "$bin_path" ]; then
            (cd "$app_dir" && swift build -q)
            for candidate in \
                "$app_dir/.build/out/Products/Debug/$target_name" \
                "$app_dir/.build/arm64-apple-macosx/debug/$target_name" \
                "$app_dir/.build/debug/$target_name"; do
                if [ -f "$candidate" ] && [ -x "$candidate" ]; then
                    bin_path="$candidate"
                    break
                fi
            done
        fi

        DMG_NAME="${app_slug}-1.0.0.dmg"
        DMG_PATH="${DIST_DIR}/${DMG_NAME}"
        TEMP_DIR=$(mktemp -d /tmp/dmg-pack-XXXXXX)
        APP_BUNDLE="${TEMP_DIR}/${target_name}.app"
        
        mkdir -p "${APP_BUNDLE}/Contents/MacOS"
        mkdir -p "${APP_BUNDLE}/Contents/Resources"
        
        # Copy binary
        if [ -n "$bin_path" ] && [ -f "$bin_path" ]; then
            cp "$bin_path" "${APP_BUNDLE}/Contents/MacOS/${target_name}"
            chmod +x "${APP_BUNDLE}/Contents/MacOS/${target_name}"
        fi
        
        # Copy icon if available
        if [ -f "website/assets/icons/${dir_name}.svg" ]; then
            cp "website/assets/icons/${dir_name}.svg" "${APP_BUNDLE}/Contents/Resources/AppIcon.svg"
        fi

        # Info.plist
        cat <<EOF > "${APP_BUNDLE}/Contents/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>${target_name}</string>
    <key>CFBundleIdentifier</key>
    <string>com.indiesuite.${app_slug}</string>
    <key>CFBundleName</key>
    <string>${target_name}</string>
    <key>CFBundleDisplayName</key>
    <string>${target_name}</string>
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
EOF

        # Applications symlink
        ln -s /Applications "${TEMP_DIR}/Applications"

        # Create compressed DMG
        rm -f "${DMG_PATH}"
        hdiutil create -volname "${target_name}" -srcfolder "${TEMP_DIR}" -ov -format UDZO -quiet "${DMG_PATH}"
        
        # Sync to website downloads
        cp "${DMG_PATH}" "${WEBSITE_DOWNLOADS}/${DMG_NAME}"
        rm -rf "${TEMP_DIR}"

        COUNT=$((COUNT + 1))
        echo "  [$COUNT/130] 🚀 Built ${DMG_NAME}"
    fi
done

echo "🎉 All $COUNT production .dmg installers successfully created in $DIST_DIR and $WEBSITE_DOWNLOADS!"
