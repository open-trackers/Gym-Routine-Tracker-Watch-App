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

    @ObservedObject var routine: Routine

    var body: some View {
        ExerciseList(routine: routine)
    }

    // MARK: - Properties

    // MARK: - Actions
}

// struct WatchExerciseList_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseList()
//    }
// }
