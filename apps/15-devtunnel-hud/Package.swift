// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DevTunnelHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DevTunnelHUD", targets: ["DevTunnelHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DevTunnelHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DevTunnelHUD"
        )
    ]
)
