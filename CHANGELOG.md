# Changelog

All notable changes to the TrustPlatform iOS SDK will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.7.0]

### Added

- `TrustPlatformEvent` and `StepProgress`: the SDK now reports the progress of the current step (`.progress(.inManualReview)` and so on) while the flow runs. Progress is reported only when the value changes, and a run reports a waiting value at once if it starts while a step is already waiting. Requires a Player version that sends `stepProgress` on `session-state`; with an older Player no progress events are delivered.

### Changed

- **Breaking:** the minimum supported iOS version is now 15.0 (was 14.0).
- **Breaking:** `TPSession.run(from:)` is replaced by `run(from:onEvent:) async`. It no longer returns a value or throws: progress and how the flow ended (`.completed`, `.aborted`, `.failed(TrustPlatformError)`) arrive through the event handler, which runs on the main actor. Setup failures arrive as `.failed`.
- **Breaking:** `run(from:onEvent:)` returns once the SDK is off screen. With `dismissOnFinish: false`, the terminal event is delivered when the flow ends and `run` returns when the user closes the SDK.
- **Breaking:** `TPSession.stop()`, and cancelling the task awaiting `run`, now close the SDK without delivering any event (previously `run` returned `.aborted`). `.aborted` now only means the session was aborted on the server.
- **Breaking:** calling `run` while a run of the same session is active now returns immediately without an event (previously it returned `.aborted`).

### Removed

- **Breaking:** `FlowOutcome`. Use `TrustPlatformEvent`.

### Fixed

- Pop-ups opened by the Player with `window.open`, such as an OIDC login, were silently dropped. A pop-up to a host the Player announces for the current step now opens in the external browser (`SFSafariViewController`); any other pop-up stays blocked. Requires a Player version that sends `popupHosts` on `session-state`.
- Camera and microphone access inside the Player could fail silently, because the permission handler was never called. It now runs: the Player's own origin is granted without a prompt and any other origin gets the system prompt.
- The WebView was reloaded only when the session URL changed, so a step that wrote no session state left the screen frozen. The SDK now sends a `session-refresh` message to the Player on every poll and the Player re-renders in place instead of reloading, which also removes the white flash between steps. Requires a Player version that handles `session-refresh`; with an older Player the URL-change reload remains the fallback.

## [0.6.1]

### Changed

- The styling context injected into the WebView is now scheme-scoped: `backgroundColour` is a per-scheme map (`{ dark }`) instead of a flat hex. Requires a Player version that reads the new shape.

### Fixed

- Fixed the WebView background rendering white in dark mode on some OS versions (<=iOS 18), where the injected styling colour was flattened to its light variant at WebView creation.

## [0.6.0]

### Added

- The SDK now sends device context (OS, device model, manufacturer, timezone, language, VPN status) when acquiring a session.

### Changed

- Added dark mode support for the WebView.
- The flow WebView now uses a non-persistent `WKWebsiteDataStore`, so session data is no longer written to disk.

### Fixed

- Fixed a styling issue that caused the WebView not to take up the full screen.

## [0.5.4] - 2026-09-07

- Release pipeline improvements. No SDK changes.

## [0.5.4-beta] - 2026-09-03

- Release pipeline improvements. No SDK changes.

## [0.5.3-beta] - 2026-09-03

### Changed

- Added `-Wl,-dead_strip_dylibs` linker flag to reduce binary size.

## [0.5.2-beta]

### Fixed

- Fixed broken packaging

## [0.5.1-beta]

### Fixed

- Included missing TrustPlatformDocIDV module

## [0.5.0-beta]

### Changed

- Updated IDnow DocIDV SDK from `1.8.0` to `1.12.0`.
- Updated IDnow eID-Governikus SDK from `1.3.4` to `1.3.9`.
- Updated Sunflower design system from `2.1.8` to `2.1.11`.

### Fixed

- Fixed `TrustPlatformEnvironment` production and sandbox player base URLs to include the `/player` path component, matching the behaviour of the `.custom` environment case.

## [0.4.1-beta] - 2026-08-18

- CI pipeline validation release. No functional changes.

## [0.4.0-beta] - 2026-08-14

- CI pipeline validation release. No functional changes.

## [0.3.0-beta] - 2026-08-14

- CI pipeline validation release. No functional changes.

## [0.2.0-beta] - 2026-08-14

- CI pipeline validation release. No functional changes.

## [0.1.0] - 2026-08-13

### Added

- Initial release of the TrustPlatform iOS SDK.
- `TrustPlatform.xcframework` — core flow execution engine with WebView and native directive support.
- `TrustPlatformDocIDV.xcframework` — DocIDV native handler integrating the IDnow DocIDV SDK.
