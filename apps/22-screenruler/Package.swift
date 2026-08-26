// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ScreenRuler",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ScreenRuler", targets: ["ScreenRuler"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ScreenRuler",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ScreenRuler"
        )
    ]
)
