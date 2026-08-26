// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BatteryCycleTelemetry",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "BatteryCycleTelemetry", targets: ["BatteryCycleTelemetry"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "BatteryCycleTelemetry",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/BatteryCycleTelemetry"
        )
    ]
)
