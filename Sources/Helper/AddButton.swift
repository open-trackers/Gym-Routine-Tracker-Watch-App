//
//  AddButton.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

struct AddButton: View {
    var addAction: () -> Void
    var title: String

    var body: some View {
        Button(action: addAction) {
            Label("Add \(title)", systemImage: "plus.circle.fill")
                .symbolRenderingMode(.hierarchical)
        }
        .foregroundStyle(.tint)
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(addAction: {}, title: "Routine")
            .tint(.accentColor)
    }
}
