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
    // MARK: - Parameters

    var action: () -> Void
    var imageSystemName: String // "arrow.backward"
    var buttonText: String? // "Previous"
    var tint: Color
    var onLongPress: (() -> Void)?

    // MARK: - Views

    var body: some View {
        ActionButton(action: action,
                     imageSystemName: imageSystemName,
                     buttonText: buttonText,
                     tint: tint,
                     xbody: xbody,
                     label: label,
                     onLongPress: onLongPress)
    }

    private func xbody(_ button: AnyView) -> some View {
        button
            .foregroundStyle(.tint)
            .tint(tint)
            .font(.title)
            .fontWeight(.bold)
    }

    private func label(_ imageSystemName: String) -> some View {
        Image(systemName: imageSystemName)
            .symbolRenderingMode(.hierarchical)
    }
}

// struct WatchActionButton_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchActionButton()
//    }
// }
