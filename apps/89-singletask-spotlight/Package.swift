// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SingleTaskSpotlight",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "SingleTaskSpotlight", targets: ["SingleTaskSpotlight"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "SingleTaskSpotlight",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/SingleTaskSpotlight"
        )
    ]
)
