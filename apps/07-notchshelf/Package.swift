// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NotchShelf",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "NotchShelf",
            targets: ["NotchShelf"]),
    ],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "NotchShelf",
            dependencies: [
                "DesignSystem",
                "AppKitKit",
                "Licensing"
            ],
            path: "Sources/NotchShelf"),
    ]
)
