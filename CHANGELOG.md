# Change Log

Changelog for Critical Maps iOS

## [Unreleased]

### Added

- Replace send text button in ChatInputView with an icon button
- Accessability support for chat input textview
- VoiceOver improvements for the Navigation TabBar
- Spanish translations
- Add NextRide MapInfoView feature

## [3.6.0] - 2019-11-28

### Fixed

- Fix: Don't update content when slightly swipe down in Social Modal
- Fix whitespace only chat message can not be send anymore.
- Fix dark mode for Rules Detail

### Added

- Loading and ErrorStateView for Twitter and Chat section

## [3.4.0] - 2019-10-08

### Added

- Landscape support
- Set userStyle as Theme under iOS 13
- Add infrastructure for UITests to easily generate automated screenshots with different languages and devices
- Infrastructure for Snapshot tests
- Open Twitter tapping on tweet

### Fixed

- Fix: NavigationBar Colors under iOS 13
- Fix: UITableViewHeaderFooterView backgroundColor deprecation warning
- Fix: Ambiguous auto layout constraints for Settings screen

## [3.3.0] - 2019-09-01

### Added

- iOS 13 support

### Fixed

- A bug that made the app unusable with assistive technologies like Switch Control or VoiceOver
- SocialSegment sliding under NavigationBar bug in iOS 10
- Dynamic Type Layout issues

## [3.2.0] - 2019-06-18

### Added

- Dynamic Type support
- Observation Mode

### Fixed

- A bug that stopped updating locations if one update request failed

## [3.1.0] - 2019-05-28

### Added

- Message Notification Bubble
- Swiftformat to the build phases
- The ID isn't constant anymore
- Network activity indicator support
- French localisation. Thanks Alban!
- Night mode feature

### Updated

- SDWebImage

### Fixed

- Users can not send empty chat messages anymore.
- A bug that prevented sending messages if another network request is active
- input dismissed when switching to the emoji keyboard

## [3.0.0] - 2019-04-18

### Changed

- Complete Redesign
- Migrate map page to Swift
- Migrate rules page to Swift
- Migrate chat page to Swift
- Migrate twitter page to Swift
- Migrate settings page to Swift
- New navigation

### Added

- Swift bridge
- Tests

## [2.5.1]

### Fixed

- Modern devices support

## [2.5.0]

### Added

- italian translations

### Changed

- allow observing if GPS is disabled
- english translations

### Updated

- XCode project to recommend settings
- AFNetworking
- Appirater
- SDWebImage

## [2.4.0] - 2017-08-01

### Changed

- less bike symbol opacity

## [2.3.0] - 2017-07-02

### Changed

- switch back to api.criticalmaps.net

### Removed

- Travis

## [2.2.1] - 2017-06-07

### Fixed

- intended purpose of using the user's location while the app is in the background (NSLocationAlwaysUsageDescription)

## [2.2.0] - 2017-06-06

### Changed

- temporary API url

### Updated

- SDWebImage
- Appirater 2.1.2 (was 2.0.5)
- STTwitter 0.2.6 (was 0.2.5)

## [2.1.0] - 2016-09-24

### Added

- Changelog

### Changed

- Update pods
- Remove parse
- Change title on map screen to "Critical Maps"

### Fixed

- Podfile

## [2.0.1] - 2016-04-10

### Updated

- pods

## [2.0.0] - 2016-01-15

### Changed

- redesign by zutrinken

previous versions are not tracked
