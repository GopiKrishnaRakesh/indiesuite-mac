// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MockupSnap",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "MockupSnap", targets: ["MockupSnap"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "MockupSnap",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/MockupSnap"
        )
    ]
)
