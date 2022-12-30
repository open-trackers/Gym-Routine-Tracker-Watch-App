//
//  ExerciseRunMiddleRow.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

enum ExerciseMiddleRowMode: Int {
    case intensity = 0
    case settings = 1
    case volume = 2
}

struct ExerciseRunMiddleRow<Content: View>: View {
    // MARK: - Parameters

    var imageName: String
    var imageColor: Color
    var onDetail: () -> Void
    var onTap: () -> Void
    var content: () -> Content

    // MARK: - Views

    var body: some View {
        HStack {
            Button(action: onTap) {
                Image(systemName: imageName)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(imageColor)
            }
            .padding(.vertical)
            .buttonStyle(.borderless)
            .font(.title2)
            // .border(.teal)

            Spacer()

            Button(action: onTap) {
                content()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderless)
            // .border(.teal)

            Spacer()

            Button(action: onDetail) {
                Image(systemName: "ellipsis.circle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.yellow)
            }
            .padding(.vertical)
            .buttonStyle(.borderless)
            .font(.title2)
            // .border(.teal)
        }
    }
}

struct ExerciseRunMiddleRow_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRunMiddleRow(imageName: "gearshape", imageColor: .blue, onDetail: {}, onTap: {}) {
            Text("Settings")
        }
    }
}
