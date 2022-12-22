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
    var routineDetail: (Routine) -> AnyView {
        routineDetailX
    }
    var exerciseDetail: (Exercise) -> AnyView {
        exerciseDetailX
    }
    
    var exerciseRun: (Exercise,
                      Binding<ExerciseMiddleRowMode>,
                      @escaping (Int16?) -> Void,
                      @escaping () -> Bool,
                      Binding<Exercise?>) -> AnyView {
        exerciseRunX
    }
    
    
    private func routineDetailX(_ routine: Routine) -> AnyView {
        WatchRoutineDetail(routine: routine).eraseToAnyView()
    }
    
    private func exerciseDetailX(_ exercise: Exercise) -> AnyView {
        WatchExerciseDetail(exercise: exercise).eraseToAnyView()
    }
    
    private func exerciseRunX(exercise: Exercise,
                              middleMode: Binding<ExerciseMiddleRowMode>,
                              nextAction: @escaping (Int16?) -> Void,
                              hasNextIncomplete: @escaping () -> Bool,
                              selectedExercise: Binding<Exercise?>) -> AnyView {
        WatchExerciseRun(exercise: exercise,
                         middleMode: $middleMode,
                         nextAction: nextAction,
                         hasNextIncomplete: hasNextIncomplete,
                         selectedExercise: selectedExercise).eraseToAnyView()
    }
}
