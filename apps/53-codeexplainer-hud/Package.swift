// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CodeExplainerHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "CodeExplainerHUD", targets: ["CodeExplainerHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "CodeExplainerHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/CodeExplainerHUD"
        )
    ]
)
