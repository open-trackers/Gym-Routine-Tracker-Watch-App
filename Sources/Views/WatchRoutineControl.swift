//
//  WatchRoutineControl.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/22/22.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchRoutineControl: View {
    var routine: Routine
    //@Binding var selectedTab: URL?
    let onAdd: () -> Void
    let onStop: () -> Void
    let onNextIncomplete: (Int16?) -> Void
    //var maxOrder: Int16
    var remainingCount: () -> Int
    var startedAt: Date
    var standardViews: StandardViews

    var body: some View {
        RoutineControl(routine: routine,
                       //selectedTab: $selectedTab,
                       onAdd: onAdd,
                       onStop: onStop,
                       onNextIncomplete: onNextIncomplete,
                       //maxOrder: maxOrder,
                       remainingCount: remainingCount,
                       startedAt: startedAt,
                       standardViews: standardViews)
    }
}

struct WatchRoutineControl_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var selectedTab: URL? = .init(string: "blah")!
        var startedAt = Date.now.addingTimeInterval(-1200)
        var body: some View {
            WatchRoutineControl(routine: routine,
                               // selectedTab: $selectedTab,
                                onAdd: {},
                                onStop: {},
                                onNextIncomplete: { _ in },
                               // maxOrder: 0,
                                remainingCount: { 3 },
                                startedAt: startedAt, standardViews: WatchStandardViews(middleMode: .constant(.intensity)))
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
