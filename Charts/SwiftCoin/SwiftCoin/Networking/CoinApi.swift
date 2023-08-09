//
//  CoinApi.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation

enum CoinApi {
    case fetchCoins
}

extension CoinApi {
    static let baseUrl = "https://api.coingecko.com"
    static let apiVersion = "/api/v3"
    
    var path: String {
        switch self {
        case .fetchCoins:
            return String(format: "%@/coins/markets", CoinApi.apiVersion)
        }
    }
    
    var method: String {
        switch self {
        case .fetchCoins:
            return "GET"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchCoins:
            return [
                URLQueryItem(name: "vs_currency", value: "usd"),
                URLQueryItem(name: "order", value: "market_cap_desc"),
                URLQueryItem(name: "per_page", value: "50"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "sparkline", value: "true"),
                URLQueryItem(name: "price_change_percentage", value: "24h"),
            ]
        }
    }
    
    var request: URLRequest {
        var urlComponents = URLComponents(string: CoinApi.baseUrl)!
        urlComponents.scheme = "https"
        urlComponents.path = path
        
        if case .fetchCoins = self {
            urlComponents.queryItems = queryItems
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
