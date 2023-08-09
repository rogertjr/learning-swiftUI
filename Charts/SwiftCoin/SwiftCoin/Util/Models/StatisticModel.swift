//
//  StatisticModel.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
}
