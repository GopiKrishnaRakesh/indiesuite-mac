#!/bin/bash
# Builds and runs all Pathway unit tests cleanly and rapidly.
set -euo pipefail
cd "$(dirname "$0")"

mkdir -p Build/PathwayTests.xctest/Contents/MacOS
xcrun swiftc -emit-library \
  -F /Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks \
  -framework XCTest \
  -framework AppKit \
  -framework PDFKit \
  -I /Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib \
  -L /Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib \
  Tests/PathwayTests.swift Sources/Models/*.swift Sources/Support/*.swift \
  -o Build/PathwayTests.xctest/Contents/MacOS/PathwayTests

xcrun xctest Build/PathwayTests.xctest
