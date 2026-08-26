// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LocalEmbeddingsSearch",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "LocalEmbeddingsSearch", targets: ["LocalEmbeddingsSearch"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "LocalEmbeddingsSearch",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/LocalEmbeddingsSearch"
        )
    ]
)
