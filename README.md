# Gym Routine Tracker Watch App

_A minimalist wrist-based gym workout tracker_

## Features

- Independent WatchOS app, not requiring companion iOS app. Leave your iPhone at home!
- LARGE text in RUN mode, for those with presbyopia. Leave your cheaters in your locker!
- Prioritizes convenience, quick interactions, and the basic needs of the recreational fitness user.

### Quick and easy setup
- Add routines and exercises in the app itself, with convenient preset names available.
- For each exercise optionally specify seat settings and set/rep counts. 
- For the exercise's intensity (usually weight lifted), optionally specify the units and the step.

### When ‘running’ a routine
- Convenient one-tap button to indicate that an exercise is complete.
- Optional long-press to automatically step up (advance) to next higher intensity in future.
- Convenient skip to the next incomplete exercise, in case a machine isn’t immediately available.
- Control screen showing the time elapsed since starting the routine.

### App features
- Simple data model of user-defined routines and their exercises.
- Your data syncs with CloudKit when a network connection is available.
- Fully open source where code is licensed with Mozilla Public License 2.0.
- App available as a free download in the WatchOS App Store. 

## Requirements

Requires WatchOS 9.1 or later

## Caveats

- Grout remembers only your most recent workout for each routine. It does not (yet) maintain a historical record of progress.
- Future enhancements will largely rely on contributors.
- Grout prioritizes convenience, quick interactions, and the basic needs of the recreational user. More sophisticated trackers are available on the App Store.

To any Apple product managers who like this app, please consider Sherlocking it!

## See Also

* [GroutLib](https://github.com/gym-routine-tracker/GroutLib) - shared business logic and data layer for GRT

Apps by the same author:

* [FlowAllocator](https://openalloc.github.io/FlowAllocator/index.html) - portfolio rebalancing tool for macOS
* [FlowWorth](https://openalloc.github.io/FlowWorth/index.html) - portfolio valuation and tracking tool for macOS

## License

Copyright 2022 OpenAlloc LLC

All application code is licensed under the [Mozilla Public License 2](https://www.mozilla.org/en-US/MPL/2.0/), except where noted in individual modules.

## Contributing

Contributions are welcome. You are encouraged to submit pull requests to fix bugs, improve documentation, or offer new features. 

The pull request need not be a production-ready feature or fix. It can be a draft of proposed changes, or simply a test to show that expected behavior is buggy. Discussion on the pull request can proceed from there.

Contributions should ultimately have adequate test coverage. See tests for current entities to see what coverage is expected.
