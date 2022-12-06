//
//  ImageStepper.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib

struct ImageStepper: View {
    private var initialName: String?
    private var imageNames: [String]
    private var onSelect: (String) -> Void

    internal init(initialName: String? = nil, imageNames: [String], onSelect: @escaping (String) -> Void) {
        self.initialName = initialName
        self.imageNames = imageNames
        self.onSelect = onSelect

        let index = imageNames.firstIndex(where: { $0 == initialName }) ?? 0
        _index = State(initialValue: index)
    }

    // MARK: - Locals

    @State private var index: Int = 0

    var body: some View {
        Stepper(value: $index, in: 0 ... imageNames.count - 1) {
            Image(systemName: imageNames[index])
                .imageScale(.small)
        }.onChange(of: index) { newValue in
            onSelect(imageNames[newValue])
        }
        .symbolRenderingMode(.hierarchical)
        .frame(height: 65)
    }
}

struct SystemImageStepper_Previews: PreviewProvider {
    static var previews: some View {
        ImageStepper(initialName: "flame", imageNames: systemImageNames, onSelect: { _ in })
    }
}
