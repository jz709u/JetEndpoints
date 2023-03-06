// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JetEndpoints",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "JetEndpoints",
            targets: ["JetEndpoints"])
        
    ],
    dependencies: [
        .package(url: "git@github.com:Quick/Quick.git", from: "6.1.0"),
        .package(url: "git@github.com:Quick/Nimble.git", from: "11.2.1"),
        .package(url: "git@github.com:nicklockwood/SwiftFormat.git", from: "0.51.1")
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "JetEndpoints", dependencies: []),
        .testTarget(
            name: "JetEndpointsTests",
            dependencies: [
                "Quick",
                "Nimble",
                "JetEndpoints"
            ],
            resources: [
                .process("Fixtures")
            ]
        )
    ]
)
