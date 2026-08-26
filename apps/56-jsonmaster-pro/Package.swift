// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "JSONMasterPro",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "JSONMasterPro", targets: ["JSONMasterPro"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "JSONMasterPro",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/JSONMasterPro"
        )
    ]
)
