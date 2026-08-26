// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TabLimiterPro",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "TabLimiterPro", targets: ["TabLimiterPro"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "TabLimiterPro",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/TabLimiterPro"
        )
    ]
)
