// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GitStashManager",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "GitStashManager", targets: ["GitStashManager"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "GitStashManager",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/GitStashManager"
        )
    ]
)
