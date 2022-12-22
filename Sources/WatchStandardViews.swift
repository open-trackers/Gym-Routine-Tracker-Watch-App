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
    func routineDetail(routine: Routine) -> AnyView {
        WatchRoutineDetail(routine: routine).eraseToAnyView()
    }

    func exerciseDetail(exercise: Exercise) -> AnyView {
        WatchExerciseDetail(exercise: exercise).eraseToAnyView()
    }

    func exerciseRun(exercise: Exercise,
                     middleMode: Binding<ExerciseMiddleRowMode>,
                     nextAction: @escaping (Int16?) -> Void,
                     hasNextIncomplete: @escaping () -> Bool,
                     selectedExercise: Binding<Exercise?>) -> AnyView
    {
        WatchExerciseRun(exercise: exercise,
                         middleMode: middleMode,
                         nextAction: nextAction,
                         hasNextIncomplete: hasNextIncomplete,
                         selectedExercise: selectedExercise).eraseToAnyView()
    }

    func navigationStackX(navData: Binding<Data?>,
                          rootContent: @escaping () -> AnyView) -> AnyView
    {
        WatchNavigationStack(navData: navData,
                             rootContent: rootContent).eraseToAnyView()
    }
}
