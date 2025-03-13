// swift-tools-version:5.3
// This file generated from post_build script, modify the script instaed of this file.

// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Journify-MoEngage",
    platforms: [
        .iOS("13.0"),
        .tvOS("11.0"),
        .watchOS("7.1")
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Journify-MoEngage",
            targets: ["Journify-MoEngage"]),
    ],
    dependencies: [
        .package(
            name: "Journify",
            url: "https://github.com/journifyio/journify-ios-sdk",
            from: "0.1.9"),
        .package(
            name: "MoEngage-iOS-SDK",
            url: "https://github.com/moengage/MoEngage-iOS-SDK.git",
            from: "9.22.0")
    ],
    targets: [
        .target(
            name: "Journify-MoEngage",
            dependencies: ["Journify", "MoEngage-iOS-SDK"])
    ]
)
