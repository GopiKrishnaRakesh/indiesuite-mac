// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LottiePreview",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "LottiePreview", targets: ["LottiePreview"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "LottiePreview",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/LottiePreview"
        )
    ]
)
