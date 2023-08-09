//
//  WeeklySalesChartView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import Charts

struct WeeklySalesChartView: View {
    // MARK: - Properties
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var rawSelectedDate: Date? = nil
    @Environment(\.calendar) var calendar
    
    var selectedDateValue: (day: Date, sales: Int)? {
        guard let rawSelectedDate else { return nil }
        return salesViewModel.salesByWeek.first {
            let startOfWeek = $0.day
            let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek) ?? Date()
            return (startOfWeek...endOfWeek).contains(rawSelectedDate)
        }
    }
    
    // MARK: - User Interface
    var body: some View {
        Chart {
            ForEach(salesViewModel.salesByWeek, id: \.day) { saleDate in
                BarMark(x: .value("Week", saleDate.day, unit: .weekOfYear),
                        y: .value("Sales", saleDate.sales))
                .foregroundStyle(Color.blue.gradient)
                .opacity(selectedDateValue?.day == nil || selectedDateValue?.day == saleDate.day ? 1 : 0.5)
            }
            if let rawSelectedDate {
                RuleMark(x: .value("Selected Date", rawSelectedDate, unit: .day))
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .zIndex(-1)
                    .annotation(position: .top, spacing: 0, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        selectionPopOver
                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
    }
}

// MARK: - ViewBuilder
private extension WeeklySalesChartView {
    @ViewBuilder
    var selectionPopOver: some View {
        if let selectedDateValue {
            VStack {
                Text(selectedDateValue.day.formatted(.dateTime.month().day()))
                Text("\(selectedDateValue.sales) sales")
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
}


// MARK: - Preview
#Preview {
    WeeklySalesChartView(salesViewModel: SalesViewModel.previewData)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
