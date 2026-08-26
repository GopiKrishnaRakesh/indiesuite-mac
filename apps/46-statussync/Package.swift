// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "StatusSync",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "StatusSync", targets: ["StatusSync"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "StatusSync",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/StatusSync"
        )
    ]
)
