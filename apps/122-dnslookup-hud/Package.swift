// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DnsLookupHUD",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "DnsLookupHUD", targets: ["DnsLookupHUD"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "DnsLookupHUD",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/DnsLookupHUD"
        )
    ]
)
