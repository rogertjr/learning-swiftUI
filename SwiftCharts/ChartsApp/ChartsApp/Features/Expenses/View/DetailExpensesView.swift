//
//  DetailExpensesView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI

struct DetailExpensesView: View {
    // MARK: - Properties
    @ObservedObject var expensesViewModel: ExpensesViewModel
    
    // MARK: - User Interface
    var body: some View {
        List {
            Group {
                Section {
                    ExpensesLineChartView(expensesViewModel: expensesViewModel)
                        .padding(.bottom)
                }
                
                Section {
                    Text("Detailed Breakdown of Your Expenses per Month")
                        .bold()
                        .padding(.top)
                    ExpensesDetailGridView(expensesViewModel: expensesViewModel)
                }
            }
            .listRowSeparator(.hidden)
            .listSectionSeparator(.visible)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
        }
        .listStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    DetailExpensesView(expensesViewModel: .previewData)
}
