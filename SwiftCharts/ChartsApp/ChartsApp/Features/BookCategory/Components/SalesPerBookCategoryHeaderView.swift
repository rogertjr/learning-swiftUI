//
//  SalesPerBookCategoryHeaderView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI

struct SalesPerBookCategoryHeaderView: View {
    // MARK: - Properties
    let selectedChartStyle: SalesPerBookCategoryView.ChartStyle
    @ObservedObject var salesViewModel: SalesViewModel
    
    // MARK: - User Interface
    var body: some View {
        switch selectedChartStyle {
        case .pie, .singleBar:
            if let bestSellingCategory = salesViewModel.bestSellingCategory,
               let bestsellingCategoryPercentage  {
                Text("Your best selling category is ") + Text("\(bestSellingCategory.category.displayName)")
                    .bold()
                    .foregroundColor(.blue) +
                Text(" with ") +
                Text("\(bestsellingCategoryPercentage)")
                    .bold() +
                Text(" of all sales.")
                
            }
            
        case .bar:
            if let bestSellingCategory = salesViewModel.bestSellingCategory {
                Text("Your best selling category is ") + Text("\(bestSellingCategory.category.displayName)")
                    .bold()
                    .foregroundColor(.blue) +
                Text(" with ") +
                Text("\(bestSellingCategory.sales) sales ")
                    .bold() +
                Text("in the last 90 days.")
            }
        }
    }
}

// MARK: - Helpers
private extension SalesPerBookCategoryHeaderView {
    var bestsellingCategoryPercentage: String? {
        guard let bestSellingCategory = salesViewModel.bestSellingCategory else { return nil }
        
        let percentage = Double(bestSellingCategory.sales) / Double(salesViewModel.totalSales)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        return formattedPercentage
    }
}

// MARK: - Preview
#Preview {
    return VStack {
        SalesPerBookCategoryHeaderView(selectedChartStyle: .bar,
                                       salesViewModel: .previewData)
        SalesPerBookCategoryHeaderView(selectedChartStyle: .singleBar,
                                       salesViewModel: .previewData)
    }
}
