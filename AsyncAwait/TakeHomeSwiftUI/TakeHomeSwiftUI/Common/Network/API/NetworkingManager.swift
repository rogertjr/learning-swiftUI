//
//  NetworkingManager.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 21/08/22.
//

import Foundation

protocol NetworkingManagerProtocol {
    func request<T: Codable>(_ session: URLSession,
                             endpoint: Endpoint,
                             type: T.Type) async throws -> T
    
    func request(_ session: URLSession,
                 endpoint: Endpoint) async throws
}

final class NetworkingManager: NetworkingManagerProtocol {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(_ session: URLSession = .shared,
                             endpoint: Endpoint,
                             type: T.Type) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.method)
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    func request(_ session: URLSession = .shared,
                 endpoint: Endpoint) async throws {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.method)
        let (_, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode)
        }
        
    }
}

// MARK: - Helpers
private extension NetworkingManager {
    func buildRequest(from url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        
        return request
    }
}

// MARK: - Errors
extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(_ error: Error)
        case invalidStatusCode(_ statusCode: Int)
        case invalidData
        case failedToDecode(_ error: Error)
    }
}

extension NetworkingManager.NetworkingError: Equatable {
    static func == (lhs: NetworkingManager.NetworkingError,
                    rhs: NetworkingManager.NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL isn't valid"
        case .custom(let error):
            return "Something went wrong \(error.localizedDescription.lowercased())"
        case .invalidStatusCode:
            return "Status code falls into the worng range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode data"
        }
    }
}
