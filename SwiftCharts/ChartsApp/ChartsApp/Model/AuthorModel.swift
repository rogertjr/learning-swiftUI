//
//  Author.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation

struct AuthorModel: Identifiable {
    let id = UUID()
    let name: String
}

// MARK: - Dummies
extension AuthorModel {
    static var dummy = AuthorModel(name: "George R. R. Martin")
    static var dummyList = [AuthorModel(name: "J.K. Rowling"),
                            AuthorModel(name: "George R. R. Martin"),
                            AuthorModel(name: "J.R.R. Tolkien"),
                            AuthorModel(name: "Agatha Christie"),
                            AuthorModel(name: "Stephen King"),
                            AuthorModel(name: "Dan Brown"),
                            AuthorModel(name: "Harper Lee"),
                            AuthorModel(name: "Jane Austen"),
                            AuthorModel(name: "F. Scott Fitzgerald"),
                            AuthorModel(name: "Ernest Hemingway")]
}
