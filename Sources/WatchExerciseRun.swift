//
//  WatchExerciseRun.swift
//
//
//  Created by Reed Esau on 12/21/22.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchExerciseRun: View {
    // MARK: - Parameters

    @ObservedObject private var exercise: Exercise
    @Binding private var middleMode: ExerciseMiddleRowMode
    private var nextAction: (Int16?) -> Void
    private var hasNextIncomplete: () -> Bool
    @Binding private var selectedExercise: Exercise?

    internal init(exercise: Exercise,
                  middleMode: Binding<ExerciseMiddleRowMode>,
                  nextAction: @escaping (Int16?) -> Void,
                  hasNextIncomplete: @escaping () -> Bool,
                  selectedExercise: Binding<Exercise?>)
    {
        self.exercise = exercise
        _middleMode = middleMode
        self.nextAction = nextAction
        self.hasNextIncomplete = hasNextIncomplete
        _selectedExercise = selectedExercise
    }

    // MARK: - Views

    var body: some View {
        ExerciseRunView(exercise: exercise,
                        nextAction: nextAction,
                        hasNextIncomplete: hasNextIncomplete,
                        selectedExercise: $selectedExercise) { geo, titleText, navigationRow in
            VStack {
                titleText
                    .frame(height: geo.size.height * 3 / 13)

                VStack {
                    switch middleMode {
                    case .intensity:
                        intensityView
                    case .gear:
                        gearView
                    case .sets:
                        setsView
                    }
                }
                .frame(height: geo.size.height * 5 / 13)

                navigationRow
                    .frame(height: geo.size.height * 5 / 13)
            }
        }
    }

    private var setsView: some View {
        ExerciseRunMiddleRow(imageName: "dumbbell.fill",
                             imageColor: exerciseSetsColor,
                             onDetail: { selectedExercise = exercise },
                             onTap: { middleMode = .intensity }) {
            TitleText("\(exercise.sets)/\(exercise.repetitions)")
                .tint(.primary)
                .modify {
                    if #available(iOS 16.1, watchOS 9.1, *) {
                        $0.fontDesign(.monospaced)
                    } else {
                        $0.monospaced()
                    }
                }
        }
    }

    private var gearView: some View {
        ExerciseRunMiddleRow(imageName: "gearshape.fill",
                             imageColor: exerciseGearColor,
                             onDetail: { selectedExercise = exercise },
                             onTap: { middleMode = .sets }) {
            HStack {
                if exercise.primarySetting == 0, exercise.secondarySetting == 0 {
                    Text("None")
                        .font(.title2)
                        .foregroundStyle(exerciseGearColor)
                } else {
                    Group {
                        if exercise.primarySetting > 0 {
                            NumberImage(exercise.primarySetting, isCircle: true)
                        }
                        if exercise.secondarySetting > 0 {
                            NumberImage(exercise.secondarySetting, isCircle: false)
                        }
                    }
                    // .symbolRenderingMode(.hierarchical)
                    .imageScale(.large)
                    .font(.title)
                }
            }
        }
    }

    private var intensityView: some View {
        Stepper(value: $exercise.lastIntensity,
                in: 0.0 ... intensityMaxValue,
                step: exercise.intensityStep) {
            Text(exercise.formatIntensity(exercise.lastIntensity))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
        .fontWeight(numberWeight)
        .symbolRenderingMode(.hierarchical)
        .disabled(isDone)
        .foregroundColor(isDone ? completedColor : .primary)
        .contentShape(Rectangle())
        .onTapGesture {
            middleMode = .gear
        }
    }

//    private var bottomRow: some View {
//        HStack {
//            ActionButton(action: isDone ? undoAction : doneAction,
//                         imageSystemName: isDone ? "arrow.uturn.backward" : "checkmark",
//                         buttonText: isDone ? "Undo" : "Done",
//                         tint: shortPressDone ? disabledColor : (isDone ? exerciseUndoColor : exerciseDoneColor),
//                         onLongPress: isDone ? nil : doneLongPressAction)
//            .disabled(shortPressDone)
//
//            ActionButton(action: { nextAction(exercise.userOrder) },
//                         imageSystemName: "arrow.forward",
//                         buttonText: "Next",
//                         tint: nextColor)
//            .disabled(!hasNext)
//        }
//    }

    // MARK: - Helpers

    private var isDone: Bool {
        exercise.isDone
    }
}

// struct WatchRunView_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchRunView()
//    }
// }
