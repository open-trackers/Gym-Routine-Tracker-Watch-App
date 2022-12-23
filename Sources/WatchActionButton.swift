//
//  WatchActionButton.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/22/22.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchActionButton: View {
    var action: () -> Void
    var imageSystemName: String // "arrow.backward"
    var buttonText: String? // "Previous"
    var tint: Color
    var onLongPress: (() -> Void)?

    var body: some View {
        ActionButton(action: action, imageSystemName: imageSystemName, buttonText: buttonText, tint: tint, onLongPress: onLongPress)

        // TODO: button body
    }
}

// struct WatchActionButton_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchActionButton()
//    }
// }
