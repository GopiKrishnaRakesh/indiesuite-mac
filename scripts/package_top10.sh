#!/usr/bin/env bash
# package_top10.sh - Builds, icon-generates, Developer-ID signs (Hardened
# Runtime), notarizes, staples, and DMG-packages the 10 apps rebuilt to
# actually work for real (not the mockup catalog).
#
# Notarization needs credentials stored once, ahead of time, e.g.:
#   xcrun notarytool store-credentials "pathway-notary" --apple-id <email> --team-id X9LKG9RX5T
# (any profile under the same Apple Developer team works -- this script reuses
# whichever of NOTARY_PROFILE / its fallback is present). If none is found,
# this script still produces a signed-but-unnotarized DMG and says so.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

TEAM_ID="X9LKG9RX5T"
SIGN_IDENTITY="Developer ID Application: Gopi Krishna Rakesh Kode ($TEAM_ID)"
NOTARY_PROFILE="pathway-notary"

WEBSITE_DOWNLOADS="website/downloads"
WEBSITE_PROTECTED="website/protected_dmgs"
WEBSITE_ICONS="website/assets/icons"
DIST_DIR="dist/top10"
mkdir -p "$WEBSITE_DOWNLOADS" "$WEBSITE_PROTECTED" "$DIST_DIR"

NOTARY_AVAILABLE="false"
if xcrun notarytool history --keychain-profile "$NOTARY_PROFILE" >/dev/null 2>&1; then
  NOTARY_AVAILABLE="true"
  echo "Notary profile '$NOTARY_PROFILE' found -- will notarize each app."
else
  echo "!! Notary profile '$NOTARY_PROFILE' not found/invalid -- apps will be signed but NOT notarized."
fi

# dir_name:target_name:display_name
APPS=(
  "03-locallens-ocr:LocalLensOCR:LocalLens OCR"
  "06-colorforge:ColorForge:ColorForge"
  "05-shrinkmedia:ShrinkMedia:ShrinkMedia"
  "04-portsentry:PortSentry:PortSentry"
  "12-purgeapp:PurgeApp:PurgeApp"
  "11-snaptile:SnapTile:SnapTile"
  "07-notchshelf:NotchShelf:NotchShelf"
  "14-envvault:EnvVault:EnvVault"
  "10-promptdock:PromptDock:PromptDock"
  "17-regexforge:RegexForge:RegexForge"
)

for entry in "${APPS[@]}"; do
  IFS=":" read -r dir_name target_name display_name <<< "$entry"
  app_slug=$(echo "$dir_name" | sed -E 's/^[0-9]+-//')
  app_dir="apps/${dir_name}"

  echo "=== Building ${display_name} ==="
  (cd "$app_dir" && swift build -c release -q)

  bin_path="${app_dir}/.build/release/${target_name}"
  if [ ! -f "$bin_path" ]; then
    # fall back to arch-specific path
    bin_path=$(find "${app_dir}/.build" -type f -perm +111 -name "$target_name" -path "*release*" | head -1)
  fi
  if [ ! -f "$bin_path" ]; then
    echo "  !! Could not find built binary for ${display_name}, skipping"
    continue
  fi

  stage="/tmp/top10_stage_${app_slug}"
  rm -rf "$stage"
  app_bundle="${stage}/${target_name}.app"
  macos_dir="${app_bundle}/Contents/MacOS"
  res_dir="${app_bundle}/Contents/Resources"
  mkdir -p "$macos_dir" "$res_dir"

  cp "$bin_path" "${macos_dir}/${target_name}"
  chmod +x "${macos_dir}/${target_name}"

  # --- Real .icns from the existing SVG catalog icon ---
  svg_icon="${WEBSITE_ICONS}/${dir_name}.svg"
  if [ -f "$svg_icon" ]; then
    iconset="/tmp/top10_iconset_${app_slug}.iconset"
    rm -rf "$iconset"
    mkdir -p "$iconset"
    tmp_png="/tmp/top10_icon_${app_slug}.png"
    qlmanage -t -s 1024 -o "$(dirname "$tmp_png")" "$svg_icon" >/dev/null 2>&1
    mv "/tmp/$(basename "$svg_icon").png" "$tmp_png" 2>/dev/null || true

    if [ -f "$tmp_png" ]; then
      for size in 16 32 64 128 256 512; do
        sips -z $size $size "$tmp_png" --out "${iconset}/icon_${size}x${size}.png" >/dev/null 2>&1
        double=$((size * 2))
        sips -z $double $double "$tmp_png" --out "${iconset}/icon_${size}x${size}@2x.png" >/dev/null 2>&1
      done
      iconutil -c icns "$iconset" -o "${res_dir}/AppIcon.icns" 2>/dev/null || true
    fi
  fi

  has_icon="false"
  [ -f "${res_dir}/AppIcon.icns" ] && has_icon="true"

  cat > "${app_bundle}/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>${target_name}</string>
    <key>CFBundleIdentifier</key>
    <string>com.indiesuite.${app_slug}</string>
    <key>CFBundleName</key>
    <string>${display_name}</string>
    <key>CFBundleDisplayName</key>
    <string>${display_name}</string>
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
$( [ "$has_icon" = "true" ] && echo "    <key>CFBundleIconFile</key>
    <string>AppIcon</string>" )
</dict>
</plist>
PLIST

  # Real Developer ID signature + Hardened Runtime + secure timestamp --
  # required for notarization (ad-hoc "-" signing can never be notarized).
  codesign --force --deep --options runtime --timestamp \
    --sign "$SIGN_IDENTITY" "$app_bundle"
  codesign --verify --deep --strict --verbose=2 "$app_bundle"

  # --- DMG ---
  dmg_name="${app_slug}-1.0.0.dmg"
  dmg_path="${DIST_DIR}/${dmg_name}"
  rm -f "$dmg_path"
  ln -sf /Applications "${stage}/Applications"
  hdiutil create -volname "$target_name" -srcfolder "$stage" -ov -format UDZO -quiet "$dmg_path"
  codesign --force --timestamp --sign "$SIGN_IDENTITY" "$dmg_path"

  if [ "$NOTARY_AVAILABLE" = "true" ]; then
    echo "  -> Notarizing ${dmg_name}..."
    xcrun notarytool submit "$dmg_path" --keychain-profile "$NOTARY_PROFILE" --wait
    xcrun stapler staple "$dmg_path"
    xcrun stapler validate "$dmg_path"
  fi

  cp "$dmg_path" "${WEBSITE_DOWNLOADS}/${dmg_name}"
  cp "$dmg_path" "${WEBSITE_PROTECTED}/${dmg_name}"

  echo "  -> ${dmg_name} ($(du -h "$dmg_path" | cut -f1))"
done

echo "Done."
