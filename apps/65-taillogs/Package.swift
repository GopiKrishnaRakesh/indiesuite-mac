// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TailLogs",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "TailLogs", targets: ["TailLogs"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "TailLogs",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/TailLogs"
        )
    ]
)
