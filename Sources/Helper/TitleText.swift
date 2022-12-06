//
//  TitleText.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

struct TitleText: View {
    private var text: String

    internal init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(titleWeight)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleText("This is a test")
    }
}
