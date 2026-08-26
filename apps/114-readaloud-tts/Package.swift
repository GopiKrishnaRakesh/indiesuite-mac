// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ReadAloudTTS",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ReadAloudTTS", targets: ["ReadAloudTTS"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ReadAloudTTS",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ReadAloudTTS"
        )
    ]
)
