// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "TrustPlatform",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "TrustPlatform",
            targets: ["TrustPlatform-Target-Wrapper"]
        ),
        .library(
            name: "TrustPlatformDocIDV",
            targets: ["TrustPlatformDocIDV-Target-Wrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.1.11"),
        .package(url: "https://github.com/idnow/docidv-sdk-ios", exact: "1.12.0")
    ],
    targets: [
        .binaryTarget(
            name: "TrustPlatform",
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/0.6.0/TrustPlatform.xcframework.zip",
            checksum: "71e531332f09f2892055612cfbf27e1b0597e9fd6bdce35f471f270c0ba45e90"
        ),
        .binaryTarget(
            name: "TrustPlatformDocIDV",
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/0.6.0/TrustPlatformDocIDV.xcframework.zip",
            checksum: "24e5e78ed0af0150948ae7c1ab058c03da5f4507a32a84078ae14d1ade99c983"
        ),
        .target(
            name: "TrustPlatform-Target-Wrapper",
            dependencies: [
                "TrustPlatform",
                .product(name: "SunflowerSwiftUI", package: "sunflower-sdk-ios")
            ],
            path: "sources"
        ),
        .target(
            name: "TrustPlatformDocIDV-Target-Wrapper",
            dependencies: [
                "TrustPlatform",
                "TrustPlatformDocIDV",
                .product(name: "SunflowerSwiftUI", package: "sunflower-sdk-ios"),
                .product(name: "DocIDV", package: "docidv-sdk-ios"),
                .product(name: "EID-Governikus", package: "docidv-sdk-ios")
            ],
            path: "sources-docidv"
        )
    ]
)
