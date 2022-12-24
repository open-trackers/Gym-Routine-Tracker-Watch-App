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
    @Binding var selectedTab: URL
    let onStop: () -> Void
    let nextAction: (Int16?) -> Void
    var maxOrder: Int16
    var remainingCount: () -> Int
    var startedAt: Date
    var standardViews: StandardViews

    var body: some View {
        RoutineControl(routine: routine,
                       selectedTab: $selectedTab,
                       onStop: onStop,
                       nextAction: nextAction,
                       maxOrder: maxOrder,
                       remainingCount: remainingCount,
                       startedAt: startedAt,
                       standardViews: standardViews)
    }
}

// struct WatchRoutineControl_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchRoutineControl()
//    }
// }
