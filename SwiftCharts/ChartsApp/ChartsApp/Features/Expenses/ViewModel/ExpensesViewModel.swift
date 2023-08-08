//
//  ExpensesViewModel.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import Foundation
import Combine

struct ExpenseStates: Identifiable {
    var id: Int { return month }
    let month: Int
    let fixedExpenses: Double
    let variableExpenses: Double
    var totalExpenses: Double { fixedExpenses + variableExpenses }
}

final class ExpensesViewModel: ObservableObject {
    // MARK: - Properties
    @Published private (set) var totalExpenses: Double = 0
    @Published private (set) var expenses: [ExpenseModel] = []
    @Published private (set) var monthlyExpensesData: [ExpenseStates] = []
    @Published private (set) var fixedExpensesData: [(date: Date, amount: Double)] = []
    @Published private (set) var variableExpensesData: [(date: Date, amount: Double)] = []
    @Published private (set) var monthlyFixedExpensesData: [(month: Int, amount: Double)] = []
    @Published private (set) var monthlyVariableExpensesData: [(month: Int, amount: Double)] = []
    
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        $expenses.filter { !$0.isEmpty }.sink { [weak self] expenses in
            guard let self else { return }
            self.fixedExpensesData = self.filteredExpenses(for: .fixed, expenses: expenses)
            self.variableExpensesData = self.filteredExpenses(for: .variable, expenses: expenses)
            
            self.monthlyFixedExpensesData = self.expensesByMonth(for: .fixed, expenses: expenses)
            self.monthlyVariableExpensesData = self.expensesByMonth(for: .variable, expenses: expenses)
            
            self.monthlyExpensesData = self.calculateTotalMonthlyExpenses(self.monthlyFixedExpensesData,
                                                                          variableExpense: self.monthlyVariableExpensesData)
            self.totalExpenses = self.calculateTotal(for: expenses)
        }
        .store(in: &subscriptions)
    }
    
    // MARK: - Preview
    static var previewData: ExpensesViewModel {
        let viewModel = ExpensesViewModel()
        viewModel.expenses = ExpenseModel.yearExamples
        return viewModel
    }
}

// MARK: - Helpers
private extension ExpensesViewModel {
    func filteredExpenses(for category: ExpenseCategory, expenses: [ExpenseModel]) ->  [(date: Date, amount: Double)] {
        let result = expenses.filter { $0.category == category }
        return result.sorted(by: { $0.expenseDate < $1.expenseDate }).map { (date: $0.expenseDate, amount: $0.amount) }
    }
    
    func expensesByMonth(for category: ExpenseCategory, expenses: [ExpenseModel]) -> [(month: Int, amount: Double)] {
        let calendar = Calendar.current
        var expensesByMonth: [Int: Double] = [:]
        
        for expense in expenses where expense.category == category {
            let month = calendar.component(.month, from: expense.expenseDate)
            expensesByMonth[month, default: 0] += expense.amount
        }
        
        let result = expensesByMonth.map { (month: $0.key, amount: $0.value) }
        return result.sorted { $0.month < $1.month }
    }
    
    func calculateTotalMonthlyExpenses(_ fixedExpenses: [(month: Int, amount: Double)],
                                       variableExpense: [(month: Int, amount: Double)]) -> [ExpenseStates] {
        var result = [ExpenseStates]()
        let count = min(fixedExpenses.count, variableExpense.count)
        
        for index in 0..<count {
            let month = fixedExpenses[index].month
            result.append(ExpenseStates(month: month,
                                        fixedExpenses: fixedExpenses[index].amount,
                                        variableExpenses: variableExpense[index].amount))
        }
        
        return result
    }
    
    func calculateTotal(for expenses: [ExpenseModel]) -> Double {
        let totalExpenses = expenses.reduce(0) { total, expense in
            total + expense.amount
        }
        return totalExpenses
    }
}
