//
//  WatchExerciseDetail.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/22/22.
//

import SwiftUI

import GroutUI
import GroutLib

struct WatchExerciseDetail: View {
    
    var exercise: Exercise
    
    // MARK: - Locals

    @SceneStorage("ExerciseDetailTab") private var tabSelected = 1

    var body: some View {
        ExerciseDetail(exercise: exercise) {
            TabView(selection: $tabSelected) {
                Form {
                    ExerciseName(exercise: exercise)
                    ExerciseSettings(exercise: exercise)
                }
                .tag(1)
                Form {
                    ExerciseVolume(exercise: exercise)
                }
                .tag(2)
                Form {
                    ExerciseIntensity(exercise: exercise)
                }
                .tag(3)
            }
            .tabViewStyle(.page)
            .navigationTitle {
                Text(title)
                    .foregroundColor(exerciseColor)
            }
        }
    }
    
    private var title: String {
        "Exercise"
    }

}

//struct WatchExerciseDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchExerciseDetail()
//    }
//}
