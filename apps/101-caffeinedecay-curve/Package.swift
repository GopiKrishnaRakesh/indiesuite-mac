// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CaffeineDecayCurve",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "CaffeineDecayCurve", targets: ["CaffeineDecayCurve"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "CaffeineDecayCurve",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/CaffeineDecayCurve"
        )
    ]
)
