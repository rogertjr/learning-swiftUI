//
//  SalesPerBookCategoryView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI

struct SalesPerBookCategoryView: View {
    // MARK: - Properties
    enum ChartStyle: String, CaseIterable, Identifiable {
        case pie = "Pie Chart"
        case bar = "Bar Chart"
        case singleBar = "Single Bar"
        
        var id: Self { self }
    }
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var selectedChartStyle: ChartStyle = .pie
    
    // MARK: - User Interface
    var body: some View {
        VStack {
            Picker("Chart Type", selection: $selectedChartStyle) {
                ForEach(ChartStyle.allCases) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            SalesPerBookCategoryHeaderView(selectedChartStyle: selectedChartStyle, salesViewModel: salesViewModel)
                .font(.title3).padding(.vertical)
            
            switch selectedChartStyle {
            case .bar:
                SalesPerBookCategoryBarChartView(salesViewModel: salesViewModel)
            case .pie:
                if #available(macOS 14.0, *) {
                    SalesPerBookCategoryPieChartView(salesViewModel: salesViewModel)
                } else {
                    Text("Pie charts only available for macOS 14 and iOS 17")
                }
            case .singleBar:
                Text("TODO")
//                SalesPerBookCategoryStackedBarChartView(salesViewModel: salesViewModel)
            }
            
            Button(action: {
                withAnimation {
                    salesViewModel.salesData = SaleModel.threeMonthsExamples()
                }
            }, label: {
                Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
            })
            .padding(.top, 50)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    SalesPerBookCategoryView(salesViewModel: .previewData)
}
