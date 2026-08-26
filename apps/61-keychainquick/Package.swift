// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KeyChainQuick",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "KeyChainQuick", targets: ["KeyChainQuick"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "KeyChainQuick",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/KeyChainQuick"
        )
    ]
)
