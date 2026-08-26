// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AntiProcrastinateFriction",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "AntiProcrastinateFriction", targets: ["AntiProcrastinateFriction"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "AntiProcrastinateFriction",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/AntiProcrastinateFriction"
        )
    ]
)
