// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BluetoothSignalRadar",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "BluetoothSignalRadar", targets: ["BluetoothSignalRadar"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "BluetoothSignalRadar",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/BluetoothSignalRadar"
        )
    ]
)
