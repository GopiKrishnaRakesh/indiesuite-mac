// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CertSentry",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "CertSentry", targets: ["CertSentry"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "CertSentry",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/CertSentry"
        )
    ]
)
