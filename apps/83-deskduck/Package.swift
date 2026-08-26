// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DeskDuck",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DeskDuck", targets: ["DeskDuck"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DeskDuck",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DeskDuck"
        )
    ]
)
