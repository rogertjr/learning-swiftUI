//
//  CustomerModel.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation

struct CustomerModel: Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let favoriteGenre: String
}

extension CustomerModel {
    static var dummy = CustomerModel(id: UUID(), name: "Customer 1", age: 30, favoriteGenre: "Fiction")
    static var dummyList = [CustomerModel(id: UUID(), name: "Customer 1", age: 30, favoriteGenre: "Fiction"),
                            CustomerModel(id: UUID(), name: "Customer 2", age: 25, favoriteGenre: "Non-fiction"),
                            CustomerModel(id: UUID(), name: "Customer 3", age: 35, favoriteGenre: "Fiction"),
                            CustomerModel(id: UUID(), name: "Customer 4", age: 28, favoriteGenre: "Fiction"),
                            CustomerModel(id: UUID(), name: "Customer 5", age: 32, favoriteGenre: "Non-fiction"),
                            CustomerModel(id: UUID(), name: "Customer 6", age: 29, favoriteGenre: "Fiction"),
                            CustomerModel(id: UUID(), name: "Customer 7", age: 31, favoriteGenre: "Non-fiction"),
                            CustomerModel(id: UUID(), name: "Customer 8", age: 33, favoriteGenre: "Fiction"),
                            CustomerModel(id: UUID(), name: "Customer 9", age: 27, favoriteGenre: "Non-fiction"),
                            CustomerModel(id: UUID(), name: "Customer 10", age: 36, favoriteGenre: "Fiction")]
}
