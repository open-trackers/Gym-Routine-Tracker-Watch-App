//
//  WatchNavigationStack.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/21/22.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchNavigationStack: View {
    // MARK: - Parameters

    @Binding private var navData: Data?
    private var rootContent: () -> AnyView

    public init(navData: Binding<Data?>,
                @ViewBuilder rootContent: @escaping () -> AnyView)
    {
        _navData = navData
        self.rootContent = rootContent
    }

    // MARK: - Locals

    // MARK: - Views

    var body: some View {
        MyNavigationStack(navData: $navData,
                          standardViews: WatchStandardViews(),
                          rootContent: rootContent)
    }
}

// struct WatchNavigationStack_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchNavigationStack()
//    }
// }
