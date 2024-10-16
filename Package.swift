// swift-tools-version:5.10

import PackageDescription

let package = Package(
        name: "ComponentKit",
        platforms: [
            .iOS(.v14),
            .macOS(.v12)
        ],
        products: [
            .library(
                    name: "ComponentKit",
                    targets: ["ComponentKit"]
            ),
        ],
        dependencies: [
            .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.31.0"),
            .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1"),
            .package(url: "https://github.com/sunimp/HUD.git", .upToNextMajor(from: "1.0.0")),
            .package(url: "https://github.com/sunimp/SectionsTableView.git", .upToNextMajor(from: "1.0.0")),
            .package(url: "https://github.com/sunimp/ThemeKit.git", .upToNextMajor(from: "1.0.0")),
            .package(url: "https://github.com/sunimp/UIExtensions.git", .upToNextMajor(from: "1.0.0")),
            .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.54.6"),
        ],
        targets: [
            .target(
                    name: "ComponentKit",
                    dependencies: [
                        "SkeletonView",
                        "SnapKit",
                        "HUD",
                        "SectionsTableView",
                        "ThemeKit",
                        "UIExtensions"
                    ]
            ),
        ]
)
