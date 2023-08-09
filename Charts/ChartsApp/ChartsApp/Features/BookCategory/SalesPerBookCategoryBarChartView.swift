//
//  SalesPerBookCategoryBarChartView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import Charts

struct SalesPerBookCategoryBarChartView: View {
    // MARK: - Properties
    @ObservedObject var salesViewModel: SalesViewModel
    
    // MARK: - User Interface
    var body: some View {
        Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
            BarMark(x: .value("sales", data.sales),
                    y: .value("Category", data.category.displayName))
            
            .annotation(position: .trailing, alignment: .leading, content: {
                Text(String(data.sales))
                    .opacity(data.category == salesViewModel.bestSellingCategory?.category ? 1 : 0.3)
            })
            
            .foregroundStyle(by: .value("Name", data.category.displayName))
            .opacity(data.category == salesViewModel.bestSellingCategory?.category ? 1 : 0.3)
        }
        .chartLegend(.hidden)
        .frame(maxHeight: 400)
    }
}

// MARK: - Preview
#Preview {
    SalesPerBookCategoryBarChartView(salesViewModel: .previewData)
        .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
}
