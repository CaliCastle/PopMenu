// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "PopMenu",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "PopMenu", targets: ["PopMenu"])
    ],
    targets: [
        .target(
            name: "PopMenu",
            path: "PopMenu"
        ),
        .testTarget(
            name: "PopMenuTests",
            dependencies: ["PopMenu"],
            path: "PopMenuTests"
        )
    ]
)
