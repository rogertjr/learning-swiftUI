//
//  SimpleExpensesView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import Charts

struct SimpleExpensesView: View {
    // MARK: - Properties
    @ObservedObject var expensesViewModel: ExpensesViewModel
    private let formatter = DateFormatter()
    
    // MARK: - User Interface
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Your total expenses for the last year are ") +
            Text("$\(String(format: "%.2f", expensesViewModel.totalExpenses)).")
                .bold()
                .foregroundColor(Color.pink)
            
            Chart {
                Plot {
                    ForEach(expensesViewModel.monthlyExpensesData) { expenseData in
                        AreaMark(x: .value("Date", expenseData.month),
                                 y: .value("Expense", expenseData.totalExpenses))
                    }
                }
                .interpolationMethod(.linear)
                .foregroundStyle(.pink)
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .chartLegend(.hidden)
            .chartXScale(domain: 1...13)
            .frame(height: 70)
        }
    }
}

// MARK: - Preview
#Preview {
    SimpleExpensesView(expensesViewModel: .previewData)
        .padding()
}
