//
//  DetailViewModel.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 21/08/22.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published private(set) var userDetail: UserDetail?
    @Published private(set) var state: State?
    @Published var hasError = false
    @Published private(set) var isLoading = false
    @Published private(set) var error: NetworkingManager.NetworkingError?
    
    // MARK: - Networking
    @MainActor
    func fetchUserDetail(_ userID: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await NetworkingManager.shared.request(endpoint: .detail(userID), type: UserDetail.self)
            userDetail = response
            state = .success
            hasError = false
        } catch {
            hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error)
            }
            
        }
    }
}

// MARK: - View States
extension DetailViewModel {
    enum State {
        case success
        case failure
    }
}
