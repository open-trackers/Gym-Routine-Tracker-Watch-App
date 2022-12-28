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
                     onNextIncomplete: @escaping (Int16?) -> Void,
                     hasNextIncomplete: @escaping () -> Bool,
                     selectedExercise: Binding<Exercise?>) -> AnyView
    {
        WatchExerciseRun(exercise: exercise,
                         middleMode: $middleMode,
                         onNextIncomplete: onNextIncomplete,
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
                        onAdd: @escaping () -> Void,
                        onStop: @escaping () -> Void,
                        onNextIncomplete: @escaping (Int16?) -> Void,
                        //maxOrder: Int16,
                        remainingCount: @escaping () -> Int,
                        startedAt: Date) -> AnyView
    {
        WatchRoutineControl(routine: routine,
                            //selectedTab: selectedTab,
                            onAdd: onAdd,
                            onStop: onStop,
                            onNextIncomplete: onNextIncomplete,
                            //maxOrder: maxOrder,
                            remainingCount: remainingCount,
                            startedAt: startedAt,
                            standardViews: self).eraseToAnyView()
    }

    func settingsForm() -> AnyView {
        WatchSettingsForm().eraseToAnyView()
    }

    func routineRun(routine: Routine,
                    initialTab: URL,
                    startedAt: Binding<Date>,
                    onStop: @escaping (Routine) -> Void) -> AnyView
    {
        WatchRoutineRun(routine: routine,
                        initialTab: initialTab,
                        startedAt: startedAt,
                        standardViews: self,
                        onStop: onStop).eraseToAnyView()
    }
}
