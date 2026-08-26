// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DeskFishAquarium",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DeskFishAquarium", targets: ["DeskFishAquarium"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DeskFishAquarium",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DeskFishAquarium"
        )
    ]
)
