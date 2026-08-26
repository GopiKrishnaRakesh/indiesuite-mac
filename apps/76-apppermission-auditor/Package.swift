// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AppPermissionAuditor",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "AppPermissionAuditor", targets: ["AppPermissionAuditor"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "AppPermissionAuditor",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/AppPermissionAuditor"
        )
    ]
)
