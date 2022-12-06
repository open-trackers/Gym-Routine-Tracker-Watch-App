//
//  ExerciseDetail.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct ExerciseDetail: View {
    var exercise: Exercise

    @State private var tabSelected = 1

    var body: some View {
        TabView(selection: $tabSelected) {
            ExerciseFirstTab(exercise: exercise)
                .tag(1)
            ExerciseVolumeTab(exercise: exercise)
                .tag(2)
            ExerciseIntensityTab(exercise: exercise)
                .tag(3)
        }
        .tabViewStyle(.page)
        .symbolRenderingMode(.hierarchical)
        .navigationTitle {
            Text("Exercise")
                .foregroundColor(exerciseColor)
        }
        .onDisappear {
            PersistenceManager.shared.save()
        }
    }
}

struct ExerciseDetail_Previews: PreviewProvider {
    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext
        let routine = Routine.create(ctx, userOrder: 0)
        routine.name = "Back & Bicep"
        let exercise = Exercise.create(ctx, userOrder: 0)
        exercise.name = "Lat Pulldown"
        exercise.routine = routine
        return NavigationStack {
            ExerciseDetail(exercise: exercise)
        }
        .environment(\.managedObjectContext, ctx)
    }
}
