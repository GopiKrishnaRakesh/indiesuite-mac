// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ZenAudioAmbience",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ZenAudioAmbience", targets: ["ZenAudioAmbience"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ZenAudioAmbience",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ZenAudioAmbience"
        )
    ]
)
