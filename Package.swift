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
        .package(url: "git@github.com:Quick/Nimble.git", from: "11.2.1")
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
//        .binaryTarget(
//            name: "swiftformat",
//            url: "https://github.com/nicklockwood/SwiftFormat/releases/download/0.51.1/swiftformat.artifactbundle.zip",
//            checksum: "af70ed2d4667c2ac22a40a26df187443d0ffc962959f97f39f7fb8b2765b5ef3"),
//        .plugin(
//            name: "SwiftFormatPlugin",
//            capability: .buildTool(),
//            dependencies: ["swiftformat"]),
        .target(
            name: "JetEndpoints"),
            //dependencies: ["SwiftFormatPlugin"]),
        .testTarget(
            name: "JetEndpointsTests",
            dependencies: [
                "JetEndpoints",
                "Quick",
                "Nimble"
            ],
            resources: [
                .process("Fixtures")
            ]
        )
    ]
)
