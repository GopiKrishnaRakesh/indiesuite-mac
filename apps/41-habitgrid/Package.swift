// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HabitGrid",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "HabitGrid", targets: ["HabitGrid"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "HabitGrid",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/HabitGrid"
        )
    ]
)
