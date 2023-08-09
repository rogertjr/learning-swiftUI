//
//  ExpensesBarChartView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import Charts

struct ExpensesBarChartView: View {
    // MARK: - Properties
    @ObservedObject var expensesViewModel: ExpensesViewModel
    private let formatter = DateFormatter()
    
    // MARK: - User Interface
    var body: some View {
        Chart {
            ForEach(expensesViewModel.monthlyFixedExpensesData, id: \.month) { expenseData in
                BarMark(x: .value("Month", formatter.month(for: expenseData.month)),
                        y: .value("Expense", expenseData.amount))
            }
            .foregroundStyle(by: .value("Expense", "fixed"))
            .symbol(by: .value("Expense", "fixed"))
            .position(by: .value("Expenses", "fixed"))
            
            ForEach(expensesViewModel.monthlyVariableExpensesData, id: \.month) { expenseData in
                BarMark(x: .value("Date", formatter.month(for: expenseData.month)),
                        y: .value("Expense", expenseData.amount))
            }
            .foregroundStyle(by: .value("Expense", "variable"))
            .symbol(by: .value("Expense", "variable"))
            .position(by: .value("Expenses", "variable"))
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

// MARK: - Preview
#Preview {
    ExpensesBarChartView(expensesViewModel: .previewData)
}
