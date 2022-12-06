//
//  ActionButton.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

struct ActionButton: View {
    var action: () -> Void
    var imageSystemName: String // "arrow.backward"
    var buttonText: String? // "Previous"
    var tint: Color
    var onLongPress: (() -> Void)?

    var body: some View {
        VStack {
            Group {
                if onLongPress != nil {
                    Button(action: {}, label: label)
                        .simultaneousGesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    onLongPress?()
                                }
                        )
                        .highPriorityGesture(
                            TapGesture()
                                .onEnded { _ in
                                    action()
                                }
                        )
                } else {
                    Button(action: action, label: label)
                }
            }
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.tint)
            .tint(tint)
            .font(.title)
            .fontWeight(.bold)

            if let _text = buttonText {
                Text(_text)
                    .font(.caption2)
                    .lineLimit(1)
            }
        }
    }

    private func label() -> some View {
        Image(systemName: imageSystemName)
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(action: {}, imageSystemName: "arrow.backward", buttonText: "Previous", tint: .green)
    }
}
