//
//  Bundle-extension.swift
//
// Copyright 2022  OpenAlloc LLC
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

extension Bundle {
    var appName: String? {
        infoDictionary?["CFBundleName"] as? String
    }

    var displayName: String? {
        infoDictionary?["CFBundleDisplayName"] as? String
    }

    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}
