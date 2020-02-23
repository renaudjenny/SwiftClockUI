// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftClockUI",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "SwiftClockUI",
            targets: ["SwiftClockUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.7.2"),
    ],
    targets: [
        .target(
            name: "SwiftClockUI",
            dependencies: []),
        .testTarget(
            name: "SwiftClockUITests",
            dependencies: ["SwiftClockUI", "SnapshotTesting"]),
    ]
)
