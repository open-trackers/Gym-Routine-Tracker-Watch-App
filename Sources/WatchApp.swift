//
//  WatchApp.swift
//
// Copyright 2022, 2023  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import os
import SwiftUI

import GroutLib

@main
struct Gym_Routine_Tracker_Watch_App: App {
    let persistenceManager = PersistenceManager.shared

    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                             persistenceManager.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            // save if: (1) app moved to background, and (2) changes are pending
            persistenceManager.save()
        }
    }
}
