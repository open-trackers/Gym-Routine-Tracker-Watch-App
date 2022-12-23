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
    @Binding private var middleMode: ExerciseMiddleRowMode
    private var rootContent: () -> AnyView

    public init(navData: Binding<Data?>,
                middleMode: Binding<ExerciseMiddleRowMode>,
                @ViewBuilder rootContent: @escaping () -> AnyView)
    {
        _navData = navData
        _middleMode = middleMode
        self.rootContent = rootContent
    }

    // MARK: - Locals

    //TODO should be param?
    //@State private var middleMode: ExerciseMiddleRowMode = .intensity
    
    // MARK: - Views

    var body: some View {
        MyNavigationStack(navData: $navData,
                          standardViews: WatchStandardViews(middleMode: $middleMode),
                          rootContent: rootContent)
    }
}

// struct WatchNavigationStack_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchNavigationStack()
//    }
// }
