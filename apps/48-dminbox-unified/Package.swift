// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DMInboxUnified",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DMInboxUnified", targets: ["DMInboxUnified"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DMInboxUnified",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DMInboxUnified"
        )
    ]
)
