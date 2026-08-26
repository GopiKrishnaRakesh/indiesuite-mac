// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EnvVault",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "EnvVault", targets: ["EnvVault"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "EnvVault",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/EnvVault"
        )
    ]
)
