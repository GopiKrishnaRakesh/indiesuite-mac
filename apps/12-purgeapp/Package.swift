// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PurgeApp",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PurgeApp", targets: ["PurgeApp"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PurgeApp",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PurgeApp"
        )
    ]
)
