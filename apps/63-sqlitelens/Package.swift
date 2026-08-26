// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SqliteLens",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "SqliteLens", targets: ["SqliteLens"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "SqliteLens",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/SqliteLens"
        )
    ]
)
