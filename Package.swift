// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SPM",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "spm", targets: [ "Console" ]),
    ],
    dependencies: [
        
        // Easily create interactive CLI tools
        .package(url: "https://github.com/vapor/console-kit", from: "4.2.4"),
        
        // Easily handle files & folders
        .package(url: "https://github.com/JohnSundell/Files", from: "4.2.0"),
        
        // Easily run shell commands
        .package(url: "https://github.com/JohnSundell/ShellOut", from: "2.3.0"),
        
    ],
    targets: [
        
        // Console Entry Point (main.swift)
        .target(
            name: "Console",
            dependencies: [
                .product(name: "ConsoleKit", package: "console-kit"),
                "Grapher",
            ]
        ),
        
        // Shell Commands (Extensions to ShellOut)
        .target(
            name: "ShellCommands",
            dependencies: [
                "ShellOut",
            ]
        ),
        
        .testTarget(
            name: "ShellCommandTests",
            dependencies: [
                "ShellCommands",
            ]
        ),
        
        // Grapher
        .target(
            name: "Grapher",
            dependencies: [
                .product(name: "ConsoleKit", package: "console-kit"),
                "Files",
                "ShellCommands",
            ]
        ),
        
        .testTarget(
            name: "GrapherTests",
            dependencies: [
                "Grapher",
            ]
        ),
        
    ]
)
