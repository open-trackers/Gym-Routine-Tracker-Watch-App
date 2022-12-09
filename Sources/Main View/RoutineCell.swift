//
//  RoutineCell.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import CoreData
import SwiftUI

import GroutLib

public struct RoutineCell: View {
    @Environment(\.managedObjectContext) private var viewContext

    var routine: Routine
    @Binding var now: Date
    var onStart: (Routine.ID) -> Void

    // MARK: - Views

    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: routine.imageName ?? "dumbbell.fill")
                        Spacer()
                    }
                }
                .padding(.vertical, 12)
                .contentShape(Rectangle())
                .onTapGesture(perform: startAction)
//                 .border(.teal)

                Spacer(minLength: 20)

                NavigationLink(value: routine) {
                    Image(systemName: "ellipsis.rectangle.fill")
                        // .imageScale(.large)
                        .padding(.leading, 20)
                        .padding(.vertical, 10)
//                     .border(.teal)
                }
            }
            .foregroundColor(routineColor)
            .font(.title2)
            .symbolRenderingMode(.hierarchical)

            VStack(alignment: .leading) {
                TitleText(routine.name ?? "unknown")
                    .foregroundColor(titleColor)

                RoutineSinceText(routine: routine, now: $now)
                    .font(.body)
                    .italic()
                    .foregroundColor(lastColor)
                    .lineLimit(1)
            }
            .contentShape(Rectangle())
            .onTapGesture(perform: startAction)
//             .border(.teal)
        }
        .onAppear {
            // refresh immediately on routine completion (timer only updates 'now' on on the minute)
            now = Date.now
        }
    }

    // MARK: - Actions

    private func startAction() {
        onStart(routine.id)
    }
}

struct RoutineCell_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var selectedTab: URL = RoutineRunView.controlTab
        @State var now: Date = .now
        var body: some View {
            List {
                RoutineCell(routine: routine, now: $now, onStart: { _ in })
            }
        }
    }

    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext
        let routine = Routine.create(ctx, userOrder: 0)
        routine.name = "Back & Bicep"
        routine.lastDuration = 3545
        routine.lastStartedAt = Date.now.addingTimeInterval(-364 * 86400)
        return NavigationStack {
            TestHolder(routine: routine)
                .environment(\.managedObjectContext, ctx)
        }
        .environment(\.managedObjectContext, ctx)
    }
}
