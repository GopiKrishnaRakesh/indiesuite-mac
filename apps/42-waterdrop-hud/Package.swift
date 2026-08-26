// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WaterDropHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "WaterDropHUD", targets: ["WaterDropHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "WaterDropHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/WaterDropHUD"
        )
    ]
)
