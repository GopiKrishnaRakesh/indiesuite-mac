#!/bin/bash
set -e

# ==============================================================================
# Pathway - Automated Standalone Installer
# Installs Pathway directly into /Applications
# Usage:
#   Local:   ./install.sh
#   Remote:  curl -fsSL https://raw.githubusercontent.com/GopiKrishnaRakesh/indiesuite-mac/main/file%20manager/install.sh | bash
# ==============================================================================

echo "🍏 Installing Pathway for macOS..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
LOCAL_APP="$SCRIPT_DIR/Build/Build/Products/Release/Pathway.app"
LOCAL_DMG="$SCRIPT_DIR/dist/Pathway-1.0.0.dmg"
LOCAL_CANONICAL_DMG="$SCRIPT_DIR/dist/Pathway.dmg"

install_from_bundle() {
    local src="$1"
    echo "🚀 Installing Pathway to /Applications/Pathway.app..."
    rm -rf /Applications/Pathway.app
    cp -R "$src" /Applications/
    # Strip quarantine attribute to prevent Gatekeeper blockage
    xattr -dr com.apple.quarantine /Applications/Pathway.app 2>/dev/null || true
    echo "✨ Pathway successfully installed to /Applications/Pathway.app!"

    # Install CLI shortcut if possible
    if [ -w "/usr/local/bin" ]; then
        ln -sf "/Applications/Pathway.app/Contents/MacOS/Pathway" "/usr/local/bin/pathway" 2>/dev/null || true
    elif [ -d "$HOME/.local/bin" ]; then
        ln -sf "/Applications/Pathway.app/Contents/MacOS/Pathway" "$HOME/.local/bin/pathway" 2>/dev/null || true
    fi

    echo "🎉 Launching Pathway..."
    open -a Pathway || true
}

# 1. If running locally from repo with a release build:
if [ -d "$LOCAL_APP" ]; then
    echo "📦 Found local release build: $LOCAL_APP"
    install_from_bundle "$LOCAL_APP"
    exit 0
fi

# 2. If running locally from repo with a built DMG:
TARGET_DMG=""
if [ -f "$LOCAL_DMG" ]; then TARGET_DMG="$LOCAL_DMG"; fi
if [ -f "$LOCAL_CANONICAL_DMG" ]; then TARGET_DMG="$LOCAL_CANONICAL_DMG"; fi

if [ -n "$TARGET_DMG" ]; then
    echo "📦 Found local disk image: $TARGET_DMG"
    MOUNT_DIR=$(mktemp -d)
    hdiutil attach "$TARGET_DMG" -nobrowse -mountpoint "$MOUNT_DIR" -quiet
    install_from_bundle "$MOUNT_DIR/Pathway.app"
    hdiutil detach "$MOUNT_DIR" -quiet 2>/dev/null || true
    rm -rf "$MOUNT_DIR"
    exit 0
fi

# 3. Running remotely via curl: download DMG from GitHub releases / raw repo
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

RELEASE_DMG_URL="https://github.com/GopiKrishnaRakesh/indiesuite-mac/releases/latest/download/Pathway-1.0.0.dmg"
RAW_DMG_URL="https://github.com/GopiKrishnaRakesh/indiesuite-mac/raw/main/file%20manager/dist/Pathway-1.0.0.dmg"

echo "⬇️  Downloading Pathway (Universal Binary)..."
if ! curl -fL --progress-bar "$RELEASE_DMG_URL" -o "$DMG_PATH" 2>/dev/null; then
    curl -fL --progress-bar "$RAW_DMG_URL" -o "$DMG_PATH"
fi

echo "📦 Mounting disk image..."
mkdir -p "$MOUNT_DIR"
hdiutil attach "$DMG_PATH" -nobrowse -mountpoint "$MOUNT_DIR" -quiet

install_from_bundle "$MOUNT_DIR/Pathway.app"

echo "🧹 Ejecting installer..."
hdiutil detach "$MOUNT_DIR" -quiet

