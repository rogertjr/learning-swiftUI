//
//  NewsService.swift
//  NewsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import Foundation
import Combine

protocol NewsServiceProtocol {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, ApiError>
}

struct NewsService: NewsServiceProtocol {
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, ApiError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in ApiError.unknown }
            .flatMap { data, response -> AnyPublisher<NewsResponse, ApiError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: ApiError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: self.decoder)
                        .mapError { _ in ApiError.decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: ApiError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
