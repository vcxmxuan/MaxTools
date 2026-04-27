// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "MaxTools",
    platforms: [
        .macOS(.v26)
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
