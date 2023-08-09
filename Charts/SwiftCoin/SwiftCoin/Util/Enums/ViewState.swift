//
//  ViewState.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation

enum ViewState: Comparable {
    case idle
    case isLoading
    case finishedLoading
    case noResults
    case error(String)
}
