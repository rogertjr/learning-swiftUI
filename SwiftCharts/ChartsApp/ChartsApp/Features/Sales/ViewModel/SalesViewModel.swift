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
    var totalSales: Int {
        salesData.reduce(0, { $0 + $1.quantity })
    }
    
    var salesByWeek:[(day: Date, sales: Int)] {
        let salesByWeek = salesGroupedByWeek(salesData)
        return totalSalesPerDate(salesByDate: salesByWeek)
    }
        
    // MARK: - Init
    init() { }
    
    // MARK: - Preview
    static var previewData: SalesViewModel {
        let viewModel = SalesViewModel()
        viewModel.salesData = SaleModel.threeMonthsExamples()
        viewModel.lastTotalSales = 1200
        return viewModel
    }
    
    // MARK: - Helpers
    func salesGroupedByWeek(_ sales: [SaleModel]) -> [Date: [SaleModel]] {
        var salesByWeek: [Date: [SaleModel]] = [:]
                
        let calendar = Calendar.current
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
    
    func totalSalesPerDate(salesByDate: [Date: [SaleModel]]) -> [(day: Date, sales: Int)] {
        var totalSales: [(day: Date, sales: Int)] = []
        
        for (date, sales) in salesByDate {
            let totalQuantityForDate = sales.reduce(0) { $0 + $1.quantity }
            totalSales.append((day: date, sales: totalQuantityForDate))
        }
        
        return totalSales
    }
    
}
