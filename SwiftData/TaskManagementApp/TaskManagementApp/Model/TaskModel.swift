//
//  TaskModel.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import SwiftData

@Model
final class TaskModel {
    // MARK: - Properties
    @Attribute(.unique)
    var title: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: RGBColorModel
    
    // MARK: - Init
    init(title: String, creationDate: Date, isCompleted: Bool = false, tint: RGBColorModel) {
        self.title = title
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
}

// MARK: - Dummy
extension TaskModel {
    static func dummy() -> TaskModel {
        return .init(title: "Study about SwiftUI", creationDate: .updateHour(-1), isCompleted: true, tint: RGBColorModel(.taskColor1))
    }

    static func dummyList() -> [TaskModel] {
        return [.init(title: "Study about SwiftUI", creationDate: .updateHour(-1), isCompleted: true, tint: RGBColorModel(.taskColor1)),
                .init(title: "Redesign App", creationDate: .updateHour(9), tint: RGBColorModel(.taskColor2)),
                .init(title: "Go for a Walk", creationDate: .updateHour(10), tint: RGBColorModel(.taskColor3)),
                .init(title: "Edit Video", creationDate: .updateHour(0), tint: RGBColorModel(.taskColor4)),
                .init(title: "Publish Video", creationDate: .updateHour(2), tint: RGBColorModel(.taskColor1)),
                .init(title: "Tweet about new Video!", creationDate: .updateHour(12), tint: RGBColorModel(.taskColor5))]
    }

}

