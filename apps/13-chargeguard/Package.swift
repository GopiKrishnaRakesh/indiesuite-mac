// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ChargeGuard",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "ChargeGuard", targets: ["ChargeGuard"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "ChargeGuard",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/ChargeGuard"
        )
    ]
)
