//
//  ChartView.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    // MARK: - Properties
    let viewModel: CoinDetailsViewModel
    
    // MARK: - Layout
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart {
                ForEach(viewModel.chartData) { item in
                    LineMark(x: .value("Date", item.date), y: .value("Price", item.value))
                        .interpolationMethod(.cardinal)
                        .foregroundStyle(viewModel.chartLineColor)
                }
            }
            .chartXScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.startDate, upper: viewModel.endDate)))
            .chartXAxis {
                AxisMarks(position: .bottom, values: viewModel.xAxisValues) { value in
                    AxisGridLine()
                    AxisValueLabel() {
                        if let dateValue = value.as(Date.self) {
                            Text(dateValue.asShortDateString())
                        }
                    }
                }
            }
            .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.minPrice, upper: viewModel.maxPrice)))
            .chartYAxis {
                AxisMarks(position: .leading, values: viewModel.yAxisValues) { value in
                    AxisGridLine()
                    AxisValueLabel() {
                        if let doubleValue = value.as(Double.self) {
                            Text(doubleValue.formattedWithAbbreviations())
                        }
                    }
                }
            }
        }
    }
}

// MARK: - PreviewProvider
struct ChartView_Previews: PreviewProvider {
    static var coins: [Coin] {
        let coinsResult = try! JSONMapper.decode(MockResultFiles.coinList.rawValue, type: [Coin].self)
        return coinsResult
    }
    
    static var previews: some View {
        ChartView(viewModel: CoinDetailsViewModel(coins.first!))
    }
}
