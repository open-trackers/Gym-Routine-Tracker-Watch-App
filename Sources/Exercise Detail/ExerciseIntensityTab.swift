//
//  ExerciseIntensityTab.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct ExerciseIntensityTab: View {
    // MARK: - Parameters

    @ObservedObject private var exercise: Exercise

    internal init(exercise: Exercise) {
        self.exercise = exercise
        _units = State(initialValue: exercise.units)
    }

    // MARK: - Locals

    @State private var units: Int16

    var body: some View {
        Form {
            Section("Intensity") {
                Stepper(value: $exercise.lastIntensity, in: 0 ... intensityMaxValue, step: exercise.intensityStep) {
                    stepperValueDisplay(value: exercise.lastIntensity, units: Units.from(exercise.units))
                }
                .tint(exerciseColor)
            }

            Section("Intensity Step") {
                Stepper(value: $exercise.intensityStep, in: 0.1 ... 25, step: 0.1) {
                    stepperValueDisplay(value: exercise.intensityStep, units: Units.from(exercise.units))
                }
                .tint(exerciseColor)
            }

            Section("Intensity Units") {
                Picker(selection: $units) {
                    ForEach(Units.allCases, id: \.self) { unit in
                        Text(unit.formattedDescription)
                            .font(.title3)
                            .tag(unit.rawValue)
                    }
                } label: {
                    EmptyView()
                }
                .pickerStyle(.wheel)
                .onChange(of: units) {
                    exercise.units = $0
                }
            }

            Section {
                Toggle(isOn: $exercise.invertedIntensity) {
                    Text("Inverted")
                }
                .tint(exerciseColor)
            } header: {
                Text("Advance Direction")
            } footer: {
                Text("Example: if inverted with step of 5, advance from 25 to 20")
            }
        }
    }
}

struct ExerciseTab3_Previews: PreviewProvider {
    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext
        let exercise = Exercise.create(ctx, userOrder: 0)
        exercise.name = "Lat Pulldown"
        return ExerciseIntensityTab(exercise: exercise)
    }
}
