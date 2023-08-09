//
//  CreateViewModel.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 22/08/22.
//

import Foundation

final class CreateViewModel: ObservableObject {
    // MARK: - Properties
    @Published var person = Person()
    @Published private(set) var state: State?
    @Published var hasError = false
    @Published private(set) var error: FormError?
    private let validator = CreateValidator()
    
    // MARK: - Networking
    @MainActor
    func createPerson() async {
        do {
            try validator.validate(person)
            
            state = .loading
            let encoder = JSONEncoder()
            let data = try encoder.encode(person)
            
            try await NetworkingManager.shared.request(endpoint: .create(data))
            state = .success
        } catch {
            hasError = true
            state = .failure
            
            switch error {
            case is NetworkingManager.NetworkingError:
                self.error = .networking(error as! NetworkingManager.NetworkingError)
                
            case is CreateValidator.CreateValidatorErrors:
                self.error = .validation(error as! CreateValidator.CreateValidatorErrors)
                
            default:
                self.error = .system(error)
            }
        }
    }
}

// MARK: - View States
extension CreateViewModel {
    enum State {
        case success
        case failure
        case loading
    }
}

// MARK: - Errors
extension CreateViewModel {
    enum FormError: LocalizedError {
        case networking(_ error: LocalizedError)
        case validation(_ error: LocalizedError)
        case system(_ error: Error)
    }
}

extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let error),
                .validation(let error):
            return error.errorDescription
        case .system(let error):
            return error.localizedDescription
        }
    }
}
