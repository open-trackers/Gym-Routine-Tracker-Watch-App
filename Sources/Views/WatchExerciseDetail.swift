//
//  WatchExerciseDetail.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/22/22.
//

import SwiftUI

import GroutLib
import GroutUI

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

struct WatchExerciseDetail_Previews: PreviewProvider {
    struct TestHolder: View {
        var exercise: Exercise
        @State private var navData: Data?
        var body: some View {
            NavigationStack {
                WatchExerciseDetail(exercise: exercise)
            }
        }
    }

    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext
        let routine = Routine.create(ctx, userOrder: 0)
        routine.name = "Back & Bicep"
        let exercise = Exercise.create(ctx, userOrder: 0)
        exercise.name = "Lat Pulldown"
        exercise.routine = routine
        return TestHolder(exercise: exercise)
            .environment(\.managedObjectContext, ctx)
    }
}

//    static var previews: some View {
//        WatchExerciseDetail()
//    }
// }
