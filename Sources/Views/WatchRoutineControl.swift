//
//  WatchRoutineControl.swift
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

struct WatchRoutineControl: View {
    var routine: Routine
    let onAdd: () -> Void
    let onStop: () -> Void
    let onNextIncomplete: (Int16?) -> Void
    var onRemainingCount: () -> Int
    var startedAt: Date
    var factory: Factory

    var body: some View {
        RoutineControl(routine: routine,
                       onAdd: onAdd,
                       onStop: onStop,
                       onNextIncomplete: onNextIncomplete,
                       onRemainingCount: onRemainingCount,
                       startedAt: startedAt,
                       factory: factory)
    }
}

struct WatchRoutineControl_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var selectedTab: URL? = .init(string: "blah")!
        var startedAt = Date.now.addingTimeInterval(-1200)
        var body: some View {
            WatchRoutineControl(routine: routine,
                                onAdd: {},
                                onStop: {},
                                onNextIncomplete: { _ in },
                                onRemainingCount: { 3 },
                                startedAt: startedAt, factory: WatchFactory(middleMode: .constant(.intensity)))
        }
    }

    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext
        let routine = Routine.create(ctx, userOrder: 0)
        routine.name = "Back & Bicep"
        let e1 = Exercise.create(ctx, userOrder: 0)
        e1.name = "Lat Pulldown"
        e1.routine = routine
        return NavigationStack {
            TestHolder(routine: routine)
        }
    }
}
