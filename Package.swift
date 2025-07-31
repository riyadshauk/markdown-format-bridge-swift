// swift-tools-version:5.9
// 
// Package.swift
// MarkdownFormatBridge
//
// A bridge library that provides seamless conversion between PDF styling configuration
// and DOCX styling configuration, allowing users to use the same configuration
// for both PDF and DOCX generation.
//
// https://github.com/riyadshauk/markdown-format-bridge
//
import PackageDescription

let package = Package(
    name: "MarkdownFormatBridge",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "MarkdownFormatBridge", targets: ["MarkdownFormatBridge"])
    ],
    dependencies: [
        .package(url: "https://github.com/riyadshauk/markdown-docx-swift.git", branch: "main"),
        // .package(path: "../MarkdownToDocx"),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", from: "0.9.19")
    ],
    targets: [
        .target(
            name: "MarkdownFormatBridge",
            dependencies: [
                .product(name: "MarkdownToDocx", package: "markdown-docx-swift")
                // .product(name: "MarkdownToDocx", package: "MarkdownToDocx")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "MarkdownFormatBridgeTests",
            dependencies: [
                "MarkdownFormatBridge",
                .product(name: "MarkdownToDocx", package: "markdown-docx-swift"),
                // .product(name: "MarkdownToDocx", package: "MarkdownToDocx"),
                .product(name: "ZIPFoundation", package: "ZIPFoundation")
            ],
            path: "Tests"
        )
    ]
)
