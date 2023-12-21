//
//  FilterTransactionView.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 20/12/23.
//

import SwiftUI
import SwiftData

struct FilterTransactionView<Content: View>: View {
	// MARK: - Properties
	@Query(animation: .snappy) private var transactions: [Transaction]
	var content: ([Transaction]) -> Content
	
	// MARK: - Init
	init(_ category: Category?, searchedText: String, @ViewBuilder content: @escaping ([Transaction]) -> Content) {
		let rawValue = category?.rawValue ?? ""
		
		let predicate = #Predicate<Transaction> { transaction in
			return (transaction.title.localizedStandardContains(searchedText)
				 	|| transaction.remarks.localizedStandardContains(searchedText))
			&& (rawValue.isEmpty ? true : transaction.category == rawValue)
		}
		
		_transactions = Query(filter: predicate, sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy)
		
		self.content = content
	}
	
	init(statDate: Date, endDate: Date, @ViewBuilder content: @escaping ([Transaction]) -> Content) {
		let predicate = #Predicate<Transaction> { transaction in
			return transaction.dateAdded >= statDate && transaction.dateAdded <= endDate
		}
		
		_transactions = Query(filter: predicate, sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy)
		
		self.content = content
	}
	
	init(statDate: Date, endDate: Date, category: Category?, @ViewBuilder content: @escaping ([Transaction]) -> Content) {
		let rawValue = category?.rawValue ?? ""
		
		let predicate = #Predicate<Transaction> { transaction in
			return transaction.dateAdded >= statDate && transaction.dateAdded <= endDate
				&& (rawValue.isEmpty ? true : transaction.category == rawValue)
		}
		
		_transactions = Query(filter: predicate, sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy)
		
		self.content = content
	}
	
	// MARK: - Layout
    var body: some View {
		content(transactions)
		 
    }
}
