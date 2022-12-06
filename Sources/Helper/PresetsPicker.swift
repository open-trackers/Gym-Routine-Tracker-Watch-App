//
//  PresetsPicker.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Collections
import SwiftUI

struct PresetsPicker: View {
    typealias PresetsDictionary = OrderedDictionary<String, [String]>

    var presets: PresetsDictionary
    @Binding var showPresets: Bool
    var onSelect: (String, String) -> Void

    var body: some View {
        List {
            ForEach(presets.keys, id: \.self) { key in
                Section(header: Text(key)) {
                    ForEach(presets[key]!, id: \.self) { name in // .sorted(by: <)
                        Button {
                            onSelect(key, name)
                            showPresets = false
                        } label: {
                            Text(name)
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { self.showPresets = false }
            }
        }
    }
}

struct PresetsList_Previews: PreviewProvider {
    struct TestHolder: View {
        let presets: OrderedDictionary = [
            "Machine/Free Weights": [
                "Abdominal",
                "Arm Curl",
                "Arm Ext",
            ],
            "Bodyweight": [
                "Crunch",
                "Jumping-jack",
                "Jump",
            ],
        ]

        @State var showPresets = false
        var body: some View {
            NavigationStack {
                PresetsPicker(presets: presets, showPresets: $showPresets) {
                    logger.debug("#\(#function): Selected \($0) \($1)")
                }
            }
        }
    }

    static var previews: some View {
        TestHolder()
    }
}
