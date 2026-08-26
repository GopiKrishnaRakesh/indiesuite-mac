// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LocalLensOCR",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "LocalLensOCR",
            targets: ["LocalLensOCR"]),
    ],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing"),
        .package(path: "../../shared/AudioVideoCore")
    ],
    targets: [
        .executableTarget(
            name: "LocalLensOCR",
            dependencies: [
                "DesignSystem",
                "AppKitKit",
                "Licensing",
                "AudioVideoCore"
            ]),
    ]
)
