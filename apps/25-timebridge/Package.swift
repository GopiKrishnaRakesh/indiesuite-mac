// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TimeBridge",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "TimeBridge", targets: ["TimeBridge"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "TimeBridge",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/TimeBridge"
        )
    ]
)
