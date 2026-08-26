// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "RedisLens",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "RedisLens", targets: ["RedisLens"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "RedisLens",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/RedisLens"
        )
    ]
)
