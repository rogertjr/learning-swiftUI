//
//  Task.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation
import SwiftData

@Model
final class Task {
    @Attribute(.unique)
    var creationDate: Date
    var title: String
    var isDone: Bool
    var priority: Int
    
    @Attribute(.externalStorage)
    var image: Data?
    
    var tags: [Tag]?
    
    init(_ title: String, isDone: Bool = false, priority: Int = 0) {
        self.creationDate = Date()
        self.title = title
        self.isDone = isDone
        self.priority = priority
    }
}
