//
//  WatchStandardViews.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/22/22.
//

import SwiftUI

import GroutLib
import GroutUI

final class WatchStandardViews: StandardViews {
    @Binding private var middleMode: ExerciseMiddleRowMode

    public init(middleMode: Binding<ExerciseMiddleRowMode>) {
        _middleMode = middleMode
        super.init()
    }

    override func routineDetail(routine: Routine) -> AnyView {
        WatchRoutineDetail(routine: routine).eraseToAnyView()
    }

    override func exerciseDetail(exercise: Exercise) -> AnyView {
        WatchExerciseDetail(exercise: exercise).eraseToAnyView()
    }

    override func exerciseRun(exercise: Exercise,
                              nextAction: @escaping (Int16?) -> Void,
                              hasNextIncomplete: @escaping () -> Bool,
                              selectedExercise: Binding<Exercise?>) -> AnyView
    {
        WatchExerciseRun(exercise: exercise,
                         middleMode: $middleMode,
                         nextAction: nextAction,
                         hasNextIncomplete: hasNextIncomplete,
                         selectedExercise: selectedExercise,
                         standardViews: self).eraseToAnyView()
    }

    override func routineList() -> AnyView {
        WatchRoutineList(standardViews: self).eraseToAnyView()
    }

    override func actionButton(action: @escaping () -> Void,
                               imageSystemName: String,
                               buttonText: String? = nil,
                               tint: Color,
                               onLongPress: (() -> Void)? = nil) -> AnyView
    {
        WatchActionButton(action: action,
                          imageSystemName: imageSystemName,
                          buttonText: buttonText,
                          tint: tint,
                          onLongPress: onLongPress).eraseToAnyView()
    }

    override func routineControl(routine: Routine,
                                 selectedTab: Binding<URL>,
                                 onStop: @escaping () -> Void,
                                 nextAction: @escaping (Int16?) -> Void,
                                 maxOrder: Int16,
                                 remainingCount: @escaping () -> Int,
                                 startedAt: Date,
                                 standardViews: StandardViews) -> AnyView
    {
        WatchRoutineControl(routine: routine,
                            selectedTab: selectedTab,
                            onStop: onStop,
                            nextAction: nextAction,
                            maxOrder: maxOrder,
                            remainingCount: remainingCount,
                            startedAt: startedAt,
                            standardViews: standardViews).eraseToAnyView()
    }

//    override func navigationStack(navData: Binding<Data?>,
//                                  rootContent: @escaping () -> AnyView) -> AnyView
//    {
//        WatchNavStack(standardViews: self,
//                      navData: navData,
//                      // middleMode: $middleMode,
//                      rootContent: rootContent).eraseToAnyView()
//    }
}
