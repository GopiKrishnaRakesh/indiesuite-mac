// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KubeClusterQuick",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "KubeClusterQuick", targets: ["KubeClusterQuick"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "KubeClusterQuick",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/KubeClusterQuick"
        )
    ]
)
