//
//  Task.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation
import SwiftData

@Model
final class TaskModel {
    // MARK: - Properties
    @Attribute(.unique)
    var creationDate: Date
    var title: String
    var isDone: Bool
    var priority: Int
    
    @Attribute(.externalStorage)
    var image: Data?
    
    var tags: [TagModel]?
    
    // MARK: - Init
    init(_ title: String, isDone: Bool = false, priority: Int = 0) {
        self.creationDate = Date()
        self.title = title
        self.isDone = isDone
        self.priority = priority
    }
    
    // MARK: - Preview
    static func dummyTask() -> TaskModel {
        let task = TaskModel("Dummy Task")
        task.tags?.append(TagModel("dummyTag", color: .init(.blue)))
        return task
    }
    
    static func dummyDoneTask() -> TaskModel {
        let doneTask = TaskModel("Dummy Done Task", isDone: true)
        doneTask.tags?.append(TagModel("dummyTag", color: .init(.red)))
        
        return doneTask
    }
}
