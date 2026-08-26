// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AppQuarantineInspector",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "AppQuarantineInspector", targets: ["AppQuarantineInspector"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "AppQuarantineInspector",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/AppQuarantineInspector"
        )
    ]
)
