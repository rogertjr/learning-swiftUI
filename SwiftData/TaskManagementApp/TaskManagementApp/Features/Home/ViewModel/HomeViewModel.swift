//
//  HomeViewModel.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import SwiftData

final class HomeViewModel: ObservableObject {
    // MARK: - Properties
    // Calendar
    @Published var currentDate: Date = .init()
    @Published var weekSlider: [[Date.WeekDay]] = []
    @Published var currentWeekIndex: Int = 1
    @Published var createWeek: Bool = false
    @Published var createNewTask: Bool = false
    // New Task
    @Published var taskTitle: String = ""
    @Published var taskDate: Date = .init()
    @Published var taskColor: Color = .taskColor1
    
    // MARK: - Helpers
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    func paginateWeek() {
        /// SafeCheck
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                /// Inserting New Week at 0th Index and Removing Last Array Item
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                /// Appending New Week at Last Index and Removing First Array Item
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
    
    func resetNewTaskFields() {
        taskTitle = ""
        taskDate = .init()
        taskColor = .taskColor1
    }
    
    // MARK: - Preview
    static var previewData: HomeViewModel {
        let viewModel = HomeViewModel()
        return viewModel
    }
}
