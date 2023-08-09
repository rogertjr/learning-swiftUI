//
//  SimpleSalesByWeekdayView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import Charts

struct SimpleSalesByWeekdayView: View {
    // MARK: - Properties
    @ObservedObject var salesViewModel: SalesViewModel
    private let dateFormatter = DateFormatter()
    
    // MARK: - User Interface
    var body: some View {
        VStack(alignment: .leading) {
            if let highestSellingWeekday = salesViewModel.highestSellingWeekday {
                Text("Your highest selling day of the week is ") +
                Text("\(dateFormatter.longWeekday(for: highestSellingWeekday.number))").bold().foregroundColor(.blue) +
                Text(" with an average of ") +
                Text("\(Int(highestSellingWeekday.sales)) sales per day.").bold()
            }
            
            Chart(salesViewModel.averageSalesByWeekday, id: \.number) {
                BarMark(x: .value("Day", dateFormatter.weekday(for: $0.number)),
                        y: .value("Sales", $0.sales))
                
                .opacity($0.number == salesViewModel.highestSellingWeekday?.number ? 1 : 0.3)
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: 50)
        }
    }
}

// MARK: - Preview
#Preview {
    SimpleSalesByWeekdayView(salesViewModel: .previewData)
        .padding()
}
