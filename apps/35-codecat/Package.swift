// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CodeCat",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "CodeCat", targets: ["CodeCat"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "CodeCat",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/CodeCat"
        )
    ]
)
