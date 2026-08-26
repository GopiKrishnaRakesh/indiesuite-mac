// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SleepHygieneNudge",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "SleepHygieneNudge", targets: ["SleepHygieneNudge"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "SleepHygieneNudge",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/SleepHygieneNudge"
        )
    ]
)
