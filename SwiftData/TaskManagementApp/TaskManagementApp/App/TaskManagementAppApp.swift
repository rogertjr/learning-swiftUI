//
//  TaskManagementAppApp.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import SwiftData

@main
struct TaskManagementAppApp: App {

    var body: some Scene {
        WindowGroup {
            HomeView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.customBackground)
                .preferredColorScheme(.light)
        }
        .modelContainer(for: TaskModel.self)
    }
}
