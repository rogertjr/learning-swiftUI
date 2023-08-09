//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    // MARK: - Properties
    private var service: NewsServiceProtocol
    private (set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: ResultState = .loading
    
    // MARK: - Init
    init(_ service: NewsServiceProtocol = NewsService()) {
        self.service = service
    }
    
    // MARK: - Networking
    func getArticles() {
        state = .loading
        service
            .request(from: .getNews)
            .sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .finished:
                    self.state = .success(content: self.articles)
                    break
                case .failure(let error):
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.articles = response.articles
            }
            .store(in: &cancellables)
    }
}
