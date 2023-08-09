//
//  NewTaskView.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI

struct NewTaskView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: HomeViewModel
    
    // MARK: - User Interface
    private var closeButtonView: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .tint(.red)
        })
    }
    
    private var textfieldView: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text("Title")
                .font(.caption)
                .foregroundStyle(.gray)
            
            TextField("Enter a title for your task", text: $viewModel.taskTitle)
                .padding(.vertical, 12)
                .padding(.horizontal, 15)
                .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
        })
    }
    
    private var taskDatePickerView: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text("Date")
                .font(.caption)
                .foregroundStyle(.gray)
            
            DatePicker("", selection: $viewModel.taskDate)
                .datePickerStyle(.compact)
                .scaleEffect(0.9, anchor: .leading)
        })
    }
    
    private var taskColorView: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text("Color")
                .font(.caption)
                .foregroundStyle(.gray)
            
            let colors: [Color] = [.taskColor1, .taskColor2, .taskColor3, .taskColor4, .taskColor5]
            
            HStack(spacing: 0) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 20, height: 20)
                        .background(content: {
                            Circle()
                                .stroke(lineWidth: 2)
                                .opacity(viewModel.taskColor == color ? 1 : 0)
                        })
                        .frame(maxWidth: .infinity, alignment: .center)
                        .contentShape(.rect)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                viewModel.taskColor = color
                            }
                        }
                }
            }
        })
    }
    
    private var createButtonView: some View {
        Button(action: {
            saveNewTask()
        }, label: {
            Text("Create Task")
                .font(.title3)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 12)
                .background(viewModel.taskColor, in: .rect(cornerRadius: 10))
        })
        .disabled(viewModel.taskTitle == "")
        .opacity(viewModel.taskTitle == "" ? 0.5 : 1)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            closeButtonView
                .frame(maxWidth: .infinity, alignment: .leading)
            
            textfieldView
                .padding(.top, 5)
            
            HStack(spacing: 12) {
                taskDatePickerView
                taskColorView
            }
            .padding(.top, 5)
            .padding(.trailing)
            
            Spacer(minLength: 0)
            
            createButtonView
        })
        .padding(15)
    }
    
    // MARK: - Helpers
    private func saveNewTask() {
        let newTask = TaskModel(title: viewModel.taskTitle,
                                creationDate: viewModel.taskDate,
                                isCompleted: false,
                                tint: RGBColorModel(viewModel.taskColor))
        modelContext.insert(newTask)
        viewModel.resetNewTaskFields()
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    NewTaskView(viewModel: .previewData)
        .previewLayout(.sizeThatFits)
}
