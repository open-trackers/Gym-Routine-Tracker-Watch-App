//
//  ExerciseFirstTab.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct ExerciseFirstTab: View {
    // MARK: - Parameters

    @ObservedObject var exercise: Exercise

    // MARK: - Views

    var body: some View {
        Form {
            Section("Name") {
                TextFieldWithPresets($exercise.wrappedName,
                                     prompt: "Enter exercise name",
                                     color: exerciseColor,
                                     presets: exercisePresets)
            }

            Section("Primary Setting") {
                Stepper(value: $exercise.primarySetting, in: settingRange, step: 1) {
                    stepperValueDisplay(value: exercise.primarySetting)
                }
                .tint(exerciseColor)
            }

            Section("Secondary Setting") {
                Stepper(value: $exercise.secondarySetting, in: settingRange, step: 1) {
                    stepperValueDisplay(value: exercise.secondarySetting)
                }
                .tint(exerciseColor)
            }
        }
    }
}

struct ExerciseTab1_Previews: PreviewProvider {
    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext
        let exercise = Exercise.create(ctx, userOrder: 0)
        exercise.name = "Lat Pulldown"
        return ExerciseFirstTab(exercise: exercise)
    }
}
