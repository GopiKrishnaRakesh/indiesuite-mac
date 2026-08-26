// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MonoSpaceFlow",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "MonoSpaceFlow", targets: ["MonoSpaceFlow"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "MonoSpaceFlow",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/MonoSpaceFlow"
        )
    ]
)
