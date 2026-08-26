// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ZenPanda",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ZenPanda", targets: ["ZenPanda"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ZenPanda",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ZenPanda"
        )
    ]
)
