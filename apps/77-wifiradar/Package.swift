// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WiFiRadar",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "WiFiRadar", targets: ["WiFiRadar"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "WiFiRadar",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/WiFiRadar"
        )
    ]
)
