// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PortForwarderPro",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PortForwarderPro", targets: ["PortForwarderPro"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PortForwarderPro",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PortForwarderPro"
        )
    ]
)
