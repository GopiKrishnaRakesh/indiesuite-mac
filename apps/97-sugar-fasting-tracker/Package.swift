// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SugarFastingTracker",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "SugarFastingTracker", targets: ["SugarFastingTracker"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "SugarFastingTracker",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/SugarFastingTracker"
        )
    ]
)
