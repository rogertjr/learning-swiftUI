//
//  DetailedBookSalesView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI

struct DetailedBookSalesView: View {
    // MARK: - Properties
    enum TimeInterval: String, CaseIterable, Identifiable {
        var id: Self { return self}
        case day = "Day"
        case week = "Week"
        case month = "Month"
    }
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var selectedTimeInterval = TimeInterval.day
    
    // MARK: - User Interface
    var body: some View {
        VStack {
            Picker(selection: $selectedTimeInterval.animation()) {
                ForEach(TimeInterval.allCases) { interval in
                    Text(interval.rawValue)
                }
            } label: {
                Text("Time interval for chart")
            }
            .pickerStyle(.segmented)
            
            Group {
               Text("You sold ") +
               Text("\(salesViewModel.totalSales) books").bold().foregroundColor(Color.accentColor) +
               Text(" in the last 90 days.")
           }
            .padding(.vertical)
            
            Group {
                switch selectedTimeInterval {
                case .day:
                    DailySalesChartView(salesData: salesViewModel.salesData)
                case .week:
                    WeeklySalesChartView(salesViewModel: salesViewModel)
                case .month:
                    MonthlySalesChartView(salesData: salesViewModel.salesData)
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            Spacer()
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    DetailedBookSalesView(salesViewModel: .previewData)
}
