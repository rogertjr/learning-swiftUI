//
//  ApiError.swift
//  NewsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import Foundation

enum ApiError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "Unknown error :/"
        
        }
    }
}
