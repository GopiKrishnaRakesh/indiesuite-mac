// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FocusHeatmap",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "FocusHeatmap", targets: ["FocusHeatmap"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "FocusHeatmap",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/FocusHeatmap"
        )
    ]
)
