//
//  RoutineDetail.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct RoutineDetail: View {
    @Environment(\.managedObjectContext) private var viewContext

    // MARK: - Parameters

    @Binding var router: NavigationPath

    @ObservedObject var routine: Routine

    // MARK: - Views

    var body: some View {
        TabView {
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
                }
            }

            FakeSection("Exercises") {
                ExerciseList(router: $router, routine: routine)
            }
        }
        .tabViewStyle(.page)
        .navigationTitle {
            Text("Routine")
                .foregroundColor(routineColor)
        }
        .onDisappear {
            logger.debug("Routine Detail, onDisappear")
            PersistenceManager.shared.save()
        }
    }

    // MARK: - Properties

    private var exerciseCount: Int {
        routine.exercises?.count ?? 0
    }

    private var exerciseButtonDisplay: String {
        "\(exerciseCount) Item\(exerciseCount == 1 ? "" : "s")"
    }
}

struct RoutineDetail_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var router: NavigationPath = .init()
        var body: some View {
            NavigationStack(path: $router) {
                RoutineDetail(router: $router, routine: routine)
            }
        }
    }

    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext
        let routine = Routine.create(ctx, userOrder: 0)
        routine.name = "Back & Bicep"
        let e1 = Exercise.create(ctx, userOrder: 0)
        e1.name = "Lat Pulldown"
        e1.routine = routine
        let e2 = Exercise.create(ctx, userOrder: 1)
        e2.name = "Arm Curl"
        e2.routine = routine
        return NavigationStack {
            TestHolder(routine: routine)
        }
        .environment(\.managedObjectContext, ctx)
    }
}
