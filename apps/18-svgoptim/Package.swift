// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SVGOptim",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "SVGOptim", targets: ["SVGOptim"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "SVGOptim",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/SVGOptim"
        )
    ]
)
