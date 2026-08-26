// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DiffExplainerAI",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DiffExplainerAI", targets: ["DiffExplainerAI"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DiffExplainerAI",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DiffExplainerAI"
        )
    ]
)
