# TrustPlatform iOS SDK

Integrate IDnow Trust Platform identity verification flows into your iOS app.

## Requirements

| Requirement | Minimum version |
| ----------- | --------------- |
| iOS         | 15.0            |
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
3. Call `run(from:)` with an event handler.

```swift
func startVerification(from viewController: UIViewController) async {
    let session = TPSession(token: sessionToken)
    await session.run(from: viewController) { event in
        switch event {
        case .progress:
            break // See Follow Progress below.
        case .completed:
            // The flow completed. Query your backend for the outcome.
            // See https://docs.eu.platform.idnow.io/docs/integration/get-session-results
            break
        case .aborted:
            // The session was aborted on the server.
            break
        case .failed(let error):
            // Show error.errorDescription. See Handle Errors below.
            break
        @unknown default:
            break
        }
    }
    // The SDK is off screen.
}
```

`run(from:)` is `async`, returns nothing and never throws. It returns once the SDK is off screen. Everything about the flow reaches you through the event handler, which runs on the main actor. Calling `run(from:)` again while a run is active returns immediately without an event.

To close the SDK from your app, call `session.stop()`. It does not end the session on the server and delivers no event. Cancelling the task that awaits `run(from:)` does the same.

## Handle Events

| Event           | When it occurs                                                                       |
| --------------- | ------------------------------------------------------------------------------------ |
| `.progress(_:)` | The current step reports what it is waiting for, as a `StepProgress` value           |
| `.completed`    | The flow finished (the outcome might be accepted or rejected)                        |
| `.aborted`      | The session was aborted on the server                                                |
| `.failed(_:)`   | A technical failure prevented the flow from running or completing. See Handle Errors |

You receive any number of `.progress` events, then at most one of `.completed`, `.aborted` or `.failed`. Nothing follows it.

`.completed` only signals that the flow finished. To retrieve the actual outcome, query the [Get session results](https://docs.eu.platform.idnow.io/docs/integration/get-session-results) API endpoint using the `sessionId` you received when creating the session.

### Follow Progress

`StepProgress` is `.inProgress`, `.enduserInputNeeded` or `.inManualReview`. Progress is reported only when the value changes; a run starts from `.inProgress`, so no event is sent for an initial `.inProgress`. More values may be added, so always keep a default case. The SDK never closes itself because of a progress value: for example, call `session.stop()` on `.progress(.inManualReview)` and let your backend follow the session.

### When the SDK Stays on Screen

With `TPSessionOptions(dismissOnFinish: false)`, the terminal event is delivered when the flow ends, but `run(from:)` returns only once the user has closed the SDK.

## Handle Errors

A `.failed` event carries a `TrustPlatformError` when a technical failure prevents the flow from running or completing.

| Case                                  | When it occurs                                      |
| ------------------------------------- | --------------------------------------------------- |
| `flowFailure`                         | A technical failure occurred within the flow        |
| `invalidToken`                        | The session token is not valid for an SDK session   |
| `sessionExpired`                      | The session timed out on the server                 |
| `networkFailure(underlying:)`         | No connection or a request failed                   |
| `nativeHandlerFailure(code:message:)` | A native handler reported a non-recoverable failure |
| `internalError`                       | An unexpected SDK-internal failure                  |

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
