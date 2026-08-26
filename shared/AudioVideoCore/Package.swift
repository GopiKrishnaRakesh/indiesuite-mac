// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AudioVideoCore",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "AudioVideoCore",
            targets: ["AudioVideoCore"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AudioVideoCore",
            dependencies: []),
    ]
)
