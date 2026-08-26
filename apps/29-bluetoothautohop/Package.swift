// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BluetoothAutoHop",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "BluetoothAutoHop", targets: ["BluetoothAutoHop"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "BluetoothAutoHop",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/BluetoothAutoHop"
        )
    ]
)
