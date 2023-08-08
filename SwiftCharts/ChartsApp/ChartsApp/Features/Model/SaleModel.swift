//
//  SaleModel.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation

struct SaleModel: Identifiable, Equatable {
    // MARK: - Properties
    let id = UUID()
    let book: BookModel
    let quantity: Int
    let saleDate: Date
}

// MARK: - Helpers
extension SaleModel {
    static func threeMonthsExamples() -> [SaleModel]  {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!

        let exampleSales: [SaleModel] = (1...300).map { _ in
            let randomBook = BookModel.dummyList.randomElement()!
            let randomQuantity = Int.random(in: 1...5)
            let randomDate = Date.random(in: threeMonthsAgo...Date())

            return SaleModel(book: randomBook, quantity: randomQuantity, saleDate: randomDate)
        }
        
        return exampleSales.sorted { $0.saleDate < $1.saleDate }
    }
    
    static var higherWeekendThreeMonthsExamples: [SaleModel] = {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!

        let exampleSales: [SaleModel] = (1...300).map { _ in
            let randomBook = BookModel.dummyList.randomElement()!
            let randomDate = Date.random(in: threeMonthsAgo...Date())
            
            let weekday = Calendar.current.component(.weekday, from: randomDate)
            var average: Int = 35
            
            switch weekday {
                case 1: average = 29
                case 2: average = 21
                case 3: average = 38
                case 4: average = 25
                case 5: average = 30
                case 6: average = 50
                case 7: average = 60
                default:
                    average = 10
            }
            
            let randomQuantity = (1...20).reduce(0) { acc, _ in acc + Int.random(in: 1...(average * 2)) } / 12

            return SaleModel(book: randomBook, quantity: randomQuantity, saleDate: randomDate)
        }

        return exampleSales.sorted { $0.saleDate < $1.saleDate }
    }()
}

// MARK: - Dummies
extension SaleModel {
    static var dummy = SaleModel(book: BookModel.dummy, quantity: 5, saleDate: Date(timeIntervalSinceNow: -7_200_000))
    
    static var dummyList = [SaleModel(book: BookModel.dummyList[0], quantity: 5, saleDate: Date(timeIntervalSinceNow: -7_200_000)),
                            SaleModel(book: BookModel.dummyList[1], quantity: 3, saleDate: Date(timeIntervalSinceNow: -14_400_000)),
                            SaleModel(book: BookModel.dummyList[2], quantity: 6, saleDate: Date(timeIntervalSinceNow: -21_600_000)),
                            SaleModel(book: BookModel.dummyList[3], quantity: 4, saleDate: Date(timeIntervalSinceNow: -28_800_000)),
                            SaleModel(book: BookModel.dummyList[4], quantity: 2, saleDate: Date(timeIntervalSinceNow: -36_000_000)),
                            SaleModel(book: BookModel.dummyList[5], quantity: 3, saleDate: Date(timeIntervalSinceNow: -43_200_000)),
                            SaleModel(book: BookModel.dummyList[6], quantity: 5, saleDate: Date(timeIntervalSinceNow: -50_400_000)),
                            SaleModel(book: BookModel.dummyList[7], quantity: 6, saleDate: Date(timeIntervalSinceNow: -57_600_000)),
                            SaleModel(book: BookModel.dummyList[8], quantity: 3, saleDate: Date(timeIntervalSinceNow: -64_800_000)),
                            SaleModel(book: BookModel.dummyList[9], quantity: 4, saleDate: Date(timeIntervalSinceNow: -72_000_000))
    ]
}
