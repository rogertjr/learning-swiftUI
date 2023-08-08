//
//  SimpleBookSalesView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import Charts

struct SimpleBookSalesView: View {
    // MARK: - Properties
    @ObservedObject var salesViewModel: SalesViewModel
    
    // MARK: - User Interface
    var body: some View {
        VStack(alignment: .leading) {
            if let changedBookSales = changedBookSales() {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right").bold()
                        .foregroundColor( isPositiveChange ? .green : .red)
                    
                    Text("You book sales ") +
                    Text(changedBookSales)
                        .bold() +
                    Text(" in the last 90 days.")
                }
            }
            
            
            Chart(salesViewModel.salesByWeek, id: \.day) {
                BarMark(x: .value("Week", $0.day, unit: .weekOfYear),
                        y: .value("Sales", $0.sales))
            }
            .frame(height: 70)
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
        }
    }
}

// MARK: - Helpers
private extension SimpleBookSalesView {
    var percentage: Double {
        Double(salesViewModel.totalSales) / Double(salesViewModel.lastTotalSales) - 1
    }
    
    var isPositiveChange: Bool {
        percentage > 0
    }
    
    func changedBookSales() -> String? {
        let percentage = percentage
       let numberFormatter = NumberFormatter()
       numberFormatter.numberStyle = .percent
       
       guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
           return nil
       }
       
       let changedDescription = percentage < 0 ? "decreased by " : "increased by "
       return changedDescription + formattedPercentage
    }
}

// MARK: - Preview
#Preview {
    SimpleBookSalesView(salesViewModel: .previewData)
        .padding()
}
