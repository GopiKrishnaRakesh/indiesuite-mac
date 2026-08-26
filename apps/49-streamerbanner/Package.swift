// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "StreamerBanner",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "StreamerBanner", targets: ["StreamerBanner"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "StreamerBanner",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/StreamerBanner"
        )
    ]
)
