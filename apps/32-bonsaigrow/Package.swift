// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BonsaiGrow",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "BonsaiGrow", targets: ["BonsaiGrow"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "BonsaiGrow",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/BonsaiGrow"
        )
    ]
)
