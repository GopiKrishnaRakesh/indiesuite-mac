// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ShrinkMedia",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "ShrinkMedia",
            targets: ["ShrinkMedia"]),
    ],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing"),
        .package(path: "../../shared/AudioVideoCore")
    ],
    targets: [
        .executableTarget(
            name: "ShrinkMedia",
            dependencies: [
                "DesignSystem",
                "AppKitKit",
                "Licensing",
                "AudioVideoCore"
            ]),
    ]
)
