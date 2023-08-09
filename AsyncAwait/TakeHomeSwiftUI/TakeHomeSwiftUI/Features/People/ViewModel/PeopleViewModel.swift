//
//  PeopleViewModel.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 21/08/22.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    // MARK: - Properties
    private let networkigManager: NetworkingManagerProtocol
    @Published private(set) var users: [User] = []
    @Published private(set) var state: State?
    @Published var hasError = false
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var shouldPresentCreate = false
    @Published var shouldPresentSuccess = false
    @Published var hasAppeared = false
    
    private var page: Int = 1
    private var totalPages: Int?
    
    var isLoading: Bool {
        state == .loading
    }
    
    var isFetching: Bool {
        state == .fetching
    }
    
    init(_ networkigManager: NetworkingManagerProtocol = NetworkingManager.shared) {
        self.networkigManager = networkigManager
    }
    
    // MARK: - Helpers
    func hasReachedEnd(of user: User) -> Bool {
        users.last?.id == user.id
    }
    
    private func reset() {
        if state == .finished {
            users.removeAll()
            page = 1
            totalPages = nil
            state = nil
        }
    }
    
    // MARK: - Networking
    @MainActor
    func fetchNextSetOfUsers() async {
        guard page != totalPages else { return }
        
        state = .fetching
        defer { state = .finished }
        
        page += 1
        do {
            let response = try await networkigManager.request(.shared,
                                                              endpoint: .people(page),
                                                              type: Users.self)
            users += response.data
            totalPages = response.totalPages
            hasError = false
        } catch {
            hasError = true
            state = .failure
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error)
            }
        }
    }
    
    @MainActor
    func fetchUsers() async {
        reset()
        
        state = .loading
        defer { state = .finished }
        
        do {
            let response = try await networkigManager.request(.shared,
                                                              endpoint: .people(page),
                                                              type: Users.self)
            users = response.data
            totalPages = response.totalPages
            hasError = false
        } catch {
            hasError = true
            state = .failure
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error)
            }
        }
    }
}

// MARK: - View States
extension PeopleViewModel {
    enum State {
        case fetching
        case loading
        case failure
        case finished
    }
}
