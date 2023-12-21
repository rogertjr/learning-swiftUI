//
//  View+Ext.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 14/12/23.
//

import SwiftUI

extension View {
	@available(iOSApplicationExtension, unavailable)
	var safeArea: UIEdgeInsets {
		if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
			return windowScene.keyWindow?.safeAreaInsets ?? .zero
		}
		return .zero
	}
	
	func format(_ date: Date, format: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.string(from: date)
	}
	
	func currencyString(_ value: Double, maxDigits: Int = 2) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.maximumFractionDigits = maxDigits
		return formatter.string(from: .init(value: value)) ?? ""
	}
	
	var currencySymbol: String {
		let locale = Locale.current
		return locale.currencySymbol ?? ""
	}
	
	func total(_ transactions: [Transaction], category: Category) -> Double {
		return transactions.filter({ $0.category == category.rawValue }).reduce(Double.zero) { partialResult, transaction in
			return partialResult + transaction.amount
		}
	}
}
