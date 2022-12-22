//
//  WatchNavigationStack.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/21/22.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchNavigationStack: View {
    @Environment(\.managedObjectContext) private var viewContext

    // MARK: - Parameters

    @Binding private var navData: Data?
    private var rootContent: () -> AnyView

    public init(navData: Binding<Data?>,
                @ViewBuilder rootContent: @escaping () -> AnyView)
    {
        _navData = navData
        self.rootContent = rootContent
    }

    // MARK: - Locals

    // MARK: - Views

    var body: some View {
        MyNavigationStack(navData: $navData,
                          routineDetail: routineDetail,
                          exerciseDetail: exerciseDetail,
                          rootContent: rootContent)
    }

    private func routineDetail(_ routine: Routine) -> AnyView {
        WatchRoutineDetail(routine: routine).eraseToAnyView()
    }
    
    private func exerciseDetail(_ exercise: Exercise) -> AnyView {
        WatchExerciseDetail(exercise: exercise).eraseToAnyView()
    }

//    public func exerciseRun(exercise: Exercise,
//                             nextAction: @escaping (Int16?) -> Void,
//                             hasNextIncomplete: @escaping () -> Bool,
//                             selectedExercise: Binding<Exercise?>) -> AnyView {
//        WatchExerciseRun(exercise: exercise,
//                         nextAction: nextAction,
//                         hasNextIncomplete: hasNextIncomplete,
//                         selectedExercise: selectedExercise).eraseToAnyView()
//    }
}

// struct WatchNavigationStack_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchNavigationStack()
//    }
// }
