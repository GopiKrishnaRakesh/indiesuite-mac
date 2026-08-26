// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ShadowStudio",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ShadowStudio", targets: ["ShadowStudio"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ShadowStudio",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ShadowStudio"
        )
    ]
)
