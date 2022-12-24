//
//  WatchExerciseList.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/21/22.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchExerciseList: View {
    @EnvironmentObject private var router: MyRouter

    var standardViews: StandardViews
    @ObservedObject var routine: Routine

    var body: some View {
        ExerciseList(routine: routine, standardViews: standardViews) {
            addButton
                .font(.title3)
                .tint(exerciseColor)
                .foregroundStyle(.tint)
        }
    }

    private var addButton: some View {
        AddExerciseButton(routine: routine) {
            Label("Add Exercise", systemImage: "plus.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
    }

    // MARK: - Properties

    // MARK: - Actions
}

// struct WatchExerciseList_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseList()
//    }
// }
