//
//  PreviewSampleData.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import Foundation
import SwiftData

let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: TaskModel.self, ModelConfiguration(inMemory: true))
        
        Task { @MainActor in
            let context = container.mainContext
            
            context.insert(TaskModel.dummyTask())
            context.insert(TaskModel.dummyDoneTask())
        }
        
        return container
    } catch {
        fatalError("Failed to create container: \(error.localizedDescription)")
    }
}()
