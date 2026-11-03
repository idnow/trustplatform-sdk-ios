// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "TrustPlatform",
    platforms: [
        .iOS(.v15)
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
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/0.7.0/TrustPlatform.xcframework.zip",
            checksum: "4a56964b7d9f7170069a0e921685478b6507483604a76dbaa9159282610c45df"
        ),
        .binaryTarget(
            name: "TrustPlatformDocIDV",
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/0.7.0/TrustPlatformDocIDV.xcframework.zip",
            checksum: "9722ca7ef9c9a56526db770fcb7ce8ff8eb838eb0c406fc6dc2828320df8d455"
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
