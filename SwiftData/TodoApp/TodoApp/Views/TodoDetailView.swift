//
//  TodoDetailView.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import SwiftData

struct TodoDetailView: View {
    // MARK: - Properties
    @Bindable var task: Task
    
    // MARK: - User Interface
    var body: some View {
        VStack (spacing: 8) {
            TextField(task.title, text: $task.title)
                .textFieldStyle(.roundedBorder)
            
            Toggle(task.isDone ? "Done" : "Not Completed", isOn:  $task.isDone)
            
            HStack {
                Text("Tags: ")
                ForEach(task.tags?.sorted(by: { $0.name < $1.name }) ?? []) { tag in
                    Text(tag.name)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(tag.color.toSwiftUIColor(), lineWidth: 2)
                        }
                        .onTapGesture {
                            guard let tagIndex = task.tags?.firstIndex(where: { $0 == tag }) else { return }
                            task.tags?.remove(at: tagIndex)
                        }
                }
            }
            
            Button {
                let tag = Tag("dummyTag", color: RGBColor(.blue))
                task.tags?.append(tag)
            } label: {
                Text("Add a tag")
            }
        }
        .padding()
        .navigationTitle("Task Detail")
    }
}

// MARK: - Preview
//#Preview {
//    TodoDetailView(task: Task("Task 01", isDone: false, priority: 0))
//}
