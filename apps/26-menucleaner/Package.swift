// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MenuCleaner",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "MenuCleaner", targets: ["MenuCleaner"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "MenuCleaner",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/MenuCleaner"
        )
    ]
)
