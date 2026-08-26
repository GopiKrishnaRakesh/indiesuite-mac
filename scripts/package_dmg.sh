#!/usr/bin/env bash
# package_dmg.sh - Universal DMG packager for macOS apps
set -e

APP_NAME="$1"
VERSION="${2:-1.0.0}"
APP_BUNDLE_PATH="$3"
OUTPUT_DIR="${4:-./dist}"

if [ -z "$APP_NAME" ]; then
    echo "Usage: ./package_dmg.sh <AppName> [Version] [AppBundlePath] [OutputDir]"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"
DMG_NAME="${APP_NAME}-${VERSION}.dmg"
DMG_PATH="${OUTPUT_DIR}/${DMG_NAME}"
TEMP_DIR=$(mktemp -d /tmp/dmg-build-XXXXXX)

echo "📦 Packaging ${APP_NAME} v${VERSION} into ${DMG_PATH}..."

# Setup temporary staging folder
mkdir -p "${TEMP_DIR}/${APP_NAME}.app"
if [ -n "$APP_BUNDLE_PATH" ] && [ -d "$APP_BUNDLE_PATH" ]; then
    cp -R "$APP_BUNDLE_PATH/" "${TEMP_DIR}/${APP_NAME}.app/"
fi

# Create symlink to /Applications
ln -s /Applications "${TEMP_DIR}/Applications"

# Create disk image
hdiutil create -volname "${APP_NAME}" -srcfolder "${TEMP_DIR}" -ov -format UDZO "${DMG_PATH}"

# Cleanup
rm -rf "${TEMP_DIR}"

echo "✅ Successfully built DMG: ${DMG_PATH}"
