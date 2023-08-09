//
//  ExpensesLineChartView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import Charts

struct ExpensesLineChartView: View {
    // MARK: - Properties
    @ObservedObject var expensesViewModel: ExpensesViewModel
    private let symbolSize: CGFloat = 100
    private let lineWidth: CGFloat = 3
    private let formatter = DateFormatter()
    
    // MARK: - User Interface
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your total expenses for the last year are ") +
            Text("$\(String(format: "%.2f", expensesViewModel.totalExpenses)).")
                .bold()
                .foregroundColor(.pink)
            
            Chart {
                Plot {
                    ForEach(expensesViewModel.monthlyFixedExpensesData, id: \.month) { expenseData in
                        LineMark(x: .value("Month", expenseData.month),
                                 y: .value("Expense", expenseData.amount))
                    }
                    .foregroundStyle(by: .value("Expense", "fixed"))
                    .symbol(by: .value("Expense", "fixed"))
                    
                    ForEach(expensesViewModel.monthlyVariableExpensesData, id: \.month) { expenseData in
                        LineMark(x: .value("Date", expenseData.month),
                                 y: .value("Expense", expenseData.amount))
                    }
                    .foregroundStyle(by: .value("Expense", "variable"))
                    .symbol(by: .value("Expense", "variable"))
                }
                .interpolationMethod(.monotone)
                .lineStyle(StrokeStyle(lineWidth: lineWidth))
            }
            .chartForegroundStyleScale(["variable": .purple, "fixed": .cyan])
            .chartSymbolScale(["variable": Circle().strokeBorder(lineWidth: lineWidth),
                               "fixed": Square().strokeBorder(lineWidth: lineWidth)])
            .aspectRatio(1, contentMode: .fit)
            .chartXScale(domain: 0...13)
            .chartXAxis {
                AxisMarks(values: [1, 4, 7, 10]) { value in
                    AxisGridLine()
                    AxisTick()
                    
                    if let monthNumber = value.as(Int.self), monthNumber > 0, monthNumber < 13 {
                        AxisValueLabel(formatter.month(for: monthNumber), centered: false, anchor: .top)
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ExpensesLineChartView(expensesViewModel: .previewData)
        .padding()
}
