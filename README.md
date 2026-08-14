# TrustPlatform iOS SDK

Integrate IDnow Trust Platform identity verification flows into your iOS app.

## Requirements

| Requirement | Minimum version |
| ----------- | --------------- |
| iOS         | 14.0            |
| Swift       | 6.0             |

## Installation

1. In Xcode, select **File > Add Package Dependencies…**
2. Paste the repository URL:
   ```
   https://github.com/idnow/trustplatform-sdk-ios
   ```
3. Click **Add Package** (We recommend setting the version rule to **Up to Next Major Version**).
4. In the package product selection sheet, add **TrustPlatform** to your app target. Click **Add Package**.

### Configure Your App

Open your `Info.plist` file and add the following keys.

| Key                                      | Type   | Notes                                       |
| ---------------------------------------- | ------ | ------------------------------------------- |
| `Privacy - Camera Usage Description`     | String | Required for document and biometric capture |
| `Privacy - Microphone Usage Description` | String | Required for video-based verification steps |

---

## Configure the SDK

Call `IDnowTrustPlatform.configure(environment:)` once at app startup, before you create a session.

```swift
// AppDelegate.application(_:didFinishLaunchingWithOptions:)
// or your @main struct init:
IDnowTrustPlatform.configure(environment: .production)
```

| Environment   | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| `.production` | The production environment                                    |
| `.sandbox`    | The sandbox environment for development and testing (default) |

## Start a Session

1. Create a new session via the [/sessions API](https://docs.eu.platform.idnow.io/docs/integration/create-session).
2. Use the session token to initialize a new `TPSession` instance.
3. Call `run(from:)` and await the result.

```swift
let session = TPSession(token: token)
do {
    try await session.run(from: viewController)
    // Flow completed successfully.
} catch TrustPlatformError.cancelled {
    // The user cancelled the flow.
} catch {
    // See Handle Errors below.
}
```

To cancel a running session programmatically, call `session.stop()`.

## Handle Errors

`run(from:)` throws a `TrustPlatformError` on failure.

| Case                                  | When it occurs                                       |
| ------------------------------------- | ---------------------------------------------------- |
| `cancelled`                           | The user cancelled the flow                          |
| `invalidToken`                        | The session token is malformed or rejected           |
| `sessionExpired`                      | The session timed out on the server                  |
| `networkFailure(underlying:)`         | No connection or a request failed                    |
| `flowError(status:)`                  | The flow ended with a terminal error or abort status |
| `nativeHandlerFailure(code:message:)` | A native handler reported a non-recoverable failure  |
| `internalError`                       | An unexpected SDK-internal failure                   |

`errorDescription` on each case is localized and safe to display to end users.

## DocIDV Handler (Optional)

The `TrustPlatformDocIDV` framework adds native document identity verification to your integration. It is separate from the core `TrustPlatform` framework and is optional.

### Add the Framework

1. Select your app target, then open the **Frameworks, Libraries, and Embedded Content** list.
2. Click **+** and add **TrustPlatformDocIDV** from the TrustPlatform package.

### Configure Your App for DocIDV

#### Entitlements File

1. Open your app's entitlements file. If you do not have one, select **File > New File > Property List** and name it `YourApp.entitlements`.
2. Add a key **Near Field Communication Tag Reader Session Formats** of type **Array**.
3. Add one item to the array:
   - Type: **String**
   - Value: `TAG`

#### Info.plist File

1. Open your `Info.plist` file.
2. Add the key **Privacy - NFC Scan Usage Description** and enter a string that explains why the app uses NFC.
3. Add the key **ISO7816 application identifiers for NFC Tag Reader Session** of type **Array**.
4. Add the following two string items to the array:
   - `A00000045645444C2D3031`
   - `A0000002471001`

### How It Works

When you link `TrustPlatformDocIDV`, the SDK discovers the `DocIDVHandler` class automatically at runtime. No registration call is required. If the framework is not linked, the SDK runs the DocIDV step in the webview instead.
