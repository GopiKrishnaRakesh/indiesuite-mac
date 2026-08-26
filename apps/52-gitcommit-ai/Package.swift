// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GitCommitAI",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "GitCommitAI", targets: ["GitCommitAI"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "GitCommitAI",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/GitCommitAI"
        )
    ]
)
