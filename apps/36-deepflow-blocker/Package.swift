// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DeepFlowBlocker",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DeepFlowBlocker", targets: ["DeepFlowBlocker"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DeepFlowBlocker",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DeepFlowBlocker"
        )
    ]
)
