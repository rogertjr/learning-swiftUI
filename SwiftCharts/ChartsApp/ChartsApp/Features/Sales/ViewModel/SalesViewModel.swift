//
//  SalesViewModel.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation

final class SalesViewModel: ObservableObject {
    // MARK: - Properties
    @Published var salesData = [SaleModel]()
    @Published var lastTotalSales: Int = 0
    private let calendar = Calendar.current
    var totalSales: Int { salesData.reduce(0, { $0 + $1.quantity }) }
    
    // Weekday
    var salesByWeekday: [(number: Int, sales: [SaleModel])] {
        let salesByWeekday = salesGroupedByWeekday(salesData).map { (number: $0.key, sales: $0.value) }
        return salesByWeekday.sorted { $0.number < $1.number }
    }
    
    var averageSalesByWeekday: [(number: Int, sales: Double)] {
        let salesByWeekday = salesGroupedByWeekday(salesData)
        let averageSales = averageSalesPerNumber(salesByNumber: salesByWeekday)
        let sorted = averageSales.sorted { $0.number < $1.number }
        return sorted
    }
    
    var highestSellingWeekday: (number: Int, sales: Double)? {
        averageSalesByWeekday.max(by: { $0.sales < $1.sales })
    }
    
    var medianSales: Double {
        let salesData = self.averageSalesByWeekday
        return calculateMedian(salesData: salesData) ?? 0
    }
    
    // Week
    var salesByWeek: [(day: Date, sales: Int)] {
        let salesByWeek = salesGroupedByWeek(salesData)
        return totalSalesPerDate(salesByDate: salesByWeek)
    }
    
    // Category
    var totalSalesPerCategory: [(category: BookCategoryModel, sales: Int)] {
        let salesByCategory = salesGroupedByCategory(salesData)
        let totalSalesPerCategory = totalSalesPerCategory(salesByCategory)
        return totalSalesPerCategory.sorted { $0.sales > $1.sales  }
    }
    
    var bestSellingCategory: (category: BookCategoryModel, sales: Int)? {
        totalSalesPerCategory.max { $0.sales < $1.sales }
    }
    
    // MARK: - Preview
    static var previewData: SalesViewModel {
        let viewModel = SalesViewModel()
        viewModel.salesData = SaleModel.threeMonthsExamples()
        viewModel.lastTotalSales = 1200
        return viewModel
    }
}

// MARK: - Helpers
private extension SalesViewModel {
    // Weekday
    func calculateMedian(salesData: [(number: Int, sales: Double)]) -> Double? {
            let quantities = salesData.map { $0.sales }.sorted()
            let count = quantities.count

            if count % 2 == 0 {
                // Even count: the median is the average of the two middle numbers
                let middleIndex = count / 2
                let median = (quantities[middleIndex - 1] + quantities[middleIndex]) / 2
                return Double(median)
            } else {
                // Odd count: the median is the middle number
                let middleIndex = count / 2
                return Double(quantities[middleIndex])
            }
        }
    
    func salesGroupedByWeekday(_ sales: [SaleModel]) -> [Int: [SaleModel]] {
        var salesByWeekday: [Int: [SaleModel]] = [:]
        
        for sale in sales {
            let weekday = calendar.component(.weekday, from: sale.saleDate)
            if salesByWeekday[weekday] != nil {
                salesByWeekday[weekday]!.append(sale)
            } else {
                salesByWeekday[weekday] = [sale]
            }
        }
        
        return salesByWeekday
    }
    
    // Week
    func salesGroupedByWeek(_ sales: [SaleModel]) -> [Date: [SaleModel]] {
        var salesByWeek: [Date: [SaleModel]] = [:]
                
        for sale in sales {
            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: sale.saleDate))
                else { continue }
            if salesByWeek[startOfWeek] != nil {
                salesByWeek[startOfWeek]!.append(sale)
            } else {
                salesByWeek[startOfWeek] = [sale]
            }
        }
        
        return salesByWeek
    }
    
    // Category
    func salesGroupedByCategory(_ sales: [SaleModel]) -> [BookCategoryModel: [SaleModel]] {
        var salesByCategory: [BookCategoryModel: [SaleModel]] = [:]
        
        for sale in sales {
            let category = sale.book.category
            if salesByCategory[category] != nil {
                salesByCategory[category]!.append(sale)
            } else {
                salesByCategory[category] = [sale]
            }
        }
        
        return salesByCategory
    }
    
    func totalSalesPerCategory(_ salesByCategory: [BookCategoryModel: [SaleModel]]) -> [(category: BookCategoryModel, sales: Int)] {
        var totalSales: [(category: BookCategoryModel, sales: Int)] = []
        
        for (category, sales) in salesByCategory {
            let totalQuantityForCategory = sales.reduce(0) { $0 + $1.quantity }
            totalSales.append((category: category, sales: totalQuantityForCategory))
        }
        
        return totalSales
    }
    
    
    // Common
    func averageSalesPerNumber(salesByNumber: [Int: [SaleModel]]) -> [(number: Int, sales: Double)] {
        var averageSales: [(number: Int, sales: Double)] = []
        
        for (number, sales) in salesByNumber {
            let count = sales.count
            let totalQuantityForWeekday = sales.reduce(0) { $0 + $1.quantity }
            averageSales.append((number: number, sales: Double(totalQuantityForWeekday) / Double(count)))
        }
        
        return averageSales
    }
    
    func totalSalesPerDate(salesByDate: [Date: [SaleModel]]) -> [(day: Date, sales: Int)] {
        var totalSales: [(day: Date, sales: Int)] = []
        
        for (date, sales) in salesByDate {
            let totalQuantityForDate = sales.reduce(0) { $0 + $1.quantity }
            totalSales.append((day: date, sales: totalQuantityForDate))
        }
        
        return totalSales
    }
}
