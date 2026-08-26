// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DockerQuickHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DockerQuickHUD", targets: ["DockerQuickHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DockerQuickHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DockerQuickHUD"
        )
    ]
)
