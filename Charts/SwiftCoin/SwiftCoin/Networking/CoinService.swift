//
//  CoinService.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation

protocol CoinServiceProtocol {
    func fetchAllCoins() async throws -> [Coin]
}

struct CoinService: CoinServiceProtocol {
    func fetchAllCoins() async throws -> [Coin] {
        let urlSession = URLSession.shared
        let endpoint = CoinApi.fetchCoins
        let (data, response) = try await urlSession.data(for: endpoint.request)
                
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode)
        }
        
        let pokemonData = try JSONDecoder().decode([Coin].self, from: data)
        return pokemonData
    }
}
