// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CronVisualizer",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "CronVisualizer", targets: ["CronVisualizer"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "CronVisualizer",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/CronVisualizer"
        )
    ]
)
