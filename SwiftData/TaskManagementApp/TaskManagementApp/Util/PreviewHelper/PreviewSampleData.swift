//
//  PreviewSampleData.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import SwiftData

let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: TaskModel.self, ModelConfiguration(inMemory: true))
        
        Task { @MainActor in
            let context = container.mainContext
            
            for i in 0..<TaskModel.dummyList().count {
                context.insert(TaskModel.dummyList()[i])
            }
        }
        
        return container
    } catch {
        fatalError("Failed to create container: \(error.localizedDescription)")
    }
}()
