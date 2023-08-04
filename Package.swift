// swift-tools-version:5.7
import Foundation
import PackageDescription
let package = Package(
    name: "KSPlayer",
    defaultLocalization: "en",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13),
//        .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "KSPlayer",
            // todo clang: warning: using sysroot for 'iPhoneSimulator' but targeting 'MacOSX' [-Wincompatible-sysroot]
//            type: .dynamic,
            targets: ["KSPlayer"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        .target(
            name: "KSPlayer",
            dependencies: [.product(name: "FFmpegKit", package: "FFmpegKit")],
            resources: [.process("Metal/Shaders.metal")]
        ),
        .testTarget(
            name: "KSPlayerTests",
            dependencies: ["KSPlayer"],
            resources: [.process("Resources")]
        ),
    ]
)
var ffmpegKitPath: String? = FileManager.default.currentDirectoryPath + "/FFmpegKit"


if let ffmpegKitPath, FileManager.default.fileExists(atPath: ffmpegKitPath + "/Package.swift") {
    package.dependencies += [
        .package(path: ffmpegKitPath),
    ]
} else {
    package.dependencies += [
        .package(url: "https://github.com/kingslay/FFmpegKit.git", from: "6.0.1"),
    ]
}
