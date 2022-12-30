//
//  WatchActionButton.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchActionButton: View {
    // MARK: - Parameters

    var action: () -> Void
    var imageSystemName: String // "arrow.backward"
    var buttonText: String? // "Previous"
    var tint: Color
    var onLongPress: (() -> Void)?

    // MARK: - Views

    var body: some View {
        ActionButton(action: action,
                     imageSystemName: imageSystemName,
                     buttonText: buttonText,
                     tint: tint,
                     buttonBody: buttonBody,
                     label: label,
                     onLongPress: onLongPress)
    }

    private func buttonBody(_ button: AnyView) -> some View {
        button
            .foregroundStyle(.tint)
            .tint(tint)
            .font(.title)
            .fontWeight(.bold)
    }

    private func label(_ imageSystemName: String) -> some View {
        Image(systemName: imageSystemName)
            .symbolRenderingMode(.hierarchical)
    }
}

struct WatchActionButton_Previews: PreviewProvider {
    static var previews: some View {
        WatchActionButton(action: {}, imageSystemName: "arrow.right", tint: .blue)
    }
}
