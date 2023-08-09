//
//  CreateValidator.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 22/08/22.
//

import Foundation

struct CreateValidator {
    // MARK: - Validate
    func validate(_ person: Person) throws {
        if person.firstName.isEmpty { throw CreateValidatorErrors.invalidFirtName }
        if person.lastName.isEmpty { throw CreateValidatorErrors.invalidLastName }
        if person.job.isEmpty { throw CreateValidatorErrors.invalidJob }
    }
}

// MARK: - Errors
extension CreateValidator {
    enum CreateValidatorErrors: LocalizedError {
        case invalidFirtName
        case invalidLastName
        case invalidJob
    }
}

extension CreateValidator.CreateValidatorErrors {
    var errorDescription: String? {
        switch self {
        case .invalidFirtName:
            return "First name can't be empty"
        case .invalidLastName:
            return "Last name can't be empty"
        case .invalidJob:
            return "Job can't be empty"
        }
    }
}
