//
//  WidgetGRT.swift
//
// Copyright 2023  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI
import WidgetKit

import GroutLib
import GroutUI

@main
struct WidgetGRT: Widget {
    let kind: String = "WidgetGRT"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(entry: entry)
        }
        .configurationDisplayName("Gym Routines")
        .description("Time since last gym routine.")
        .supportedFamilies([.accessoryCircular])
    }
}

struct WidgetGRT_Previews: PreviewProvider {
    static var previews: some View {
        let entry = WidgetEntry(name: "Blah", imageName: nil, timeInterval: 1000, color: nil)
        return WidgetView(entry: entry)
            .accentColor(.blue)
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
