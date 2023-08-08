//
//  SalesPerBookCategoryPieChartView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import Charts

@available(macOS 14.0, *)
struct SalesPerBookCategoryPieChartView: View {
    // MARK: - Properties
    @ObservedObject var salesViewModel: SalesViewModel
    
    // MARK: - User Interface
    var body: some View {
        Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
            SectorMark(angle: .value("Sales", data.sales),
                       innerRadius: .ratio(0.618),
                       angularInset: 1.5)
                .cornerRadius(5.0)
                .opacity(data.category == salesViewModel.bestSellingCategory?.category ? 1 : 0.3)
                .foregroundStyle(by: .value("Category", data.category.displayName))
        }
        .aspectRatio(1, contentMode: .fit)
        .chartLegend(position: .bottom, spacing: 20)
        .chartBackground { chartProxy in
            GeometryReader(content: { geometry in
                if let bestSellingCategory = salesViewModel.bestSellingCategory, let plotFrame = chartProxy.plotFrame {
                    let frame = geometry[plotFrame]
                    VStack {
                        Text("Most Sold Category")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(bestSellingCategory.category.displayName)
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        Text(bestSellingCategory.sales.formatted() + " sold")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
            })
        }
    }
}

// MARK: - Preview
@available(macOS 14.0, *)
#Preview {
    SalesPerBookCategoryPieChartView(salesViewModel: .previewData)
        .padding()
}
