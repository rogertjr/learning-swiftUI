//
//  ChartData.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation

struct ChartData: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let value: Double
}
