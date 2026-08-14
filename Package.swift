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
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/0.4.0-beta/TrustPlatform.xcframework.zip",
            checksum: "fcd2ddc62e827f195a2a791fea5b2782cf1ef263cbeed135be197fa9ef28689f"
        ),
        .binaryTarget(
            name: "TrustPlatformDocIDV",
            url: "https://github.com/idnow/trustplatform-sdk-ios/releases/download/0.4.0-beta/TrustPlatformDocIDV.xcframework.zip",
            checksum: "f635ed1248ba328e5242050a64f7096af485e290233196fa535c9b4a55bdf088"
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
