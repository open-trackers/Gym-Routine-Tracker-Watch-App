//
//  ExerciseList.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct ExerciseList: View {
    @Environment(\.managedObjectContext) private var viewContext

    // MARK: - Parameters

    @Binding private var router: NavigationPath
    private var routine: Routine

    internal init(router: Binding<NavigationPath>,
                  routine: Routine)
    {
        _router = router
        self.routine = routine

        let sort = [NSSortDescriptor(keyPath: \Exercise.userOrder, ascending: true)]
        let pred = NSPredicate(format: "routine = %@", routine)
        _exercises = FetchRequest<Exercise>(sortDescriptors: sort, predicate: pred)
    }

    // MARK: - Locals

    @FetchRequest private var exercises: FetchedResults<Exercise>

    // MARK: - Views

    var body: some View {
        List {
            ForEach(exercises, id: \.self) { exercise in
                NavigationLink(value: exercise) {
                    Text("\(exercise.name ?? "unknown")") // \(exercise.userOrder)
                }
                .buttonStyle(.borderless)
            }
            .onMove(perform: moveAction)
            .onDelete(perform: deleteAction)
            .listItemTint(exerciseListItemTint)

            addButton
        }
        .font(.title3)
    }

    private var addButton: some View {
        Button(action: addAction) {
            Label("Add Exercise", systemImage: "plus.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
        .tint(exerciseColor)
        .foregroundStyle(.tint)
    }

    // MARK: - Properties

    private var maxOrder: Int16 {
        exercises.last?.userOrder ?? 0
    }

    // MARK: - Actions

    private func addAction() {
        withAnimation {
            let nu = Exercise.create(viewContext, userOrder: maxOrder + 1)
            nu.name = "New Exercise"
            nu.routine = routine
            PersistenceManager.shared.save(forced: true)
            router.append(nu)
        }
    }

    private func deleteAction(offsets: IndexSet) {
        offsets.map { exercises[$0] }.forEach(viewContext.delete)
        PersistenceManager.shared.save()
    }

    private func moveAction(from source: IndexSet, to destination: Int) {
        Exercise.move(exercises, from: source, to: destination)
        PersistenceManager.shared.save()
    }
}

struct ExerciseList_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var router: NavigationPath = .init()
        var body: some View {
            NavigationStack(path: $router) {
                ExerciseList(router: $router, routine: routine)
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
        let e2 = Exercise.create(ctx, userOrder: 0)
        e2.name = "Arm Curl"
        e2.routine = routine
        return TestHolder(routine: routine)
            .environment(\.managedObjectContext, ctx)
    }
}
