//
//  WatchRoutineRun.swift
//
// Copyright 2022, 2023  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchRoutineRun: View {
    // MARK: - Parameters

    var routine: Routine
    @Binding var isNew: Bool
    @Binding var startedAt: Date
    var factory: WatchFactory
    let onStop: (Routine) -> Void

    // MARK: - Views

    var body: some View {
        RoutineRun(routine: routine,
                   isNew: $isNew,
                   startedAt: $startedAt,
                   factory: factory,
                   onStop: onStop)
    }
}

struct WatchRoutineRun_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var startedAt: Date = Date.now.addingTimeInterval(-1000)
        var body: some View {
            NavigationStack {
                WatchRoutineRun(routine: routine,
                                isNew: .constant(true),
                                startedAt: $startedAt,
                                factory: WatchFactory(middleMode: .constant(.intensity)),
                                onStop: { _ in })
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
        e1.primarySetting = 4
        e1.secondarySetting = 6
        // e1.units = Units.kilograms.rawValue
        e1.intensityStep = 7.1
        let e2 = Exercise.create(ctx, userOrder: 1)
        e2.name = "Arm Curl"
        e2.routine = routine
        return
            TestHolder(routine: routine)
                .environment(\.managedObjectContext, ctx)
    }
}
