//
//  WatchRoutineRun.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/26/22.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchRoutineRun: View {
    // MARK: - Parameters

    var routine: Routine
    @Binding var selectedTab: URL
    @Binding var startedAt: Date
    var standardViews: WatchStandardViews
    let onStop: (Routine) -> Void

    internal init(routine: Routine,
                  selectedTab: Binding<URL>,
                  startedAt: Binding<Date>,
                  standardViews: WatchStandardViews,
                  onStop: @escaping (Routine) -> Void)
    {
        self.routine = routine
        self.standardViews = standardViews
        self.onStop = onStop

        _selectedTab = selectedTab
        _startedAt = startedAt
    }

    // MARK: - Views

    var body: some View {
        RoutineRunView(routine: routine,
                       selectedTab: $selectedTab,
                       startedAt: $startedAt,
                       standardViews: standardViews,
                       onStop: onStop)
    }
}

struct WatchRoutineRun_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var selectedTab: URL = controlTab // controlTab
        @State var startedAt: Date = Date.now.addingTimeInterval(-1000)
        var body: some View {
            NavigationStack {
                WatchRoutineRun(routine: routine,
                                selectedTab: $selectedTab,
                                startedAt: $startedAt,
                                standardViews: WatchStandardViews(middleMode: .constant(.intensity)),
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
