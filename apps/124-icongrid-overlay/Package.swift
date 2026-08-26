// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "IconGridOverlay",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "IconGridOverlay", targets: ["IconGridOverlay"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "IconGridOverlay",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/IconGridOverlay"
        )
    ]
)
