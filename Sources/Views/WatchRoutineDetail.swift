//
//  WatchRoutineDetail.swift
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

struct WatchRoutineDetail: View {
    @EnvironmentObject private var router: MyRouter

    @SceneStorage("routine-detail-tab") private var selectedTab: Int = 0

    @ObservedObject var routine: Routine
    var factory: Factory

    var body: some View {
        RoutineDetail(routine: routine) {
            TabView(selection: $selectedTab) {
                Form {
                    Section("Name") {
                        TextFieldWithPresets($routine.wrappedName,
                                             prompt: "Enter routine name",
                                             color: routineColor,
                                             presets: routinePresets)
                    }

                    Section("Image") {
                        ImageStepper(initialName: routine.imageName, imageNames: systemImageNames) {
                            routine.imageName = $0
                        }
                        .imageScale(.small)
                    }
                }
                .tabItem {
                    Text("Properties")
                }
                .tag(0)

                FakeSection(title: "Exercises") {
                    factory.exerciseList(routine: routine)
                }
                .tabItem {
                    Text("Exercises")
                }
                .tag(1)
            }
            .tabViewStyle(.page)
            .navigationTitle {
                Text("Routine")
                    .foregroundColor(routineColor)
            }
        }
    }
}

struct WatchRoutineDetail_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var navData: Data?
        var factory = WatchFactory(middleMode: .constant(.intensity))
        var body: some View {
            NavigationStack {
                WatchRoutineDetail(routine: routine, factory: factory).eraseToAnyView()
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
