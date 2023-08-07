//
//  TodoListView.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Task>{ !$0.isDone },
           sort: [.init(\Task.title), .init(\Task.creationDate, order: .reverse)],
           animation: .bouncy) private var todos: [Task]
    
    @Query(filter: #Predicate<Task>{ $0.isDone },
           sort: [.init(\Task.title), .init(\Task.creationDate, order: .reverse)],
           animation: .bouncy) private var finishedTasks: [Task]
    
    // MARK: - User Interface
    var body: some View {
        NavigationSplitView {
            List {
                Section("To Do") {
                    ForEach(todos) { task in
                        NavigationLink {
                            TodoDetailView(task: task)
                        } label: {
                            TodoItemView(task: task)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                
                Section("Done") {
                    ForEach(finishedTasks) { task in
                        TodoItemView(task: task)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("My Todos")
        } detail: {
            Text("Select an item")
        }
    }

    // MARK: - Action Handlers
    private func addItem() {
        let newTask = Task("task \(todos.count + 1)")
        modelContext.insert(newTask)
    }

    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(todos[index])
        }
    }
}

// MARK: - Preview
#Preview {
    TodoListView()
        .modelContainer(for: Task.self, inMemory: true)
}
