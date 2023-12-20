//
//  TransactionCardView.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 15/12/23.
//

import SwiftUI
import SwiftData

struct TransactionCardView: View {
	// MARK: - Properties
	@Environment(\.modelContext) private var modelContext
	var transaction: Transaction
	var showCategory: Bool = false
	
	// MARK: - Layout
    var body: some View {
		SwipeAction(cornerRadius: 10, direction: .trailing) {
			HStack(spacing: 12) {
				Text("\(String(transaction.title.prefix(1)))")
					.font(.title)
					.fontWeight(.semibold)
					.foregroundStyle(.white)
					.frame(width: 45, height: 45)
					.background(transaction.color.gradient, in: .circle)
				
				VStack(alignment: .leading, spacing: 4) {
					Text(transaction.title)
						.foregroundStyle(.primary)
					
					Text(transaction.remarks)
						.font(.caption)
						.foregroundStyle(.primary.secondary)
					
					Text(format(transaction.dateAdded, format: "dd MM yyyy"))
						.font(.caption2)
						.foregroundStyle(.gray)
					
					if showCategory {
						Text(transaction.category)
							.font(.caption2)
							.foregroundStyle(.white)
							.padding(.horizontal, 5)
							.padding(.vertical, 2)
							.background(transaction.category == Category.income.rawValue ? Color.green.gradient : Color.red.gradient, in: .capsule)
					}
				}
				.lineLimit(1)
				.frame(maxWidth: .infinity, alignment: .leading)
				
				Text(currencyString(transaction.amount, maxDigits: 2))
					.fontWeight(.semibold)
			}
			.padding(.horizontal, 15)
			.padding(.vertical, 10)
			.background(.background, in: .rect(cornerRadius: 10))
		} actions: {
			Action(tint: .red, icon: "trash") { 
				modelContext.delete(transaction)
			}
		}
    }
}

// MARK: - Preview
#Preview {
	let config = ModelConfiguration(isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: Transaction.self, configurations: config)

	let transaction = Transaction(title: "AirPods",
								  remarks: "Apple Product",
								  amount: .zero,
								  dateAdded: .now,
								  category: .expense,
								  tintColor: .init(color: "Red", value: .red))
	container.mainContext.insert(transaction)
	
	return TransactionCardView(transaction: transaction)
		.modelContainer(container)
		.previewLayout(.sizeThatFits)
}
