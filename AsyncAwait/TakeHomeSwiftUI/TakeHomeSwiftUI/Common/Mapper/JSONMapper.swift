//
//  JSONMapper.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 21/08/22.
//

import Foundation

struct JSONMapper {
    static func decode<T: Decodable>(_ file: String, type: T.Type) throws -> T {
        guard !file.isEmpty,
            let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

// MARK: - Extension
extension JSONMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}
