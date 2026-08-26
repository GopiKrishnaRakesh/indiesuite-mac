// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CleanDeskPro",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "CleanDeskPro", targets: ["CleanDeskPro"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "CleanDeskPro",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/CleanDeskPro"
        )
    ]
)
