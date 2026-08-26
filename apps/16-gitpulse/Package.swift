// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GitPulse",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "GitPulse", targets: ["GitPulse"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "GitPulse",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/GitPulse"
        )
    ]
)
