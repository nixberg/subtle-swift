// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "subtle-swift",
    products: [
        .library(
            name: "Subtle",
            targets: ["Subtle"]),
    ],
    targets: [
        .target(
            name: "Subtle"),
        .testTarget(
            name: "SubtleTests",
            dependencies: ["Subtle"]),
    ]
)
