//
//  WatchRoutineDetail.swift
//  Gym Routine Tracker
//
//  Created by Reed Esau on 12/21/22.
//

import SwiftUI

import GroutLib
import GroutUI

struct WatchRoutineDetail: View {
    @EnvironmentObject private var router: MyRouter

    @SceneStorage("RoutineDetailTab") private var selectedTab: Int = 0

    @ObservedObject var routine: Routine

    var body: some View {
        TabView(selection: $selectedTab) {
            Form {
                Section("Name") {
                    TextFieldWithPresets($routine.wrappedName,
                                         prompt: "Enter routine name",
                                         color: routineColor,
                                         presets: routinePresets)
                }

                Section("Image") {
                    ImageStepper(initialName: routine.imageName, imageNames: systemImageNames) {
                        routine.imageName = $0
                    }
                }
            }
            .tabItem {
                Text("Properties")
            }
            .tag(0)

            FakeSection("Exercises") {
                ExerciseList(routine: routine)
                // .environmentObject(router)
            }
            .tabItem {
                Text("Exercises")
            }
            .tag(1)
        }
        .tabViewStyle(.page)
        .navigationTitle {
            Text("Routine")
                .foregroundColor(routineColor)
        }
        .onDisappear(perform: onDisappearAction)
    }

    // MARK: - Properties

    // MARK: - Actions

    private func onDisappearAction() {
        logger.debug("Routine Detail, onDisappear")
        PersistenceManager.shared.save()
    }
}

// struct WatchRoutineDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineDetail()
//    }
// }
