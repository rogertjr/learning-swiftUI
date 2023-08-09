//
//  Date.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation

extension Date {
    
    /// "2022-12-15T00:08:59.307Z"
    init(_ coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortDateFormatter.string(from: self)
    }
}
