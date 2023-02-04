# Gym Routine Tracker

_A minimalist wrist-based gym workout tracker_

## Download

Available as a FREE download in the App Store [GRT for Apple Watch](https://apps.apple.com/us/app/gym-routine-tracker/id6444747204)

## Features

- Independent watchOS app, not requiring companion iOS app. Leave your iPhone at home!
- LARGE text in RUN mode, for the farsighted. Leave your glasses in your locker!
- Simple data model of user-defined routines and their exercises.
- Your data syncs with your private iCloud account when a network connection is available.
- Fully open source where code is licensed with Mozilla Public License 2.0.
- Available separately as an app for iPhone/iPad.

GRT prioritizes convenience, quick interactions, and the basic needs of the recreational fitness user.

### Quick and easy setup

- Add routines and exercises in the app itself, with convenient preset names available.
- For each exercise optionally specify seat settings and set/rep counts. 
- For the exercise's intensity (usually weight lifted), optionally specify the units and the step.

### When ‘running’ a routine

- Convenient one-tap button to indicate that an exercise is complete.
- Optional long-press to automatically step up (advance) to next higher intensity in future.
- Convenient skip to the next incomplete exercise, in case a machine isn’t immediately available.
- Control screen showing the time elapsed since starting the routine.

### History features

- Completion of routine/exercise is automatically logged to your private iCloud account.
- Logging can be disabled in settings.
- For the watchOS app, recent history will be stored locally for up to 1 year. Periodically run iOS app for long-term storage and review.
- History can be reviewed on the iOS app for the iPhone/iPad.

### iCloud Sync

- Your data automatically syncs with your private iCloud account when a network connection is available.
- That synced data available to the _Gym Routine Tracker_ app running on your other devices.

## Requirements

Requires watchOS 9.1 or later

## Caveats

- GRT remembers only your most recent workout for each routine. It does not (yet) maintain a historical record of progress.
- Future enhancements may largely rely on contributors.
- GRT prioritizes convenience, quick interactions, and the basic needs of the recreational user. More sophisticated trackers are available on the App Store.

To any Apple product managers who like this app, please consider Sherlocking it!

## See Also

### App Download Links

* [GRT for Apple Watch](https://apps.apple.com/us/app/gym-routine-tracker/id6444747204) - App Store link for FREE download
* [GRT+ for iPhone/iPad](https://apps.apple.com/us/app/gym-routine-tracker/id1662243916) - App Store link for FREE download

### Source Code

* [GRT Website](https://gym-routine-tracker.github.io) - Website for GRT
* [GRT for Apple Watch Source](https://github.com/gym-routine-tracker/Gym-Routine-Tracker-Watch-App) - watchOS implementation
* [GRT+ for iPhone/iPad Source](https://github.com/gym-routine-tracker/Gym-Routine-Tracker-Plus-App) - iOS implementation
* [GroutUI](https://github.com/gym-routine-tracker/GroutUI) - shared UI layer for GRT (watchOS and iOS)
* [GroutLib](https://github.com/gym-routine-tracker/GroutLib) - shared business logic and data layer for GRT

### macOS Apps by the same author

* [FlowAllocator](https://openalloc.github.io/FlowAllocator/index.html) - portfolio rebalancing tool for macOS
* [FlowWorth](https://openalloc.github.io/FlowWorth/index.html) - portfolio valuation and tracking tool for macOS

## License

Copyright 2022, 2023 OpenAlloc LLC

All application code is licensed under the [Mozilla Public License 2](https://www.mozilla.org/en-US/MPL/2.0/), except where noted in individual modules.

## Contributing

Contributions are welcome. You are encouraged to submit pull requests to fix bugs, improve documentation, or offer new features. 

The pull request need not be a production-ready feature or fix. It can be a draft of proposed changes, or simply a test to show that expected behavior is buggy. Discussion on the pull request can proceed from there.

Contributions should ultimately have adequate test coverage. See tests for current entities to see what coverage is expected.
