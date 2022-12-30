//
//  WatchExerciseList.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchExerciseList: View {
    @EnvironmentObject private var router: MyRouter

    var factory: Factory
    @ObservedObject var routine: Routine

    var body: some View {
        ExerciseList(routine: routine, factory: factory) {
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
}

struct WatchExerciseList_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        let factory = WatchFactory(middleMode: .constant(.intensity))
        var body: some View {
            NavigationStack {
                WatchExerciseList(factory: factory, routine: routine)
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
        return TestHolder(routine: routine)
            .environment(\.managedObjectContext, ctx)
    }
}
