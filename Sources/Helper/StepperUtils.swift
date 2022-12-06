//
//  StepperUtils.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

func stepperValueDisplay(value: Int16) -> some View {
    Text("\(value)")
        .font(numberFont)
        .fontWeight(numberWeight)
}

func stepperValueDisplay(value: Float, units: Units = .none) -> some View {
    let spec: String = units != .none ? "%0.1f \(units.abbreviation)" : "%0.1f"
    return Text("\(value, specifier: spec)")
        .font(numberFont)
        .fontWeight(numberWeight)
}
