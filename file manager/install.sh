#!/bin/bash
set -e

# ==============================================================================
# Pathway - Automated One-Line Installer
# Installs Pathway directly from the GitHub repository into /Applications
# Usage: curl -fsSL https://raw.githubusercontent.com/GopiKrishnaRakesh/indiesuite-mac/main/file%20manager/install.sh | bash
# ==============================================================================

echo "🍏 Installing Pathway for macOS..."

TMP_DIR=$(mktemp -d)
DMG_PATH="$TMP_DIR/Pathway.dmg"
MOUNT_DIR="$TMP_DIR/mount"

cleanup() {
    if [ -d "$MOUNT_DIR" ]; then
        hdiutil detach "$MOUNT_DIR" -quiet 2>/dev/null || true
    fi
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

DMG_URL="https://github.com/GopiKrishnaRakesh/indiesuite-mac/raw/main/file%20manager/dist/Pathway-1.0.0.dmg"

echo "⬇️  Downloading Pathway (Universal Binary)..."
curl -fL --progress-bar "$DMG_URL" -o "$DMG_PATH"

echo "📦 Mounting disk image..."
mkdir -p "$MOUNT_DIR"
hdiutil attach "$DMG_PATH" -nobrowse -mountpoint "$MOUNT_DIR" -quiet

echo "🚀 Installing Pathway to /Applications/Pathway.app..."
rm -rf /Applications/Pathway.app
cp -R "$MOUNT_DIR/Pathway.app" /Applications/

echo "🧹 Ejecting installer..."
hdiutil detach "$MOUNT_DIR" -quiet

echo "✨ Pathway successfully installed!"
echo "🎉 Launching Pathway..."
open -a Pathway || true
