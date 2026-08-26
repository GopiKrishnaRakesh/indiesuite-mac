// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MemoryPurgePro",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "MemoryPurgePro", targets: ["MemoryPurgePro"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "MemoryPurgePro",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/MemoryPurgePro"
        )
    ]
)
