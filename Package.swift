// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "constant-time-swift",
    products: [
        .library(
            name: "ConstantTime",
            targets: ["ConstantTime"]),
    ],
    targets: [
        .target(
            name: "ConstantTime"),
        .testTarget(
            name: "ConstantTimeTests",
            dependencies: ["ConstantTime"]),
    ]
)
