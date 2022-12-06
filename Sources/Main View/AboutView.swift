//
//  AboutView.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .center) {
            AppIcon()
                .frame(width: 40, height: 40)
                .padding(.bottom, 5)

            Text(Bundle.main.displayName ?? "unknown app")
                .font(.title3)
            Text("Version: \(Bundle.main.releaseVersionNumber ?? "unknown") (build \(Bundle.main.buildNumber ?? "?"))")
                .foregroundColor(.secondary)
                .padding(.bottom)

            Text("WEBSITE")
                .font(.footnote)
                .foregroundColor(.secondary)
            Text(websiteDomain)
                .font(.footnote)
                .foregroundStyle(routineColor)
                .padding(.bottom)

            Text(copyright)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .minimumScaleFactor(0.5)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
