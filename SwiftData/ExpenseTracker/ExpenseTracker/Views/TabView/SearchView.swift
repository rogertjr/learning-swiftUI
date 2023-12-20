//
//  SearchView.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 14/12/23.
//

import SwiftUI
import Combine

struct SearchView: View {
	// MARK: - Properties
	@State private var searchedText: String = ""
	@State private var filteredText: String = ""
	@State private var selectedCategory: Category? = nil
	let searchPublisher = PassthroughSubject<String, Never>()
	
	// MARK: - Layout
    var body: some View {
		NavigationStack {
			ScrollView(.vertical) {
				LazyVStack(spacing: 12) {
					FilterTransactionView(selectedCategory, searchedText: searchedText) { transactions in
						ForEach(transactions) { transaction in
							NavigationLink {
								TransactionView(editTransaction: transaction)
							} label: {
								TransactionCardView(transaction: transaction, showCategory: true)
							}
							.buttonStyle(.plain)
						}
					}
				}
				.padding(15)
			}
			.searchable(text: $searchedText)
			.overlay(content: {
				ContentUnavailableView("Search Transactions", systemImage: "magnifyingglass")
					.opacity(filteredText.isEmpty ? 1 : 0)
			})
			.onChange(of: searchedText, { oldValue, newValue in
				if newValue.isEmpty {
					filteredText = ""
				}
				searchPublisher.send(newValue)
			})
			.onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
				filteredText = text
			})
			.navigationTitle("Search")
			.background(.gray.opacity(0.15))
			.toolbar {
				ToolbarItem(placement: .topBarTrailing, content: toolBarContent)
			}
		}
    }
}

private extension SearchView {
	@ViewBuilder
	func toolBarContent() -> some View {
		Menu {
			Button {
				selectedCategory = nil
			} label: {
				HStack {
					Text("Both")
					if selectedCategory == nil {
						Image(systemName: "checkmark")
					}
				}
			}
			
			ForEach(Category.allCases, id: \.rawValue) { category in
				Button {
					selectedCategory = category
				} label: {
					HStack {
						Text(category.rawValue)
						if selectedCategory == category {
							Image(systemName: "checkmark")
						}
					}
				}
			}
		} label: {
			Image(systemName: "slider.vertical.3")
		}

	}
}

// MARK: - Preview
#Preview {
    SearchView()
}
