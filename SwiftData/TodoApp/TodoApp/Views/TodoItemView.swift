//
//  TodoItemView.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI

struct TodoItemView: View {
    // MARK: - Properties
    let task: TaskModel
    
    // MARK: - User Interface
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(task.isDone ? .green : .gray)
                
                Text(task.title)
            }
            Text(task.creationDate, format: Date.FormatStyle(date: .numeric, time: .none))
        }
    }
}

// MARK: - Preview
#Preview {
    ModelPreview { task in
        TodoItemView(task: task)
    }
}
