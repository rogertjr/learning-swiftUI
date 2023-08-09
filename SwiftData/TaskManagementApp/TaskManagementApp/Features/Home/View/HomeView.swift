//
//  HomeView.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    // MARK: - Properties
    @StateObject var viewModel: HomeViewModel = .previewData
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [.init(\TaskModel.title), .init(\TaskModel.creationDate, order: .reverse)], animation: .bouncy) var allTasks: [TaskModel]
    
    // MARK: - User Interface
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            HeaderView(viewModel: viewModel)
            
            ScrollView(.vertical) {
                VStack {
                    TasksView(tasks: allTasks)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .center)
            }
            .scrollIndicators(.hidden)
        })
        .frame(maxHeight: .infinity, alignment: .top)
        .overlay(alignment: .bottomTrailing, content: {
            Button(action: {
                viewModel.createNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 55, height: 55)
                    .background(.darkBlue.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10)), in: .circle)
            })
            .padding(15)
        })
        .onAppear(perform: {
            if viewModel.weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date {
                    viewModel.weekSlider.append(firstDate.createPreviousWeek())
                }
                
                viewModel.weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    viewModel.weekSlider.append(lastDate.createNextWeek())
                }
            }
        })
        .sheet(isPresented: $viewModel.createNewTask, content: {
            NewTaskView(viewModel: viewModel)
                .modelContainer(for: TaskModel.self, inMemory: true)
                .presentationDetents([.height(350)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
                .presentationBackground(.customBackground)
                .onDisappear {
                    // TODO: - Update context on modal dismiss
                }
        })
    }
}

// MARK: - Preview
#Preview {
    HomeView(viewModel: .previewData)
        .modelContainer(previewContainer)
}
