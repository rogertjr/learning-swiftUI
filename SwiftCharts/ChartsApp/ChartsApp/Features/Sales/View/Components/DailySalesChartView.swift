//
//  DailySalesChartView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import Charts

struct DailySalesChartView: View {
    // MARK: - Properties
    let salesData: [SaleModel]
    
    // MARK: - User Interface
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Day", sale.saleDate, unit: .day),
                    y: .value("Sales", sale.quantity))
        }
    }
}

// MARK: - Preview
#Preview {
    DailySalesChartView(salesData: SaleModel.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
