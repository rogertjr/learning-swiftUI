//
//  DailySalesChartView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import Charts

struct DailySalesChartView: View {
    // MARK: - Properties
    let salesData: [SaleModel]
    @State private var scrollPosition: TimeInterval = TimeInterval()
    let numberOfDisplayedDays = 30
    var scrollPositionStart: Date { Date(timeIntervalSinceReferenceDate: scrollPosition) }
    var scrollPositionEnd: Date { scrollPositionStart.addingTimeInterval(3600 * 24 * 30) }
    var scrollPositionString: String { scrollPositionStart.formatted(.dateTime.month().day()) }
    var scrollPositionEndString: String { scrollPositionEnd.formatted(.dateTime.month().day().year()) }
    
    // MARK: - Init
    init(salesData: [SaleModel]) {
        self.salesData = salesData
        guard let lastDate = salesData.last?.saleDate else { return }
        let beginingOfInterval = lastDate.addingTimeInterval(-1 * 3600 * 24 * 30)
        self._scrollPosition = State(initialValue: beginingOfInterval.timeIntervalSinceReferenceDate)
    }
    
    // MARK: - User Interface
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(scrollPositionString) – \(scrollPositionEndString)")
                .font(.callout)
                .foregroundStyle(.secondary)

            Chart(salesData) { sale in
                BarMark(x: .value("Day", sale.saleDate, unit: .day),
                        y: .value("Sales", sale.quantity))
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 3600 * 24 * numberOfDisplayedDays) // shows 30 days
            // snap to begining of month when release scrolling
            .chartScrollTargetBehavior(.valueAligned( matching: .init(hour: 0), majorAlignment: .matching(.init(day: 1))))
            .chartScrollPosition(x: $scrollPosition)
        }
    }
}

// MARK: - Preview
@available(macOS 14.0, *)
#Preview {
    DailySalesChartView(salesData: SaleModel.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
