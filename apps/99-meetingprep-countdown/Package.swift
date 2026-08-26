// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MeetingPrepCountdown",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "MeetingPrepCountdown", targets: ["MeetingPrepCountdown"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "MeetingPrepCountdown",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/MeetingPrepCountdown"
        )
    ]
)
