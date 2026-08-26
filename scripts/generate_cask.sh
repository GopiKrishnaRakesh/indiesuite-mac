#!/usr/bin/env bash
# generate_cask.sh - Generates Homebrew Cask files for direct Mac terminal distribution
set -e

CASK_DIR="./dist/casks"
mkdir -p "$CASK_DIR"

APPS=(
    "whispertap:Global Push-to-Talk AI Dictation into any text field"
    "tokenwatch:Menu bar real-time LLM API spend & rate-limit monitor"
    "locallens-ocr:Instant screen-to-code, LaTeX, JSON, and table extractor"
    "portsentry:Menu bar active port & zombie process killer"
    "shrinkmedia:Fast batch video/audio/image compressor & GIF converter"
    "colorforge:Native eyedropper, palette builder, and contrast checker"
    "notchshelf:Smart drop-zone & staging area inside the MacBook notch"
    "audiomix:Per-app volume mixer & independent audio output routing"
    "micmute-hud:Universal hardware mic mute & camera blackout indicator"
    "promptdock:Global floating prompt HUD and snippet palette"
    "snaptile:Hyper-lightweight keyboard & edge window tiling manager"
    "purgeapp:Deep uninstaller tracking hidden caches and plists"
    "chargeguard:Battery health optimizer & custom charge threshold limiter"
    "envvault:Secure .env & API key workspace manager"
    "devtunnel-hud:Menu bar manager & traffic inspector for tunnels"
    "gitpulse:Multi-repo status bar tracker for git repositories"
    "regexforge:Native Swift live regex debugger & visual tester"
    "svgoptim:Zero-bloat SVG optimizer and SwiftUI/React component generator"
    "fontinspect:Local font viewer, glyph explorer, and variable font tester"
    "presentercam:Floating camera overlay with background blur & spotlight"
    "cleandesk-pro:1-click presentation mode and clutter cleaner"
    "screenruler:Precision on-screen pixel measurement ruler & crosshair"
    "apphop:Quick-switch popup between windows of active workspace"
    "scratchpad-hud:Always-on-top markdown floating scratchpad"
    "timebridge:Visual timezone slider and meeting overlap calculator"
    "menucleaner:Lightweight menu bar icon manager and hider"
    "metascrub:Instant EXIF, GPS location, and privacy metadata stripper"
    "bandwidthradar:Real-time per-app network download/upload monitor"
    "bluetoothautohop:Smart Bluetooth auto-disconnect and reconnect manager"
    "privatellm-bar:Ultra-lightweight menu bar local model runner"
)

echo "🍺 Generating Homebrew Casks..."

for item in "${APPS[@]}"; do
    name=$(echo "$item" | cut -d: -f1)
    desc=$(echo "$item" | cut -d: -f2)
    displayName=$(echo "$name" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
    
    cat <<EOF > "${CASK_DIR}/${name}.rb"
cask "${name}" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/${name}-1.0.0.dmg"
  name "${displayName}"
  desc "${desc}"
  homepage "https://indiesuite.app/apps/${name}"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "${displayName}.app"

  zap trash: [
    "~/Library/Application Support/${name}",
    "~/Library/Preferences/com.indiesuite.${name}.plist",
  ]
end
EOF
    echo "  -> Created ${CASK_DIR}/${name}.rb"
done

echo "✅ Generated 30 Homebrew Casks!"
