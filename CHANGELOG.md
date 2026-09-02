# Changelog

All notable changes to the TrustPlatform iOS SDK will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
