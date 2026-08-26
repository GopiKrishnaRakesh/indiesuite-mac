// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PomodoroDragon",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "PomodoroDragon", targets: ["PomodoroDragon"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "PomodoroDragon",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/PomodoroDragon"
        )
    ]
)
