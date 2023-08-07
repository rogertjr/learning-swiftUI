//
//  Tag.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation
import SwiftData

@Model
final class TagModel {
    // MARK: - Properteis
    var name: String
    var tasks: [TaskModel]?
    var color: RGBColorModel
    
    // MARK: - Init
    init(_ name: String, color: RGBColorModel) {
        self.name = name
        self.color = color
    }
}
