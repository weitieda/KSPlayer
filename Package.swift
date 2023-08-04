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
var ffmpegKitPath = FileManager.default.currentDirectoryPath + "/FFmpegKit"
if !FileManager.default.fileExists(atPath: ffmpegKitPath), let url = URL(string: #file) {
    let path = url.deletingLastPathComponent().path
    ffmpegKitPath = path + "/FFmpegKit"
}

if FileManager.default.fileExists(atPath: ffmpegKitPath + "/Package.swift") {
   
}
  package.dependencies += [
        .package(name: "FFmpegKit", path: ffmpegKitPath)
    ]
