//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import SwiftData

@main
struct TodoAppApp: App {

    var body: some Scene {
        WindowGroup {
            TodoListView()
        }
        .modelContainer(for: Task.self)
    }
}
