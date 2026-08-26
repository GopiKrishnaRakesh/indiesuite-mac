// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "StepCounterSync",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "StepCounterSync", targets: ["StepCounterSync"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "StepCounterSync",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/StepCounterSync"
        )
    ]
)
