// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AudioMix",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "AudioMix",
            targets: ["AudioMix"]),
    ],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing"),
        .package(path: "../../shared/AudioVideoCore")
    ],
    targets: [
        .executableTarget(
            name: "AudioMix",
            dependencies: [
                "DesignSystem",
                "AppKitKit",
                "Licensing",
                "AudioVideoCore"
            ],
            path: "Sources/AudioMix"),
    ]
)
