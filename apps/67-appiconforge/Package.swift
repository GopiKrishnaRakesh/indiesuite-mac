// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AppIconForge",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "AppIconForge", targets: ["AppIconForge"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "AppIconForge",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/AppIconForge"
        )
    ]
)
