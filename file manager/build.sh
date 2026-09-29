#!/bin/bash
# Regenerates the Xcode project and builds Pathway.app into ./Build
# Usage:
#   ./build.sh            # Builds Release Pathway.app
#   ./build.sh --install  # Builds Release Pathway.app and installs to /Applications
set -euo pipefail
cd "$(dirname "$0")"
xcodegen generate
rm -rf Build/Products
xcodebuild -project Pathway.xcodeproj -scheme Pathway -configuration Release \
  -derivedDataPath Build CODE_SIGN_IDENTITY="-" build | tail -20
echo "Built: $(pwd)/Build/Build/Products/Release/Pathway.app"

if [[ "${1:-}" == "--install" || "${1:-}" == "-i" ]]; then
    ./install.sh
fi

