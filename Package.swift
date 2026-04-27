// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "MaxTools",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "MaxTools", targets: ["MaxToolsApp"])
    ],
    targets: [
        .executableTarget(
            name: "MaxToolsApp",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "MaxToolsAppTests",
            dependencies: ["MaxToolsApp"]
        )
    ]
)
