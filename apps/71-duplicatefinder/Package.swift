// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DuplicateFinder",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DuplicateFinder", targets: ["DuplicateFinder"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DuplicateFinder",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DuplicateFinder"
        )
    ]
)
