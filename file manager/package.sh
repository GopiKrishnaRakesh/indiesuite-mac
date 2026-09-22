#!/bin/bash
# Builds a Developer ID-signed Release build of Pathway and packages it into dist/Pathway.dmg.
# Does its own clean build from scratch -- no need to run build.sh first.
#
# NOT notarized by this script -- that needs credentials stored separately (an Apple ID
# app-specific password, or an App Store Connect API key) that aren't set up on this Mac yet.
# Until notarized, Gatekeeper will show an "Apple could not verify..." warning on first launch.
# Once credentials exist, notarize with:
#   xcrun notarytool submit dist/Pathway.dmg --keychain-profile <profile-name> --wait
#   xcrun stapler staple dist/Pathway.dmg
set -euo pipefail
cd "$(dirname "$0")"

APP_NAME="Pathway"
TEAM_ID="X9LKG9RX5T"
SIGN_IDENTITY="Developer ID Application: Gopi Krishna Rakesh Kode ($TEAM_ID)"
VERSION=$(grep 'MARKETING_VERSION:' project.yml | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
DIST_DIR="dist"
DMG_PATH="$DIST_DIR/${APP_NAME}-${VERSION}.dmg"

echo "==> Regenerating project"
xcodegen generate

echo "==> Cleaning previous build"
rm -rf Build/Products "$DIST_DIR"
mkdir -p "$DIST_DIR"

echo "==> Building Release, signed with: $SIGN_IDENTITY"
xcodebuild -project Pathway.xcodeproj -scheme Pathway -configuration Release \
  -derivedDataPath Build \
  CODE_SIGN_STYLE=Manual \
  CODE_SIGN_IDENTITY="$SIGN_IDENTITY" \
  DEVELOPMENT_TEAM="$TEAM_ID" \
  ENABLE_HARDENED_RUNTIME=YES \
  OTHER_CODE_SIGN_FLAGS="--timestamp" \
  CODE_SIGN_INJECT_BASE_ENTITLEMENTS=NO \
  build | tail -30

APP_PATH="Build/Build/Products/Release/${APP_NAME}.app"
test -d "$APP_PATH" || { echo "Build failed: $APP_PATH not found"; exit 1; }

echo "==> Verifying signature"
codesign --verify --deep --strict --verbose=2 "$APP_PATH"
codesign -dv --entitlements - "$APP_PATH" 2>&1 | head -20

# get-task-allow (a debug-only entitlement letting a debugger attach) is auto-injected by a plain
# `xcodebuild build` unless explicitly suppressed -- notarization rejects any binary carrying it.
# CODE_SIGN_INJECT_BASE_ENTITLEMENTS=NO above should already prevent this; fail loudly rather than
# silently ship a build that would only fail notarization much later.
if codesign -d --entitlements :- "$APP_PATH" 2>/dev/null | grep -q "get-task-allow"; then
    echo "ERROR: build carries the get-task-allow debug entitlement -- would fail notarization." >&2
    exit 1
fi
echo "-- Gatekeeper assessment (expected to fail until notarized) --"
spctl --assess --type execute --verbose "$APP_PATH" || true

echo "==> Building DMG"
STAGING=$(mktemp -d)
cp -R "$APP_PATH" "$STAGING/"
ln -s /Applications "$STAGING/Applications"
rm -f "$DMG_PATH"
hdiutil create -volname "$APP_NAME" -srcfolder "$STAGING" -ov -format UDZO "$DMG_PATH"
rm -rf "$STAGING"

echo ""
echo "Built: $(pwd)/$DMG_PATH"
echo "Signed with a Developer ID certificate. NOT notarized -- see the note at the top of this script."
