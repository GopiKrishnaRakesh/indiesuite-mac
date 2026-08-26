// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GradientMeshMaker",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "GradientMeshMaker", targets: ["GradientMeshMaker"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "GradientMeshMaker",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/GradientMeshMaker"
        )
    ]
)
