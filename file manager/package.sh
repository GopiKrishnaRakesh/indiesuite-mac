#!/bin/bash
# Builds a Developer ID-signed, notarized Release build of Pathway and packages it into
# dist/Pathway-<version>.dmg. Does its own clean build from scratch -- no need to run build.sh first.
#
# Notarization needs credentials stored once, ahead of time, via:
#   xcrun notarytool store-credentials "pathway-notary" --apple-id <email> --team-id X9LKG9RX5T
# (run without --password on the line so it prompts for the app-specific password interactively,
# rather than leaving it sitting in shell history). If that profile isn't present in the keychain,
# this script still produces a signed-but-unnotarized DMG and says so -- it doesn't fail outright.
set -euo pipefail
cd "$(dirname "$0")"

APP_NAME="Pathway"
TEAM_ID="X9LKG9RX5T"
SIGN_IDENTITY="Developer ID Application: Gopi Krishna Rakesh Kode ($TEAM_ID)"
NOTARY_PROFILE="pathway-notary"
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

echo "==> Building DMG"
STAGING=$(mktemp -d)
cp -R "$APP_PATH" "$STAGING/"
ln -s /Applications "$STAGING/Applications"
rm -f "$DMG_PATH"
hdiutil create -volname "$APP_NAME" -srcfolder "$STAGING" -ov -format UDZO "$DMG_PATH"
rm -rf "$STAGING"

if xcrun notarytool history --keychain-profile "$NOTARY_PROFILE" >/dev/null 2>&1; then
    echo "==> Notarizing (profile: $NOTARY_PROFILE)"
    xcrun notarytool submit "$DMG_PATH" --keychain-profile "$NOTARY_PROFILE" --wait
    echo "==> Stapling ticket"
    xcrun stapler staple "$DMG_PATH"
    xcrun stapler validate "$DMG_PATH"
    echo ""
    echo "Built and notarized: $(pwd)/$DMG_PATH"
else
    echo "-- Gatekeeper assessment (expected to fail until notarized) --"
    spctl --assess --type execute --verbose "$APP_PATH" || true
    echo ""
    echo "Built: $(pwd)/$DMG_PATH"
    echo "Signed with a Developer ID certificate. NOT notarized -- no '$NOTARY_PROFILE' credentials"
    echo "found in the keychain. See the note at the top of this script to set them up."
fi
