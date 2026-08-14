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
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "2.1.8"),
        .package(url: "https://github.com/idnow/docidv-sdk-ios", exact: "1.8.0")
    ],
    targets: [
        .binaryTarget(
            name: "TrustPlatform",
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/ios-sdk-v0.3.0-beta/TrustPlatform.xcframework.zip",
            checksum: "5f1772d0b2e3b5ce7fb02ed113f3219d2bf195a457a49d31d468e95fa82334ec"
        ),
        .binaryTarget(
            name: "TrustPlatformDocIDV",
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/ios-sdk-v0.3.0-beta/TrustPlatformDocIDV.xcframework.zip",
            checksum: "c7874109fc09cac4bca3e5312e81e76d5a32fdfcece75f343d4e0a4e713b584b"
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
