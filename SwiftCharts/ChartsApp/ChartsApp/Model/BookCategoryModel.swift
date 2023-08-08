//
//  BookCategoryModel.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation

enum BookCategoryModel: Identifiable, CaseIterable {
    var id: Self { return self }
    
    case fiction
    case biography
    case children
    case computerScience
    case fantasy
    case business
    
    var displayName: String {
        switch self {
        case .fiction: "Fiction"
        case .biography: "Biography"
        case .children: "Children"
        case .computerScience: "Computer Science"
        case .fantasy: "Fantasy"
        case .business: "Business"
        }
    }
}
