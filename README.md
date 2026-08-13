# TrustPlatform iOS SDK

The TrustPlatform iOS SDK provides a native flow execution engine for the IDnow Trust Platform.

## Installation

### Swift Package Manager

Add the package to your project via Xcode (**File → Add Package Dependencies**) or directly in your `Package.swift`:

```swift
.package(url: "https://github.com/idnow/trustplatform-sdk-ios", from: "1.0.0")
```

Then add the desired library product as a target dependency:

| Product               | Description                                      |
| --------------------- | ------------------------------------------------ |
| `TrustPlatform`       | Core flow execution engine                       |
| `TrustPlatformDocIDV` | DocIDV native handler (includes `TrustPlatform`) |

## Requirements

- iOS 14.0+
- Xcode 16+
- Swift 6.0+

## License

Copyright © IDnow GmbH. All rights reserved.
