//
//  TextFieldWithPresets.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Collections
import SwiftUI

struct TextFieldWithPresets: View {
    // MARK: - Parameters

    @Binding private var name: String
    private var prompt: String
    private var color: Color
    private var presets: PresetsPicker.PresetsDictionary

    internal init(_ name: Binding<String>, prompt: String, color: Color, presets: PresetsPicker.PresetsDictionary) {
        _name = name
        self.prompt = prompt
        self.color = color
        self.presets = presets
    }

    // MARK: - Locals

    @State private var showPresetNames = false

    // MARK: - Views

    var body: some View {
        HStack {
            TextField(text: $name, prompt: Text(prompt)) { EmptyView() }
            Button(action: { showPresetNames = true }) {
                Image(systemName: "line.3.horizontal.decrease")
                    .imageScale(.large)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(color)
            }
            .buttonStyle(.borderless)
        }
        .font(.title3)
        .sheet(isPresented: $showPresetNames) {
            NavigationStack {
                PresetsPicker(presets: presets, showPresets: $showPresetNames) { _, presetName in
                    name = presetName
                }
            }
            .interactiveDismissDisabled() // NOTE: needed to prevent home button from dismissing sheet
        }
    }
}

struct NameTextField_Previews: PreviewProvider {
    struct TestHolder: View {
        let presets: OrderedDictionary = [
            "Machine/Free Weights": [
                "Abdominal",
                "Arm Curl",
            ],
            "Bodyweight": [
                "Crunch",
                "Jumping-jack",
            ],
        ]
        @State var name: String = "Back & Bicep"
        var body: some View {
            TextFieldWithPresets($name, prompt: "Enter name", color: .teal, presets: presets)
        }
    }

    static var previews: some View {
        TestHolder()
    }
}
