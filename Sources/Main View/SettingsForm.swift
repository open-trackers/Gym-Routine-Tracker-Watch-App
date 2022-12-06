//
//  SettingsForm.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

struct SettingsForm: View {
    @AppStorage(alwaysAdvanceOnLongPressKey) var alwaysAdvanceOnLongPress: Bool = false

    var body: some View {
        Form {
            Section("Exercises") {
                Toggle("On long press, always advance intensity", isOn: $alwaysAdvanceOnLongPress)
            }

//            NavigationLink(destination: { AboutView() }) {
//                HStack {
//                    Text("About Gym Routine Tracker")
//                    // AppIcon()
//                    Spacer(minLength: 5)
//                    Image(systemName: "chevron.forward")
//                }
//            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsForm()
        }
    }
}
