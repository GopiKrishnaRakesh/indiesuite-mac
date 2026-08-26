// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "StandUpTimer",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "StandUpTimer", targets: ["StandUpTimer"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "StandUpTimer",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/StandUpTimer"
        )
    ]
)
