// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MicroJournalBar",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "MicroJournalBar", targets: ["MicroJournalBar"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "MicroJournalBar",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/MicroJournalBar"
        )
    ]
)
