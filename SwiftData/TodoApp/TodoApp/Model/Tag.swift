//
//  Tag.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation
import SwiftData

@Model
final class Tag {
    var name: String
    var tasks: [Task]?
    var color: RGBColor
    
    init(_ name: String, color: RGBColor) {
        self.name = name
        self.color = color
    }
}
