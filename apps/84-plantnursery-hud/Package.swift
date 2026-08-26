// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PlantNurseryHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PlantNurseryHUD", targets: ["PlantNurseryHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PlantNurseryHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PlantNurseryHUD"
        )
    ]
)
