// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HostsManager",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "HostsManager", targets: ["HostsManager"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "HostsManager",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/HostsManager"
        )
    ]
)
