//
//  ExerciseVolumeTab.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct ExerciseVolumeTab: View {
    // MARK: - Parameters

    @ObservedObject var exercise: Exercise

    // MARK: - Views

    var body: some View {
        Form {
            Section("Set Count") {
                Stepper(value: $exercise.sets, in: 0 ... 10, step: 1) {
                    stepperValueDisplay(value: exercise.sets)
                }
                .tint(exerciseColor)
            }

            Section("Repetition Count") {
                Stepper(value: $exercise.repetitions, in: 0 ... 100, step: 1) {
                    stepperValueDisplay(value: exercise.repetitions)
                }
                .tint(exerciseColor)
            }
        }
    }
}

struct ExerciseTab2_Previews: PreviewProvider {
    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext
        let exercise = Exercise.create(ctx, userOrder: 0)
        exercise.name = "Lat Pulldown"
        return ExerciseVolumeTab(exercise: exercise)
    }
}
