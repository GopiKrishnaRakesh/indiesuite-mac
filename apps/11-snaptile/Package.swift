// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SnapTile",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "SnapTile", targets: ["SnapTile"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "SnapTile",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/SnapTile"
        )
    ]
)
