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
//    var routineDetail: (Routine) -> AnyView {
//        { WatchRoutineDetail(routine: $0).eraseToAnyView() }
//    }
    func routineDetail(routine: Routine) -> AnyView {
        WatchRoutineDetail(routine: routine).eraseToAnyView()
    }
//    var exerciseDetail: (Exercise) -> AnyView {
//        { WatchExerciseDetail(exercise: $0).eraseToAnyView() }
//    }
    func exerciseDetail(exercise: Exercise) -> AnyView {
        WatchExerciseDetail(exercise: exercise).eraseToAnyView()
    }
    
//    var exerciseRun: (Exercise,
//                      Binding<ExerciseMiddleRowMode>,
//                      @escaping (Int16?) -> Void,
//                      @escaping () -> Bool,
//                      Binding<Exercise?>) -> AnyView {
//        exerciseRunX
//    }
    
    func exerciseRun(exercise: Exercise,
                              middleMode: Binding<ExerciseMiddleRowMode>,
                              nextAction: @escaping (Int16?) -> Void,
                              hasNextIncomplete: @escaping () -> Bool,
                              selectedExercise: Binding<Exercise?>) -> AnyView {
        WatchExerciseRun(exercise: exercise,
                         middleMode: middleMode,
                         nextAction: nextAction,
                         hasNextIncomplete: hasNextIncomplete,
                         selectedExercise: selectedExercise).eraseToAnyView()
    }
    
    var navigationStack: (Binding<Data?>,
                          @escaping () -> AnyView) -> AnyView {
        navigationStackX
    }
    
//    private func exerciseRunX(exercise: Exercise,
//                              middleMode: Binding<ExerciseMiddleRowMode>,
//                              nextAction: @escaping (Int16?) -> Void,
//                              hasNextIncomplete: @escaping () -> Bool,
//                              selectedExercise: Binding<Exercise?>) -> AnyView {
//        WatchExerciseRun(exercise: exercise,
//                         middleMode: middleMode,
//                         nextAction: nextAction,
//                         hasNextIncomplete: hasNextIncomplete,
//                         selectedExercise: selectedExercise).eraseToAnyView()
//    }
    
    private func navigationStackX(navData: Binding<Data?>,
                                  rootContent: @escaping () -> AnyView) -> AnyView {
        WatchNavigationStack(navData: navData,
                             rootContent: rootContent).eraseToAnyView()
    }
}
