//
//  ResultState.swift
//  NewsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
