//
//  ListOfExepenseView.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 21/12/23.
//

import SwiftUI

struct ListOfExepenseView: View {
	// MARK: - Properties
	let month: Date
	
	// MARK: - Layout
    var body: some View {
		ScrollView(.vertical) {
			LazyVStack(spacing: 15) {
				Section {
					FilterTransactionView(statDate: month.startOfMonth, endDate: month.endOfMonth, category: .income) { transactions in
						ForEach(transactions) { transaction in
							NavigationLink {
								TransactionView(editTransaction: transaction)
							} label: {
								TransactionCardView(transaction: transaction)
							}
							.buttonStyle(.plain)
						}
					}
				} header: {
					Text("Income")
						.font(.caption)
						.foregroundStyle(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
				}

				Section {
					FilterTransactionView(statDate: month.startOfMonth, endDate: month.endOfMonth, category: .expense) { transactions in
						ForEach(transactions) { transaction in
							NavigationLink {
								TransactionView(editTransaction: transaction)
							} label: {
								TransactionCardView(transaction: transaction)
							}
							.buttonStyle(.plain)
						}
					}
				} header: {
					Text("Expense")
						.font(.caption)
						.foregroundStyle(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
				}
			}
			.padding(15)
		}
		.background(.gray.opacity(0.15))
		.navigationTitle(format(month, format: "MMM yy"))
    }
}

// MARK: - Preview
#Preview {
	ListOfExepenseView(month: .now)
}
