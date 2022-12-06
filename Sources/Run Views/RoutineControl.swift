//
//  RoutineControl.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct RoutineControl: View {
    @Environment(\.managedObjectContext) private var viewContext

    // MARK: - Parameters

    var routine: Routine
    @Binding var selectedTab: URL
    let onStop: () -> Void
    let nextAction: (Int16?) -> Void
    var maxOrder: Int16
    var remainingCount: () -> Int
    @Binding var middleMode: ExerciseMiddleRowMode
    var startedAt: Date

    // MARK: - Views

    var body: some View {
        // rows sized to visually-appealling proportions
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 10) {
                top
                    .frame(height: geo.size.height * 3 / 11)
                middle
                    .frame(height: geo.size.height * 4 / 11)
                    .padding(.bottom, 3)
                bottom(geo)
                    .frame(height: geo.size.height * 4 / 11)
            }
        }
    }

    private var top: some View {
        TitleText(routine.wrappedName)
            .foregroundColor(titleColor)
    }

    private var middle: some View {
        HStack(alignment: .bottom) {
            ActionButton(action: stopAction,
                         imageSystemName: "xmark",
                         buttonText: "Stop",
                         tint: stopColor)

            ElapsedView(startedAt: startedAt)
        }
    }

    private func bottom(_: GeometryProxy) -> some View {
        HStack(alignment: .top) {
            ActionButton(action: addAction,
                         imageSystemName: "plus", // plus.circle.fill
                         buttonText: "Add",
                         tint: exerciseColor)
            ActionButton(action: { nextAction(nil) },
                         imageSystemName: "arrow.forward",
                         buttonText: "Next",
                         tint: nextActionColor)
                .disabled(!hasRemaining)
        }
        .padding(.bottom, 0)
    }

    // MARK: - Properties

    private var nextActionColor: Color {
        hasRemaining ? exerciseNextColor : disabledColor
    }

    private var hasRemaining: Bool {
        remainingCount() > 0
    }

    // MARK: - Actions

    private func stopAction() {
        onStop()
    }

    private func addAction() {
        withAnimation {
            let nu = Exercise.create(viewContext, userOrder: maxOrder + 1)
            routine.addToExercises(nu)
            PersistenceManager.shared.save(forced: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                selectedTab = nu.objectID.uriRepresentation()
                middleMode = .gear
            }
        }
    }
}

struct RoutineControl_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var selectedTab: URL = .init(string: "blah")!
        @State var middleMode: ExerciseMiddleRowMode = .gear
        var startedAt = Date.now.addingTimeInterval(-1200)
        var body: some View {
            RoutineControl(routine: routine,
                           selectedTab: $selectedTab,
                           onStop: {},
                           nextAction: { _ in },
                           maxOrder: 0,
                           remainingCount: { 3 },
                           middleMode: $middleMode,
                           startedAt: startedAt)
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
