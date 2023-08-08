//
//  DateFormatter+Ext.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation

extension DateFormatter {
    
    func weekday(for number: Int) -> String {
        self.shortWeekdaySymbols[number - 1]
    }
    
    func longWeekday(for number: Int) -> String {
        self.weekdaySymbols[number - 1]
    }
}
