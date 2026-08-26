// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AspectRatioCalc",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "AspectRatioCalc", targets: ["AspectRatioCalc"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "AspectRatioCalc",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/AspectRatioCalc"
        )
    ]
)
