//
//  AppViewModel.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import Foundation
import Combine

final class AppViewModel: ObservableObject {
    
    // MARK: - Properties
    private let service: CoinServiceProtocol
    
    @Published private(set) var error: CoinService.NetworkingError?
    @Published private(set) var state: ViewState = .idle
    @Published var hasError = false
    
    @Published private(set) var coins: [Coin] = []
    @Published private(set) var topMovingCoins: [Coin] = []
    
    @Published var searchText: String = ""
    @Published var searchedCoins: [Coin]?
    @Published var sort: Sort = .asc
    
    var isLoading: Bool {
        return state == .isLoading
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    init(_ service: CoinServiceProtocol = CoinService()) {
        self.service = service
        
        $searchText
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] search in
                guard let self else { return }
                if !search.isEmpty {
                    self.filterCoinsBySearch()
                } else {
                    self.searchedCoins = nil
                }
            }.store(in: &subscriptions)
        
        $sort
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] search in
                guard let self else { return }
                if let searchedCoins = self.searchedCoins, searchedCoins.count > 0 {
                    self.searchedCoins = self.sortCoins(searchedCoins)
                } else {
                    self.coins = self.sortCoins(self.coins)
                }
            }.store(in: &subscriptions)
    }
    
    // MARK: - Helpers
    func resetData() {
        if state == .finishedLoading {
            state = .idle
            coins = []
        }
    }
    
    func setUpTopMovingCoins() {
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H })
        topMovingCoins = Array(topMovers.prefix(5))
    }
    
    private func filterCoinsBySearch() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.coins
                .lazy
                .filter { [weak self] coin in
                    return coin.symbol.lowercased().contains(self?.searchText.lowercased() ?? "")
                        || coin.name.lowercased().contains(self?.searchText.lowercased() ?? "")
                }
            DispatchQueue.main.async {
                self.searchedCoins = results.compactMap({ $0 }).sorted(by: {
                    self.sort == .asc ? $0.marketCapRank < $1.marketCapRank : $0.marketCapRank > $1.marketCapRank
                })
            }
        }
    }
    
    private func sortCoins(_ coinsToSort: [Coin]) -> [Coin] {
        coinsToSort.sorted(by: { [weak self] in
            self?.sort == .asc ? $0.marketCapRank < $1.marketCapRank : $0.marketCapRank > $1.marketCapRank
        })
    }

    // MARK: - Networking
    @MainActor
    func fetchCoins() async {
        guard !isLoading else { return }
        resetData()
        
        state = .isLoading
        defer { state = .finishedLoading }
        
        do {
            let coinResponse = try await service.fetchAllCoins()
            coins += sortCoins(coinResponse)
            setUpTopMovingCoins()
            hasError = false
            HapticManager.notification(type: .success)
        } catch {
            state = .error("Failed to fetch coins")
            hasError = true
            if let networkingError = error as? CoinService.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error)
            }
        }
    }
}
