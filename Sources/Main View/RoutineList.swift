//
//  RoutineList.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct RoutineList: View {
    @Environment(\.managedObjectContext) private var viewContext

    // MARK: - Parameters

    @Binding var router: NavigationPath

    // MARK: - Locals

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Routine.userOrder, ascending: true)],
        animation: .default
    )
    private var routines: FetchedResults<Routine>

    @State private var selectedRoutine: Routine?
    @State private var selectedTab: URL = RoutineRunView.controlTab
    @State private var startedAt: Date = .distantFuture

    // timer used to refresh "2d ago, for 16.5m" on each Routine Cell
    @State private var now = Date()
    private let timer = Timer.publish(every: routineSinceUpdateSeconds,
                                      on: .current,
                                      in: .common).autoconnect()

    // MARK: - Views

    var body: some View {
        List {
            ForEach(routines, id: \.self) { routine in
                RoutineCell(routine: routine,
                            now: $now,
                            onStart: startAction)
            }
            .onMove(perform: moveAction)
            .onDelete(perform: deleteAction)
            .listItemTint(routineListItemTint)

            Group {
                addButton
                settingsButton
                aboutButton
            }
            .font(.title3)
            .tint(routineColor)
            .foregroundStyle(.tint)
        }
        .navigationDestination(for: Routine.self) {
            RoutineDetail(router: $router, routine: $0)
        }
        .navigationDestination(for: Exercise.self) {
            ExerciseDetail(exercise: $0)
        }
        .navigationTitle("Routines")
        .sheet(item: $selectedRoutine) { routine in
            NavigationStack {
                RoutineRunView(routine: routine,
                               selectedTab: $selectedTab,
                               startedAt: $startedAt,
                               onStop: stopAction)
                    .environment(\.managedObjectContext, viewContext)
            }
            .interactiveDismissDisabled() // NOTE: needed to prevent home button from dismissing sheet
        }
        .onReceive(timer) { _ in
            self.now = Date.now
        }
    }

    private var addButton: some View {
        Button(action: addAction) {
            Label("Add Routine", systemImage: "plus.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
    }

    private var settingsButton: some View {
        NavigationLink(destination: {
            SettingsForm()
        }) {
            Label("Settings", systemImage: "gear.circle")
                .symbolRenderingMode(.hierarchical)
        }
    }

    private var aboutButton: some View {
        NavigationLink(destination: { AboutView() }) {
            Label(title: { Text("About") }, icon: {
                AppIcon()
                    .frame(width: 24, height: 24)
            })
        }
    }

    // MARK: - Properties

    private var maxOrder: Int16 {
        routines.last?.userOrder ?? 0
    }

    // MARK: - Actions

    private func addAction() {
        withAnimation {
            let nu = Routine.create(viewContext, userOrder: maxOrder + 1)
            nu.name = "New Routine"
            PersistenceManager.shared.save(forced: true)
            router.append(nu)
        }
    }

    private func deleteAction(offsets: IndexSet) {
        offsets.map { routines[$0] }.forEach(viewContext.delete)
        PersistenceManager.shared.save()
    }

    private func moveAction(from source: IndexSet, to destination: Int) {
        Routine.move(routines, from: source, to: destination)
        PersistenceManager.shared.save()
    }

    private func startAction(_ routineID: Routine.ID) {
        guard let routine = routines.first(where: { $0.id == routineID }) else {
            logger.debug("#\(#function): couldn't find routine; not starting")
            return
        }

        logger.notice("#\(#function): Start Routine \(routine.wrappedName)")

        do {
            // NOTE: storing startedAt locally (not in routine.lastStartedAt)
            // to ignore mistaken starts.
            startedAt = try routine.start(viewContext)
            PersistenceManager.shared.save()

            if let ex = try routine.getNextIncomplete(viewContext) {
                selectedTab = ex.objectID.uriRepresentation()
            }

            selectedRoutine = routine // displays sheet

        } catch {
            let nserror = error as NSError
            logger.error("#\(#function): Start failure \(nserror.localizedDescription)")
        }
    }

    private func stopAction(_ routine: Routine) {
        logger.notice("#\(#function): Stop Routine \(routine.wrappedName)")
        if routine.stop(startedAt: startedAt) {
            PersistenceManager.shared.save()
        } else {
            logger.debug("#\(#function): not recorded, probably because no exercises completed")
        }
        startedAt = Date.distantFuture
        selectedRoutine = nil // closes sheet
    }
}

// TODO: four copies of each routine showing up; should be one!
struct RoutineList_Previews: PreviewProvider {
    struct TestHolder: View {
        @State private var router = NavigationPath()
        var body: some View {
            NavigationStack(path: $router) {
                RoutineList(router: $router)
            }
        }
    }

    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext

        let rA = Routine.create(ctx, userOrder: 0)
        rA.name = "Circuit"
        let e1 = Exercise.create(ctx, userOrder: 0)
        e1.name = "Lat Pulldown"
        e1.routine = rA
        let e2 = Exercise.create(ctx, userOrder: 1)
        e2.name = "Arm Curl"
        e2.routine = rA

        let rB = Routine.create(ctx, userOrder: 1)
        rB.name = "Chest & Shoulders"
        let e3 = Exercise.create(ctx, userOrder: 0)
        e3.name = "Chest Press"
        e3.routine = rB
        return TestHolder()
            .environment(\.managedObjectContext, ctx)
    }
}
