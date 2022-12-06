//
//  AppIcon.swift
//  Gym Routine Tracker Watch App
//
//  Created by Reed Esau on 12/4/22.
//

import SwiftUI

struct AppIcon: View {
    var body: some View {
        if let img = UIImage(named: "grt_icon") {
            Image(uiImage: img)
                .resizable()
        } else {
            // in case the AppIcon has been stripped from the bundle
            Image(systemName: "info.circle")
        }
    }
}

struct AppIcon_Previews: PreviewProvider {
    static var previews: some View {
        AppIcon()
    }
}
