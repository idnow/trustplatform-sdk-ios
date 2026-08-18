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
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/0.4.1-beta/TrustPlatform.xcframework.zip",
            checksum: "20627a57973ff161326bc5263def4cff7995c35c9971bbb4d7ac56fdd68861de"
        ),
        .binaryTarget(
            name: "TrustPlatformDocIDV",
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/0.4.1-beta/TrustPlatformDocIDV.xcframework.zip",
            checksum: "7b1f93bc040f5816305a6512bf7ccf4d74932e9787224bec2fba329b36dba652"
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
