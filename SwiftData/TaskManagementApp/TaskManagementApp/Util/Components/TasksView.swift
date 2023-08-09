//
//  TasksView.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI

struct TasksView: View {
    // MARK: - Properties
    @State var tasks: [TaskModel]
    
    // MARK: - User Interface
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            if tasks.count > 0 {
                ForEach($tasks) { task in
                    TaskRowView(task: task)
                        .background(alignment: .leading) {
                            if tasks.last?.id != task.id {
                                Rectangle()
                                    .frame(width: 1)
                                    .offset(x: 8)
                                    .padding(.bottom, -35)
                            }
                        }
                }
            } else {
                Spacer()
                Text("No pending task for today")
                    .font(.subheadline)
                    .foregroundStyle(.darkBlue)
                Spacer()
            }
            
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 15)
    }
}

// MARK: - Preview
#Preview {
    ModelPreview { (task: TaskModel) in
        TasksView(tasks: [task])
    }
}
