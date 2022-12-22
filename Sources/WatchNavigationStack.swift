//
//  WatchNavigationStack.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/21/22.
//

import SwiftUI

import GroutUI
import GroutLib

struct WatchNavigationStack: View {
    @Environment(\.managedObjectContext) private var viewContext
    
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

    @StateObject private var router: MyRouter = .init()
    
    // MARK: - Views
    
    var body: some View {
        NavigationStack(path: $router.path) {
            rootContent()
                .environmentObject(router)
                .environment(\.managedObjectContext, viewContext)
                .navigationDestination(for: MyRoutes.self) { route in
                    switch route {
                    case .settings:
                        SettingsForm()
                    case .about:
                        AboutView()
//                    case .routines:
//                        // TODO: is this even necessary?
//                        RoutineList()
                    case let .routineDetail(routineURI):
                        if let routine = Routine.get(viewContext, forURIRepresentation: routineURI) {
                            WatchRoutineDetail(routine: routine)
                                .environmentObject(router)
                                .environment(\.managedObjectContext, viewContext)
                        } else {
                            Text("Routine not available to display detail.")
                        }
                    case let .exerciseList(routineURI):
                        if let routine = Routine.get(viewContext, forURIRepresentation: routineURI) {
                            ExerciseList(routine: routine)
                                .environmentObject(router)
                                .environment(\.managedObjectContext, viewContext)
                        } else {
                            Text("Routine not available to display exercise list.")
                        }
                    case let .exerciseDetail(exerciseURI):
                        if let exercise = Exercise.get(viewContext, forURIRepresentation: exerciseURI) {
                            //TODO Watch version
                            Text("Watch Exercise Detail \(exercise.wrappedName)")
//                            ExerciseDetail(exercise: exercise)
                                .environmentObject(router)
                                .environment(\.managedObjectContext, viewContext)
                        } else {
                            Text("Exercise not available to display detail.")
                        }
                    }
                }
        }
    }
}

//struct WatchNavigationStack_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchNavigationStack()
//    }
//}
