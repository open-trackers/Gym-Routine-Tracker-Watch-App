//
//  WatchRoutineList.swift
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

struct WatchRoutineList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var router: MyRouter

    var standardViews: StandardViews

    var body: some View {
        RoutineList(standardViews: standardViews) {
            Group {
                addButton
                settingsButton
                aboutButton
            }
            .font(.title3)
            .tint(routineColor)
            .foregroundStyle(.tint)
        }
    }

    private var addButton: some View {
        AddRoutineButton {
            Label("Add Routine", systemImage: "plus.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
    }

    private var settingsButton: some View {
        Button(action: settingsAction) {
            Label("Settings", systemImage: "gear.circle")
                .symbolRenderingMode(.hierarchical)
        }
    }

    private var aboutButton: some View {
        Button(action: aboutAction) {
            Label(title: { Text("About") }, icon: {
                AppIcon(name: "grt_icon")
                    .frame(width: 24, height: 24)
            })
        }
    }

    private func settingsAction() {
        router.path.append(MyRoutes.settings)
    }

    private func aboutAction() {
        router.path.append(MyRoutes.about)
    }
}

struct WatchRoutineList_Previews: PreviewProvider {
    struct TestHolder: View {
        let standardViews = WatchStandardViews(middleMode: .constant(.intensity))
        var body: some View {
            NavigationStack {
                WatchRoutineList(standardViews: standardViews)
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
        return TestHolder()
            .environment(\.managedObjectContext, ctx)
    }
}
