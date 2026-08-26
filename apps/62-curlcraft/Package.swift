// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CurlCraft",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "CurlCraft", targets: ["CurlCraft"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "CurlCraft",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/CurlCraft"
        )
    ]
)
