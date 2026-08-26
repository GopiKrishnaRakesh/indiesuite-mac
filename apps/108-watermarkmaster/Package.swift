// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WatermarkMaster",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "WatermarkMaster", targets: ["WatermarkMaster"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "WatermarkMaster",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/WatermarkMaster"
        )
    ]
)
