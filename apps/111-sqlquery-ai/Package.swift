// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SqlQueryAI",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "SqlQueryAI", targets: ["SqlQueryAI"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "SqlQueryAI",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/SqlQueryAI"
        )
    ]
)
