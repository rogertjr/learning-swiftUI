//
//  WeeklySalesChartView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import Charts

struct WeeklySalesChartView: View {
    // MARK: - Properties
    @ObservedObject var salesViewModel: SalesViewModel
    
    // MARK: - User Interface
    var body: some View {
        Chart(salesViewModel.salesByWeek, id: \.day) { saleDate in
            BarMark(x: .value("Week", saleDate.day, unit: .weekOfYear),
                    y: .value("Sales", saleDate.sales))
        }
    }
}

// MARK: - Preview
#Preview {
    WeeklySalesChartView(salesViewModel: SalesViewModel.previewData)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
