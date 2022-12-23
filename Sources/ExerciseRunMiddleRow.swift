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

public enum ExerciseMiddleRowMode {
    case intensity
    case gear
    case sets
}

public struct ExerciseRunMiddleRow<Content: View>: View {
    // MARK: - Parameters

    private var imageName: String
    private var imageColor: Color
    private var onDetail: () -> Void
    private var onTap: () -> Void
    private var content: () -> Content

    public init(imageName: String,
                imageColor: Color,
                onDetail: @escaping () -> Void,
                onTap: @escaping () -> Void,
                content: @escaping () -> Content)
    {
        self.imageName = imageName
        self.imageColor = imageColor
        self.onDetail = onDetail
        self.onTap = onTap
        self.content = content
    }

    // MARK: - Views

    public var body: some View {
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

// struct MiddleRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MiddleRow()
//    }
// }
