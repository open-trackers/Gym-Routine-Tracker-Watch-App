//
//  WatchStandardViews.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/22/22.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchStandardViews: StandardViews {
    @Binding var middleMode: ExerciseMiddleRowMode

    func routineDetail(routine: Routine) -> AnyView {
        WatchRoutineDetail(routine: routine, standardViews: self).eraseToAnyView()
    }

    func exerciseDetail(exercise: Exercise) -> AnyView {
        WatchExerciseDetail(exercise: exercise).eraseToAnyView()
    }

    func exerciseRun(exercise: Exercise,
                     nextAction: @escaping (Int16?) -> Void,
                     hasNextIncomplete: @escaping () -> Bool,
                     selectedExercise: Binding<Exercise?>) -> AnyView
    {
        WatchExerciseRun(exercise: exercise,
                         middleMode: $middleMode,
                         nextAction: nextAction,
                         hasNextIncomplete: hasNextIncomplete,
                         selectedExercise: selectedExercise,
                         standardViews: self).eraseToAnyView()
    }

    func routineList() -> AnyView {
        WatchRoutineList(standardViews: self).eraseToAnyView()
    }

    func exerciseList(routine: Routine) -> AnyView {
        WatchExerciseList(standardViews: self,
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
                        selectedTab: Binding<URL>,
                        onStop: @escaping () -> Void,
                        nextAction: @escaping (Int16?) -> Void,
                        maxOrder: Int16,
                        remainingCount: @escaping () -> Int,
                        startedAt: Date,
                        standardViews: StandardViews) -> AnyView
    {
        WatchRoutineControl(routine: routine,
                            selectedTab: selectedTab,
                            onStop: onStop,
                            nextAction: nextAction,
                            maxOrder: maxOrder,
                            remainingCount: remainingCount,
                            startedAt: startedAt,
                            standardViews: standardViews).eraseToAnyView()
    }

    func settingsForm() -> AnyView {
        WatchSettingsForm().eraseToAnyView()
    }

    func routineRun(routine: Routine,
                    selectedTab: Binding<URL>,
                    startedAt: Binding<Date>,
                    standardViews _: StandardViews,
                    onStop: @escaping (Routine) -> Void) -> AnyView
    {
        WatchRoutineRun(routine: routine,
                        selectedTab: selectedTab,
                        startedAt: startedAt,
                        standardViews: self,
                        onStop: onStop).eraseToAnyView()
    }
}
