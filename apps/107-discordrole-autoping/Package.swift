// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DiscordRoleAutoPing",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DiscordRoleAutoPing", targets: ["DiscordRoleAutoPing"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DiscordRoleAutoPing",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DiscordRoleAutoPing"
        )
    ]
)
