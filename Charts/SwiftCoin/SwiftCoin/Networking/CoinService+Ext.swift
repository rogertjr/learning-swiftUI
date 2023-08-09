//
//  CoinService+Ext.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation

extension CoinService {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(_ error: Error)
        case invalidStatusCode(_ statusCode: Int)
        case invalidData
        case failedToDecode(_ error: Error)
    }
}

extension CoinService.NetworkingError: Equatable {
    static func == (lhs: CoinService.NetworkingError,
                    rhs: CoinService.NetworkingError) -> Bool {
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

extension CoinService.NetworkingError {
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
