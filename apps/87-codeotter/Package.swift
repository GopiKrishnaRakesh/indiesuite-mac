// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CodeOtter",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "CodeOtter", targets: ["CodeOtter"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "CodeOtter",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/CodeOtter"
        )
    ]
)
