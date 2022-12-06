//
//  Helper.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

let websiteDomain = "gym-routine-tracker.github.io"
let websiteTitle = "Gym Routine Tracker"
let copyright = "Copyright 2022 OpenAlloc LLC"

let routineColor: Color = .accentColor
let routineListItemTint: Color = .accentColor.opacity(0.2)

let exerciseColor: Color = .yellow
let exerciseListItemTint: Color = .yellow.opacity(0.2)

let stopColor: Color = .pink

let exerciseDoneColor: Color = .green
let exerciseUndoColor: Color = .green
let exerciseAdvanceColor: Color = .mint
let exerciseNextColor: Color = .blue

let exerciseGearColor: Color = .gray
let exerciseSetsColor: Color = .teal

let titleColor: Color = .primary.opacity(0.8)
let lastColor: Color = .primary.opacity(0.6)
let disabledColor: Color = .secondary.opacity(0.4)
let completedColor: Color = .secondary.opacity(0.5)

let titleWeight: Font.Weight = .medium
let numberWeight: Font.Weight = .light

let numberFont: Font = .title2

let settingRange: ClosedRange<Int16> = 0 ... 50
let intensityMaxValue: Float = 500

// How frequently to update time strings in RoutineCell
let routineSinceUpdateSeconds: TimeInterval = 60

let alwaysAdvanceOnLongPressKey = "alwaysAdvanceOnLongPress"
