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
    
    
    private func routineDetailX(_ routine: Routine) -> AnyView {
        WatchRoutineDetail(routine: routine).eraseToAnyView()
    }
    
    private func exerciseDetailX(_ exercise: Exercise) -> AnyView {
        WatchExerciseDetail(exercise: exercise).eraseToAnyView()
    }

}
