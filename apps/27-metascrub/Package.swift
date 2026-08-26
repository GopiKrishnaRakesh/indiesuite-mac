// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MetaScrub",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "MetaScrub", targets: ["MetaScrub"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "MetaScrub",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/MetaScrub"
        )
    ]
)
