// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PrivateLLMBar",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PrivateLLMBar", targets: ["PrivateLLMBar"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PrivateLLMBar",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PrivateLLMBar"
        )
    ]
)
