// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MorningKickoffHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "MorningKickoffHUD", targets: ["MorningKickoffHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "MorningKickoffHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/MorningKickoffHUD"
        )
    ]
)
