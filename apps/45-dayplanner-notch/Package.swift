// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DayPlannerNotch",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DayPlannerNotch", targets: ["DayPlannerNotch"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DayPlannerNotch",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DayPlannerNotch"
        )
    ]
)
