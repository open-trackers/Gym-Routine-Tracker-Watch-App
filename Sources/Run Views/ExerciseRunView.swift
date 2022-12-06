//
//  ExerciseRunView.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct ExerciseRunView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @AppStorage(alwaysAdvanceOnLongPressKey) var alwaysAdvanceOnLongPress: Bool = false

    // MARK: - Parameters

    @ObservedObject var exercise: Exercise
    @Binding var middleMode: ExerciseMiddleRowMode
    var nextAction: (Int16?) -> Void
    var hasNextIncomplete: () -> Bool
    @Binding var selectedExercise: Exercise?

    // MARK: - Locals

    @State private var showAdvanceAlert = false

    // MARK: - Views

    var body: some View {
        // rows sized to visually-appealling proportions
        GeometryReader { geo in
            VStack(alignment: .center) {
                top
                    .frame(height: geo.size.height * 3 / 13)

                middle
                    .frame(height: geo.size.height * 5 / 13)

                bottom
                    .frame(height: geo.size.height * 5 / 13)
            }
        }
        .alert("Long Press",
               isPresented: $showAdvanceAlert,
               actions: {
                   VStack {
                       Button("Yes, advance") { markDone(withAdvance: true) }
                       Button("No") { markDone(withAdvance: false) }
                       Button("Always advance") {
                           alwaysAdvanceOnLongPress = true
                           markDone(withAdvance: true)
                       }
                   }
               },
               message: {
                   Text(alertTitle)
               })
    }

    private var top: some View {
        TitleText(exercise.wrappedName)
            .foregroundColor(isDone ? completedColor : exerciseColor)
    }

    private var middle: some View {
        VStack {
            switch middleMode {
            case .intensity:
                midIntensity
            case .gear:
                midGear
            case .sets:
                midSets
            }
        }
    }

    private var bottom: some View {
        HStack {
            ActionButton(action: isDone ? undoAction : doneAction,
                         imageSystemName: isDone ? "arrow.uturn.backward" : "checkmark",
                         buttonText: isDone ? "Undo" : "Done",
                         tint: isDone ? exerciseUndoColor : exerciseDoneColor,
                         onLongPress: isDone ? nil : doneLongPressAction)

            ActionButton(action: { nextAction(exercise.userOrder) },
                         imageSystemName: "arrow.forward",
                         buttonText: "Next",
                         tint: nextColor)
                .disabled(!hasNext)
        }
    }

    private var midIntensity: some View {
        Stepper(value: $exercise.lastIntensity,
                in: 0.0 ... intensityMaxValue,
                step: exercise.intensityStep) {
            intensityUnitsText
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

    private var intensityUnitsText: some View {
        let units = Units.from(exercise.units)
        return HStack(alignment: .center) {
            Text(formatIntensity(exercise.lastIntensity))
            if units != .none {
                Text(units.abbreviation)
                    .font(.title3)
            }
        }
    }

    private var midGear: some View {
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
                            numberImage(exercise.primarySetting, isCircle: true)
                        }
                        if exercise.secondarySetting > 0 {
                            numberImage(exercise.secondarySetting, isCircle: false)
                        }
                    }
                    // .symbolRenderingMode(.hierarchical)
                    .imageScale(.large)
                    .font(.title)
                }
            }
        }
    }

    private var midSets: some View {
        ExerciseRunMiddleRow(imageName: "dumbbell.fill",
                             imageColor: exerciseSetsColor,
                             onDetail: { selectedExercise = exercise },
                             onTap: { middleMode = .intensity }) {
            TitleText("\(exercise.sets)/\(exercise.repetitions)")
                .tint(.primary)
                .fontDesign(.monospaced)
        }
    }

    private func numberImage(_ value: Int16, isCircle: Bool) -> some View {
        // Image(systemName: numberImageName(Int(exercise.primarySetting), shape: .circle, filled: false))
        let prefix = systemImagePrefix(Int(value))
        let shape = isCircle ? "circle" : "square"
        let full = "\(prefix).\(shape).fill"

        return ZStack {
            Image(systemName: "\(shape).fill")
                .foregroundColor(.white)
            Image(systemName: full)
                .foregroundColor(.black.opacity(0.8))
        }
        .compositingGroup()
    }

    // MARK: - Properties

    private var isStepFractional: Bool {
        exercise.intensityStep.truncatingRemainder(dividingBy: 1) >= 0.1
    }

    private var canAdvance: Bool {
        !isDone && !atMax
    }

    private var advanceColor: Color {
        canAdvance ? exerciseAdvanceColor : disabledColor
    }

    private var hasNext: Bool {
        hasNextIncomplete()
    }

    private var nextColor: Color {
        hasNextIncomplete() ? exerciseNextColor : disabledColor
    }

    private var isDone: Bool {
        exercise.lastCompletedAt != nil
    }

    private var atMax: Bool {
        intensityMaxValue <= exercise.lastIntensity
    }

    private var advancedIntensity: Float {
        if exercise.invertedIntensity {
            // advance downwards
            return max(0, exercise.lastIntensity - exercise.intensityStep)
        } else {
            // advance upwards
            return min(intensityMaxValue, exercise.lastIntensity + exercise.intensityStep)
        }
    }

    private var alertTitle: String {
        "Advance intensity from \(formatIntensity(exercise.lastIntensity)) to \(formatIntensity(advancedIntensity))?"
    }

    // MARK: - Actions

    private func doneAction() {
        logger.debug("#\(#function):")
        markDone(withAdvance: false)
    }

    private func undoAction() {
        logger.debug("#\(#function):")
        exercise.lastCompletedAt = nil
    }

    private func doneLongPressAction() {
        logger.debug("#\(#function):")
        if alwaysAdvanceOnLongPress {
            markDone(withAdvance: true)
        } else {
            showAdvanceAlert = true
        }
    }

    // MARK: - Helpers

    private func formatIntensity(_ intensity: Float) -> String {
        let specifier = isStepFractional ? "%0.1f" : "%0.0f"
        return String(format: specifier, intensity)
    }

    private func markDone(withAdvance: Bool) {
        exercise.lastCompletedAt = Date.now

        if withAdvance {
            exercise.lastIntensity = advancedIntensity
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            nextAction(exercise.userOrder)
        }
    }
}

struct ExerciseRunView_Previews: PreviewProvider {
    struct TestHolder: View {
        var exercise: Exercise
        @State var middleMode: ExerciseMiddleRowMode = .intensity
        @State var selectedExercise: Exercise?
        var body: some View {
            ExerciseRunView(exercise: exercise,
                            middleMode: $middleMode,
                            nextAction: { _ in },
                            hasNextIncomplete: { true },
                            selectedExercise: $selectedExercise)
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
        return NavigationStack {
            TestHolder(exercise: e1)
        }
    }
}
