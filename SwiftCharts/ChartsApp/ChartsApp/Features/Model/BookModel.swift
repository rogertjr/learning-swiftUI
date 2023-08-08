//
//  BookModel.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation

struct BookModel: Identifiable {
    let id = UUID()
    let title: String
    let author: AuthorModel
    let category: BookCategoryModel
    let price: Double
    let inventoryCount: Int
}

// MARK: - Equatable
extension BookModel: Equatable {
    static func == (lhs: BookModel, rhs: BookModel) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Dummies
extension BookModel {
    static var dummy = BookModel(title: "Harry Potter and the Sorcerer's Stone",
                                 author: AuthorModel.dummy,
                                 category: .fiction,
                                 price: 19.99,
                                 inventoryCount: 100)
       
   static var dummyList =  [
       BookModel(title: "Harry Potter and the Sorcerer's Stone",
                 author: AuthorModel.dummyList[0],
                 category: .fiction,
                 price: 19.99,
                 inventoryCount: 100),
       BookModel(title: "The Lord of the Rings", author: AuthorModel.dummyList[1], category: .fiction, price: 25.99, inventoryCount: 85),
       BookModel(title: "To Kill a Mockingbird", author: AuthorModel.dummyList[2], category: .fiction, price: 15.99, inventoryCount: 70),
       BookModel(title: "1984", author: AuthorModel.dummyList[3], category: .fiction, price: 14.99, inventoryCount: 80),
       BookModel(title: "The Catcher in the Rye", author: AuthorModel.dummyList[4], category: .fiction, price: 12.99, inventoryCount: 60),
       BookModel(title: "Charlotte's Web", author: AuthorModel.dummyList[5], category: .children, price: 15.99, inventoryCount: 85),
       BookModel(title: "The Very Hungry Caterpillar",
                 author: AuthorModel.dummyList[6],
                 category: .children,
                 price: 10.99,
                 inventoryCount: 90),
       BookModel(title: "Where the Wild Things Are",
                 author: AuthorModel.dummyList[7],
                 category: .children,
                 price: 13.99,
                 inventoryCount: 85),
       BookModel(title: "Green Eggs and Ham", author: AuthorModel.dummyList[8], category: .children, price: 9.99, inventoryCount: 80),
       BookModel(title: "The Cat in the Hat", author: AuthorModel.dummyList[9], category: .children, price: 9.99, inventoryCount: 80),
       BookModel(title: "The Steve Jobs Way", author: AuthorModel.dummyList[2], category: .business, price: 14.99, inventoryCount: 50),
       BookModel(title: "The Innovator's Dilemma", author: AuthorModel.dummyList[1], category: .business, price: 15.99, inventoryCount: 45),
       BookModel(title: "Lean In", author: AuthorModel.dummyList[3], category: .business, price: 14.99, inventoryCount: 55),
       BookModel(title: "Eloquent JavaScript",
                 author: AuthorModel.dummyList[0],
                 category: .computerScience,
                 price: 29.99,
                 inventoryCount: 40),
       BookModel(title: "Introduction to the Theory of Computation",
                 author: AuthorModel.dummyList[4],
                 category: .computerScience,
                 price: 49.99, inventoryCount: 35),
       BookModel(title: "The Great Gatsby", author: AuthorModel.dummyList[5], category: .fiction, price: 14.99, inventoryCount: 75),
       BookModel(title: "The Grapes of Wrath", author: AuthorModel.dummyList[6], category: .fiction, price: 14.99, inventoryCount: 65),
       BookModel(title: "Moby Dick", author: AuthorModel.dummyList[7], category: .fiction, price: 19.99, inventoryCount: 55),
       BookModel(title: "Pride and Prejudice", author: AuthorModel.dummyList[8], category: .fiction, price: 9.99, inventoryCount: 70),
       BookModel(title: "The Giving Tree", author: AuthorModel.dummyList[9], category: .children, price: 10.99, inventoryCount: 85)
   ]
}
