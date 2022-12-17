//
//  ContentView.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import CoreData
import SwiftUI

import GroutLib
import GroutUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    // @State var router: NavigationPath = .init()

    @SceneStorage("main-routines-router") private var routinesRouterData: Data?

    var body: some View {
        routinesContainer
    }

    // NOTE: mirrored in iOS app
    private var routinesContainer: some View {
        RouteredNavStack(navData: $routinesRouterData) {
            RoutineList()
                .navigationDestination(for: RoutineUriRep.self) { uriRep in
                    if let routine = Routine.get(viewContext, forURIRepresentation: uriRep.value) {
                        RoutineDetail(routine: routine)
                        //// .environmentObject(router)
                    } else {
                        Text("Routine not available.")
                    }
                }
                .navigationDestination(for: ExerciseUriRep.self) { uriRep in
                    if let exercise = Exercise.get(viewContext, forURIRepresentation: uriRep.value) {
                        ExerciseDetail(exercise: exercise)
                        //// .environmentObject(router)
                    } else {
                        Text("Exercise not available.")
                    }
                }
                // .navigationBarTitleDisplayMode(.large)
                // .navigationBarHidden(true)
                .navigationTitle("Routines")
        }
    }
}

// TODO: four copies of each routine showing up; should be one!
struct ContentView_Previews: PreviewProvider {
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
        return ContentView()
            .environment(\.managedObjectContext, ctx)
    }
}
