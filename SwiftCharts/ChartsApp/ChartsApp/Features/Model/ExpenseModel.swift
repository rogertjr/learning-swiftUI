//
//  ExpenseModel.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation

enum ExpenseCategory {
    case fixed
    case variable
    
    var displayName: String {
        switch self {
            case .fixed: "Fixed"
            case .variable: "Variable"
        }
    }
}

struct ExpenseModel: Identifiable {
    // MARK: - Properties
    let id: UUID = UUID()
    let title: String
    let category: ExpenseCategory
    let amount: Double
    let expenseDate: Date
}

// MARK: - Helpers
extension ExpenseModel {
    static var yearExamples: [ExpenseModel] = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        var expenses = [ExpenseModel]()

        for month in 1...12 {
            for _ in 1...10 {
                let randomDay = Int.random(in: 1...28)
                let date = formatter.date(from: "2023/\(month)/\(randomDay)")!
                let category: ExpenseCategory = Bool.random() ? .fixed : .variable
                let title = category == .fixed ? "Rent" : "Supplies"
                let amount: Double = category == .fixed ? 2000 : Double.random(in: 100...500)
                expenses.append(ExpenseModel(title: title, category: category, amount: amount, expenseDate: date))
            }
        }
        return expenses
    }()
}

// MARK: - Dummy
extension ExpenseModel {
    static var examples = [
        ExpenseModel(title: "Rent", category: .fixed, amount: 2000, expenseDate: Date(timeIntervalSinceNow: -7_200_000)),
        ExpenseModel(title: "Salaries", category: .fixed, amount: 5000, expenseDate: Date(timeIntervalSinceNow: -14_400_000)),
        ExpenseModel(title: "Utilities", category: .fixed, amount: 600, expenseDate: Date(timeIntervalSinceNow: -21_600_000)),
        ExpenseModel(title: "Marketing", category: .variable, amount: 1000, expenseDate: Date(timeIntervalSinceNow: -28_800_000)),
        ExpenseModel(title: "Inventory", category: .variable, amount: 3000, expenseDate: Date(timeIntervalSinceNow: -36_000_000)),
        ExpenseModel(title: "Maintenance", category: .fixed, amount: 500, expenseDate: Date(timeIntervalSinceNow: -43_200_000)),
        ExpenseModel(title: "Equipment", category: .variable, amount: 1500, expenseDate: Date(timeIntervalSinceNow: -50_400_000))
    ]
}
