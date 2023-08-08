//
//  ExpensesDetailGridView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI

struct ExpensesDetailGridView: View {
    // MARK: - Properties
    @ObservedObject var expensesViewModel: ExpensesViewModel
    private let formatter = DateFormatter()
    
    // MARK: - User Interface
    var body: some View {
        Grid(alignment: .trailing, horizontalSpacing: 15, verticalSpacing: 10) {
            GridRow {
                Color.clear
                    .gridCellUnsizedAxes([.vertical, .horizontal])
                Text("Fixed")
                    .gridCellAnchor(.center)
                Text("Variable")
                Text("All")
                    .bold()
                    .gridCellAnchor(.center)
            }
            
            Divider()
                .gridCellUnsizedAxes([.vertical, .horizontal])
            
            ForEach(expensesViewModel.monthlyExpensesData) { data in
                GridRow {
                    Text(formatter.month(for: data.month))
                    Text(String(format: "%.2f", data.fixedExpenses))
                    Text(String(format: "%.2f", data.variableExpenses))
                    Text(String(format: "%.2f", data.totalExpenses))
                        .bold()
                }
            }
            
            Divider()
                .gridCellUnsizedAxes([.vertical, .horizontal])
            GridRow {
                Text("Total")
                    .bold()
                
                Color.clear
                    .gridCellUnsizedAxes([.vertical, .horizontal])
                    .gridCellColumns(2)
                
                Text("$" + String(format: "%.2f", expensesViewModel.totalExpenses))
                    .bold()
                    .foregroundStyle(.pink)
                    .fixedSize()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ExpensesDetailGridView(expensesViewModel: .previewData)
        .padding()
}
