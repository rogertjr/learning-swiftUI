//
//  CoinDetailsViewModel.swift
//  	
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation
import SwiftUI

final class CoinDetailsViewModel: ObservableObject {
    // MARK: - Properties
    private let coin: Coin
    
    var chartData: [ChartData] = []
    var startDate = Date()
    var endDate = Date()
    var minPrice = 0.0
    var maxPrice = 0.0
    var xAxisValues: [Date] = []
    var yAxisValues: [Double] = []
    
    var coinName: String {
        return coin.name
    }
    
    var chartLineColor: Color {
        guard let percentage = coin.marketCapChangePercentage24H else { return .clear }
        return percentage > 0 ? .green : .pink
    }
    
    var overviewSectionModel: CoinDetailsSectionModel {
        let price = coin.currentPrice.toCurrencyString()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStats = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = String(format:"$%@", coin.marketCap?.formattedWithAbbreviations() ?? "N/a")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStats = StatisticModel(title: "Market Captalization",
                                            value: marketCap,
                                            percentageChange: marketCapPercentChange)
        
        let rank = coin.marketCapRank
        let rankStats = StatisticModel(title: "Rank", value: rank.toRankString(), percentageChange: nil)
        
        let volume = String(format:"$%@", coin.totalVolume?.formattedWithAbbreviations() ?? "N/a")
        let volumeStats = StatisticModel(title: "Volume", value: volume, percentageChange: nil)
        
        return CoinDetailsSectionModel(title: "Overview", stats: [priceStats, marketCapStats, rankStats, volumeStats])
    }
    
    var additionalDetailsSectionModel : CoinDetailsSectionModel{
            let high = coin.high24H?.toCurrencyString() ?? "N/a"
            let highStat = StatisticModel(title: "24H High", value: high, percentageChange: nil)
            
            let low = coin.low24H?.toCurrencyString() ?? "N/a"
            let lowStat = StatisticModel(title: "Low", value: low, percentageChange: nil)
            
            let priceChange24H = coin.priceChange24H.toCurrencyString()
            let percentageChange24H = coin.priceChangePercentage24H
            let priceChangeStats = StatisticModel(title: "24H Price Change",
                                                  value: priceChange24H,
                                                  percentageChange: percentageChange24H)
            
            let marketCapChange = String(format:"$%@", coin.marketCapChange24H?.formattedWithAbbreviations() ?? "N/a")
            let marketCapChangePercentage = coin.marketCapChangePercentage24H
            let marketCapStats = StatisticModel(title: "24H Market CapChange",
                                                value: marketCapChange,
                                                percentageChange: marketCapChangePercentage)
            
            return CoinDetailsSectionModel(title: "Additional details", stats: [highStat, lowStat, priceChangeStats, marketCapStats])
        }
    
    // MARK: - Init
    init(_ coin: Coin) {
        self.coin = coin
        setupChartData()
    }
    
    // MARK: - Helpers
    private func setupChartData() {
        guard let priceData = coin.sparklineIn7D?.price else { return }
        var index = 0
        minPrice = priceData.min() ?? 0.0
        maxPrice = priceData.max() ?? 0.0
        endDate = Date(coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7 * 60 * 60 * 24)
        yAxisValues = [minPrice, (minPrice + maxPrice) / 2, maxPrice]
        
        for price in priceData.reversed() {
            let date = endDate.addingTimeInterval(-1 * 60 * 60 * Double(index))
            let chartDataItem = ChartData(date: date, value: price)
            self.chartData.append(chartDataItem)
            index += 1
        }
    }
}
