//
//  Int+Ext.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation

extension Int {
    func toRankString() -> String {
        return String(format: "#%@", self.description)
    }
}
