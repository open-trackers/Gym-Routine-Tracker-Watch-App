//
//  RoutineRunView.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct RoutineRunView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // MARK: - Parameters

    private var routine: Routine
    @Binding private var selectedTab: URL
    @Binding private var startedAt: Date
    private let onStop: (Routine) -> Void

    internal init(routine: Routine,
                  selectedTab: Binding<URL>,
                  startedAt: Binding<Date>,
                  onStop: @escaping (Routine) -> Void)
    {
        self.routine = routine
        self.onStop = onStop

        _selectedTab = selectedTab
        _startedAt = startedAt

        _exercises = FetchRequest<Exercise>(sortDescriptors: Routine.exerciseSort,
                                            predicate: routine.exercisePredicate)
        _incomplete = FetchRequest<Exercise>(sortDescriptors: Routine.exerciseSort,
                                             predicate: routine.incompletePredicate)
    }

    // MARK: - Locals

    static let controlTab = URL(string: "uri://control-panel")!

    @FetchRequest private var exercises: FetchedResults<Exercise>
    @FetchRequest private var incomplete: FetchedResults<Exercise>
    @State private var middleMode: ExerciseMiddleRowMode = .intensity

    // support for exercise detail
    @State private var detailRouter: NavigationPath = .init()
    @State private var selectedExercise: Exercise?

    // MARK: - Views

    var body: some View {
        TabView(selection: $selectedTab) {
            RoutineControl(routine: routine,
                           selectedTab: $selectedTab,
                           onStop: stopAction,
                           nextAction: nextAction,
                           maxOrder: maxOrder,
                           remainingCount: { remainingCount },
                           middleMode: $middleMode,
                           startedAt: startedAt)
                .tag(RoutineRunView.controlTab)

            ForEach(exercises, id: \.self) { exercise in
                ExerciseRunView(exercise: exercise,
                                middleMode: $middleMode,
                                nextAction: nextAction,
                                hasNextIncomplete: { hasNextIncomplete },
                                selectedExercise: $selectedExercise)
                    .tag(exercise.objectID.uriRepresentation())
            }
        }
        .tabViewStyle(.page)
        .animation(.easeInOut(duration: 0.25), value: selectedTab)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                toolbarItem
            }
        }
        .navigationDestination(for: Exercise.self) {
            ExerciseDetail(exercise: $0)
        }

        // supporting exercise detail
        .sheet(item: $selectedExercise) { exercise in
            NavigationStack(path: $detailRouter) {
                ExerciseDetail(exercise: exercise)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button { self.selectedExercise = nil } label: {
                                Image(systemName: "chevron.backward")
                            }
                        }
                    }
                    .environment(\.managedObjectContext, viewContext)
            }
            .interactiveDismissDisabled() // NOTE: needed to prevent home button from dismissing sheet
        }
    }

    private var toolbarItem: some View {
        Button(action: { selectedTab = RoutineRunView.controlTab }) {
            Image(systemName: "control")
                .foregroundColor(isOnControlPanel ? disabledColor : .primary)
        }
        .disabled(isOnControlPanel)
    }

    // MARK: - Properties

    private var maxOrder: Int16 {
        exercises.last?.userOrder ?? 0
    }

    private var isOnControlPanel: Bool {
        selectedTab == RoutineRunView.controlTab
    }

    private var remainingCount: Int {
        incomplete.count
    }

    private var hasRemaining: Bool {
        remainingCount > 0
    }

    private var hasNextIncomplete: Bool {
        remainingCount > 1
    }

    private var completedCount: Int {
        exercises.count - remainingCount
    }

    // MARK: - Actions

    private func stopAction() {
        onStop(routine) // parent view will take down the sheet & save context
    }

    // if next incomplete exercise exists, switch to its tab
    private func nextAction(from userOrder: Int16?) {
        if let nextIncomplete = try? routine.getNextIncomplete(viewContext, from: userOrder) {
            selectedTab = nextIncomplete.objectID.uriRepresentation()
        } else {
            selectedTab = RoutineRunView.controlTab
        }
    }
}

struct RoutineRunView_Previews: PreviewProvider {
    struct TestHolder: View {
        // @State var router: NavigationPath = .init()
        var routine: Routine
        @State var selectedTab: URL = RoutineRunView.controlTab
        @State var startedAt: Date = Date.now.addingTimeInterval(-1000)
        var body: some View {
            NavigationStack {
                RoutineRunView(routine: routine, selectedTab: $selectedTab, startedAt: $startedAt, onStop: { _ in })
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
