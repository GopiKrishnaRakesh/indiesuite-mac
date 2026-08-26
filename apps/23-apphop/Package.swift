// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AppHop",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "AppHop", targets: ["AppHop"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "AppHop",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/AppHop"
        )
    ]
)
