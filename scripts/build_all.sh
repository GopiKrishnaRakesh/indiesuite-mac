#!/usr/bin/env bash
# build_all.sh - Compiles all shared libraries and apps
set -e

echo "🚀 Building Shared Packages..."
for pkg in DesignSystem Licensing AppKitKit AudioVideoCore; do
    echo "  -> Building shared/${pkg}..."
    (cd "shared/${pkg}" && swift build)
done

echo "🚀 Building Applications..."
for app_dir in apps/*; do
    if [ -d "$app_dir" ] && [ -f "$app_dir/Package.swift" ]; then
        app_name=$(basename "$app_dir")
        echo "  -> Building ${app_name}..."
        (cd "$app_dir" && swift build)
    fi
done

echo "🎉 All builds completed successfully!"
