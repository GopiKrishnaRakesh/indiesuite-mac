// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WhisperTap",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "WhisperTap",
            targets: ["WhisperTap"]),
    ],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing"),
        .package(path: "../../shared/AudioVideoCore")
    ],
    targets: [
        .executableTarget(
            name: "WhisperTap",
            dependencies: [
                "DesignSystem",
                "AppKitKit",
                "Licensing",
                "AudioVideoCore"
            ]),
    ]
)
