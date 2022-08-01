// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "LoadableView",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "LoadableView",
            targets: ["LoadableView"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LoadableView",
            dependencies: []
        )
    ]
)
