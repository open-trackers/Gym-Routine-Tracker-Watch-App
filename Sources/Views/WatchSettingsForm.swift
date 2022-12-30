//
//  WatchSettingsForm.swift
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

struct WatchSettingsForm: View {
    @EnvironmentObject private var router: MyRouter

    var body: some View {
        SettingsForm {
            // NOTE no watch-specific settings yet
            EmptyView()
        }
    }
}

struct WatchSettingsForm_Previews: PreviewProvider {
    static var previews: some View {
        WatchSettingsForm()
    }
}
