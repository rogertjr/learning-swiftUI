//
//  SimpleSalesPerBookCategoryView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import Charts

struct SimpleSalesPerBookCategoryView: View {
    // MARK: - Properties
    @ObservedObject var salesViewModel: SalesViewModel
    
    // MARK: - User Interface
    var body: some View {
        HStack(spacing: 30) {
            SalesPerBookCategoryHeaderView(selectedChartStyle: .pie,
                                           salesViewModel: salesViewModel)
            
            if #available(macOS 14.0, *) {
                Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
                    SectorMark(angle: .value("Sales", data.sales),
                               innerRadius: .ratio(0.618),
                               angularInset: 1.5)
                        .cornerRadius(5.0)
                        .opacity(data.category == salesViewModel.bestSellingCategory?.category ? 1 : 0.3)
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 75)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SimpleSalesPerBookCategoryView(salesViewModel: .previewData)
        .padding()
}
