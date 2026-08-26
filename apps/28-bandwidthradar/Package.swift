// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BandwidthRadar",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "BandwidthRadar", targets: ["BandwidthRadar"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "BandwidthRadar",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/BandwidthRadar"
        )
    ]
)
