// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PostureGuard",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PostureGuard", targets: ["PostureGuard"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PostureGuard",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PostureGuard"
        )
    ]
)
