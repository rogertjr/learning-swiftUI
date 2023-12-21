//
//  Chart.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 21/12/23.
//

import SwiftUI

struct ChartGroup: Identifiable {
	let id: UUID = .init()
	var date: Date
	var categories: [ChartCategory]
	var totalIncome: Double
	var totalExpense: Double
}

struct ChartCategory: Identifiable {
	let id: UUID = .init()
	var totalValue: Double
	var category: Category
}
