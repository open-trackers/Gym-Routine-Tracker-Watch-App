//
//  StatusView.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import Compactor

import GroutLib

struct ElapsedView: View {
    var startedAt: Date

    // MARK: - Locals

    private let tc: TimeCompactor = .init(ifZero: "", style: .short, roundSmallToWhole: false)

    @State private var now = Date()
    private let timer = Timer.publish(every: 1,
                                      on: .current,
                                      in: .common).autoconnect()

    // MARK: - Views

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(routineColor.opacity(0.2))
                TitleText(remainingStr)
                    .fontDesign(.monospaced)
                    .padding(.horizontal)
                    .foregroundStyle(routineColor)
            }
            Text("Elapsed")
                .font(.caption2)
                .lineLimit(1)
        }
        .onReceive(timer) { _ in
            self.now = Date.now
        }
        .onAppear {
            self.now = Date.now
        }
    }

    // MARK: - Properties

    private var remainingStr: String {
        let secondsPerHour: TimeInterval = 3600
        let et = elapsedTime
        if et >= secondsPerHour {
            return tc.string(from: et as NSNumber) ?? ""
        }
        let t = Int(max(0, min(et, TimeInterval(Int.max))))
        let minutes = t / 60 % 60
        let seconds = t % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }

    private var elapsedTime: TimeInterval {
        now.timeIntervalSince(startedAt)
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedView(startedAt: Date.now.addingTimeInterval(-3590))
            .frame(height: 80)
    }
}
