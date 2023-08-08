//
//  MonthlySalesChartView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import Charts

struct MonthlySalesChartView: View {
    // MARK: - Properties
    let salesData: [SaleModel]
    
    // MARK: - User Interface
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Month", sale.saleDate, unit: .month),
                    y: .value("Sales", sale.quantity))
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
            }
        }
        .chartYAxis {
            AxisMarks { _ in
                AxisGridLine()
                AxisValueLabel()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MonthlySalesChartView(salesData: SaleModel.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
