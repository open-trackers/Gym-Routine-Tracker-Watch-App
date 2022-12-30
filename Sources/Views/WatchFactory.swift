//
//  WatchStandardViews.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchFactory: Factory {
    @Binding var middleMode: ExerciseMiddleRowMode

    func routineDetail(routine: Routine) -> AnyView {
        WatchRoutineDetail(routine: routine, factory: self).eraseToAnyView()
    }

    func exerciseDetail(exercise: Exercise) -> AnyView {
        WatchExerciseDetail(exercise: exercise).eraseToAnyView()
    }

    func exerciseRun(exercise: Exercise,
                     onNextIncomplete: @escaping (Int16?) -> Void,
                     hasNextIncomplete: @escaping () -> Bool,
                     onEdit: @escaping (Exercise) -> Void) -> AnyView
    {
        WatchExerciseRun(exercise: exercise,
                         middleMode: $middleMode,
                         onNextIncomplete: onNextIncomplete,
                         hasNextIncomplete: hasNextIncomplete,
                         onEdit: onEdit,
                         factory: self).eraseToAnyView()
    }

    func routineList() -> AnyView {
        WatchRoutineList(factory: self).eraseToAnyView()
    }

    func exerciseList(routine: Routine) -> AnyView {
        WatchExerciseList(factory: self,
                          routine: routine).eraseToAnyView()
    }

    func actionButton(action: @escaping () -> Void,
                      imageSystemName: String,
                      buttonText: String? = nil,
                      tint: Color,
                      onLongPress: (() -> Void)? = nil) -> AnyView
    {
        WatchActionButton(action: action,
                          imageSystemName: imageSystemName,
                          buttonText: buttonText,
                          tint: tint,
                          onLongPress: onLongPress).eraseToAnyView()
    }

    func routineControl(routine: Routine,
                        onAdd: @escaping () -> Void,
                        onStop: @escaping () -> Void,
                        onNextIncomplete: @escaping (Int16?) -> Void,
                        onRemainingCount: @escaping () -> Int,
                        startedAt: Date) -> AnyView
    {
        WatchRoutineControl(routine: routine,
                            onAdd: onAdd,
                            onStop: onStop,
                            onNextIncomplete: onNextIncomplete,
                            onRemainingCount: onRemainingCount,
                            startedAt: startedAt,
                            factory: self).eraseToAnyView()
    }

    func settingsForm() -> AnyView {
        WatchSettingsForm().eraseToAnyView()
    }

    func routineRun(routine: Routine,
                    isNew: Binding<Bool>,
                    startedAt: Binding<Date>,
                    onStop: @escaping (Routine) -> Void) -> AnyView
    {
        WatchRoutineRun(routine: routine,
                        isNew: isNew,
                        startedAt: startedAt,
                        factory: self,
                        onStop: onStop).eraseToAnyView()
    }
}
