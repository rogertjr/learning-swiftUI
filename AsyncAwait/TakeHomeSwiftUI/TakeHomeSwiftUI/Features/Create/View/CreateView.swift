//
//  CreateView.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 21/08/22.
//

import SwiftUI

struct CreateView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = CreateViewModel()
    @FocusState private var focusedField: Field?
    let successfulAction: () -> Void
    
    // MARK: - Layout
    var body: some View {
        NavigationView {
            Form {
                Section {
                    firstNameTextfieldView
                    lastNameTextfieldView
                    jobTextfieldView
                } footer: {
                    if case .validation(let error) = viewModel.error,
                       let errorDescription = error.errorDescription {
                        Text(errorDescription)
                            .foregroundStyle(.red)
                    }
                }
                Section {
                    submitButtonView
                }
            }
            .disabled(viewModel.state == .loading)
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    doneButtonView
                }
            }
            .onChange(of: viewModel.state) { state in
                if state == .success {
                    dismiss()
                    successfulAction()
                }
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.error) { }
            .overlay {
                if viewModel.state == .loading {
                    ProgressView()
                }
            }
        }
    }
}

// MARK: - Focus Helper
extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}

// MARK: - Subivews
private extension CreateView {
    var doneButtonView: some View {
        Button("Done") {
            dismiss()
        }
    }
    
    var firstNameTextfieldView: some View {
        TextField("First Name", text: $viewModel.person.firstName)
            .focused($focusedField, equals: .firstName)
    }
    
    var lastNameTextfieldView: some View {
        TextField("Last Name", text: $viewModel.person.lastName)
            .focused($focusedField, equals: .lastName)
    }
    
    var jobTextfieldView: some View {
        TextField("Job", text: $viewModel.person.job)
            .focused($focusedField, equals: .job)
    }
    
    var submitButtonView: some View {
        Button("Submit") {
            focusedField = nil
            Task {
                await viewModel.createPerson()
            }
        }
    }
}

// MARK: - PreviewProvider
struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView { }
    }
}
