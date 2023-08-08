//
//  ModelPreview.swift
//  TodoApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI
import SwiftData

struct ModelPreview<Model: PersistentModel, Content: View>: View {
    // MARK: - Properties
    var content: (Model) -> Content
    
    // MARK: - Init
    init(@ViewBuilder content: @escaping (Model) -> Content) {
        self.content = content
    }
    
    // MARK: - User Interface
    var body: some View {
        PreviewContentView(content: content)
            .modelContainer(previewContainer)
    }
    
    // MARK: - Preview
    struct PreviewContentView: View {
        @Query private var models: [Model]
        var content: (Model) -> Content
        
        @State private var waitedToShowIssue = false
        
        var body: some View {
            if let model = models.first {
                content(model)
            } else {
                ContentUnavailableView("Couldn't load model for previews", systemImage: "xmark")
                    .opacity(waitedToShowIssue ? 1 : 0)
                    .task {
                        Task {
                            try await Task.sleep(for: .seconds(1))
                            waitedToShowIssue = true
                        }
                    }
            }
        }
    }
}
