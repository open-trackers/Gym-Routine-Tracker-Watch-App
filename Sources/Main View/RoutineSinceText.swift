//
//  RoutineSinceText.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Combine
import SwiftUI

import Compactor

import GroutLib

struct RoutineSinceText: View {
    var routine: Routine
    @Binding var now: Date

    // MARK: - Locals

    private let tcDur: TimeCompactor = .init(ifZero: "", style: .short, roundSmallToWhole: false)
    private let tcSince: TimeCompactor = .init(ifZero: nil, style: .short, roundSmallToWhole: true)

    // MARK: - Views

    var body: some View {
        VStack {
            if let _lastStr = lastStr {
                Text(_lastStr)
            } else {
                EmptyView()
            }
        }
    }

    // MARK: - Properties

    private var lastStr: String? {
        guard let _sinceStr = sinceStr,
              let _durationStr = durationStr
        else { return nil }
        return "\(_sinceStr) ago, for \(_durationStr)"
    }

    // time interval since the last workout ended, formatted compactly
    private var sinceStr: String? {
        guard let lastStartedAt = routine.lastStartedAt,
              routine.lastDuration > 0
        else { return nil }
        let since = max(0, now.timeIntervalSince(lastStartedAt) - routine.lastDuration)
        return tcSince.string(from: since as NSNumber)
    }

    private var durationStr: String? {
        tcDur.string(from: routine.lastDuration as NSNumber)
    }
}

struct RoutineSinceText_Previews: PreviewProvider {
    struct TestHolder: View {
        var routine: Routine
        @State var now: Date = .now
        var body: some View {
            RoutineSinceText(routine: routine, now: $now)
        }
    }

    static var previews: some View {
        let ctx = PersistenceManager.preview.container.viewContext
        let routine = Routine.create(ctx, userOrder: 0)
        routine.name = "Back & Bicep"
        routine.lastDuration = 1000
        routine.lastStartedAt = Date.now.addingTimeInterval(-2 * 86400)
        return NavigationStack {
            TestHolder(routine: routine)
                .environment(\.managedObjectContext, ctx)
        }
        .environment(\.managedObjectContext, ctx)
    }
}
