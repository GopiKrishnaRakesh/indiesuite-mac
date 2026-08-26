// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FontInspect",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "FontInspect", targets: ["FontInspect"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "FontInspect",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/FontInspect"
        )
    ]
)
