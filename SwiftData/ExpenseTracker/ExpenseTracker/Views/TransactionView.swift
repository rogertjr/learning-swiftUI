//
//  NewExpenseView.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 20/12/23.
//

import SwiftUI

struct TransactionView: View {
	// MARK: - Properties
	@Environment(\.modelContext) private var context
	@Environment(\.dismiss) private var dismiss
	
	var editTransaction: Transaction?
	
	@State private var title: String = ""
	@State private var remarks: String = ""
	@State private var amount: Double = .zero
	@State private var dateAdded: Date = .now
	@State private var category: Category = .expense
	@State private var tint: TintColor = tints.randomElement()!
	
	private var numberFormatter: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 2
		return formatter
	}
	
	// MARK: - Layout
    var body: some View {
		ScrollView(.vertical) {
			VStack(spacing: 15) {
				Text("Preview")
					.font(.caption)
					.foregroundStyle(.gray)
					.frame(maxWidth: .infinity, alignment: .leading)
				
				TransactionCardView(transaction: .init(title: title.isEmpty ? "Title" : title,
													   remarks: remarks.isEmpty ? "Remarks" : remarks,
													   amount: amount,
													   dateAdded: dateAdded,
													   category: category,
													   tintColor: tint))
				customSection("Title", hint: "Title", value: $title)
				customSection("Remarks", hint: "Remark", value: $remarks)
				
				VStack(alignment: .leading, spacing: 10) {
					Text("Amount & Category")
						.font(.caption)
						.foregroundStyle(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					HStack(spacing: 15) {
						HStack(spacing: 4) {
							Text(currencySymbol)
								.font(.callout.bold())
							
							TextField("0.0", value: $amount, formatter: numberFormatter)
								.keyboardType(.decimalPad)
						}
						.padding(.horizontal, 15)
						.padding(.vertical, 12)
						.background(.background, in: .rect(cornerRadius: 10))
						.frame(maxWidth: 130)
						
						customCategoryCheckbox()
					}
				}
				
				
				VStack(alignment: .leading, spacing: 10) {
					Text("Date")
						.font(.caption)
						.foregroundStyle(.gray)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					DatePicker("", selection: $dateAdded, displayedComponents: [.date])
						.datePickerStyle(.graphical)
						.padding(.horizontal, 15)
						.padding(.vertical, 12)
						.background(.background, in: .rect(cornerRadius: 10))
				}
			}
			.padding(15)
		}
		.navigationTitle("\(editTransaction != nil ? "Edit" : "Add") Transaction")
		.background(.gray.opacity(0.15))
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button("Save", action: save)
			}
		}
		.onAppear {
			if let editTransaction {
				title = editTransaction.title
				remarks = editTransaction.remarks
				dateAdded = editTransaction.dateAdded
				if let category = editTransaction.rawCategory {
					self.category = category
				}
				if let tint = editTransaction.tint {
					self.tint = tint
				}
				amount = editTransaction.amount
			}
		}
    }
	
	func save() {
		if editTransaction != nil {
			editTransaction?.title = title
			editTransaction?.remarks = remarks
			editTransaction?.amount = amount
			editTransaction?.dateAdded = dateAdded
			editTransaction?.category = category.rawValue
		} else {
			let newTransaction = Transaction(title: title,
											 remarks: remarks,
											 amount: amount,
											 dateAdded: dateAdded,
											 category: category,
											 tintColor: tint)
			context.insert(newTransaction)
		}
		dismiss()
	}
}

// MARK: - Builders
private extension TransactionView {
	@ViewBuilder
	func customSection(_ title: String, hint: String, value: Binding<String>) -> some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(title)
				.font(.caption)
				.foregroundStyle(.gray)
				.frame(maxWidth: .infinity, alignment: .leading)
			
			TextField(hint, text: value)
				.padding(.horizontal, 15)
				.padding(.vertical, 12)
				.background(.background, in: .rect(cornerRadius: 10))
		}
	}
	
	@ViewBuilder
	func customCategoryCheckbox() -> some View {
		HStack(spacing: 10) {
			ForEach(Category.allCases, id: \.rawValue) { category in
				HStack(spacing: 5) {
					ZStack {
						Image(systemName: "circle")
							.font(.title3)
							.foregroundStyle(appTint)
						
						if self.category == category {
							Image(systemName: "circle.fill")
								.font(.caption)
								.foregroundStyle(appTint)
						}
					}
					
					Text(category.rawValue)
						.font(.caption)
				}
				.contentShape(.rect)
				.onTapGesture {
					self.category = category
				}
			}
		}
		.padding(.horizontal, 15)
		.padding(.vertical, 12)
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(.background, in: .rect(cornerRadius: 10))
	}
}

// MARK: - Preview
#Preview {
	NavigationStack {
		TransactionView()
	}
}
