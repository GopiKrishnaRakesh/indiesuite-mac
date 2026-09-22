#!/bin/bash
# Regenerates the Xcode project and builds Pathway.app into ./Build
set -euo pipefail
cd "$(dirname "$0")"
xcodegen generate
rm -rf Build/Products
xcodebuild -project Pathway.xcodeproj -scheme Pathway -configuration Release \
  -derivedDataPath Build CODE_SIGN_IDENTITY="-" build | tail -20
echo "Built: $(pwd)/Build/Build/Products/Release/Pathway.app"
