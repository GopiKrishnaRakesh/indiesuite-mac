// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EmojiForge",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "EmojiForge", targets: ["EmojiForge"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "EmojiForge",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/EmojiForge"
        )
    ]
)
