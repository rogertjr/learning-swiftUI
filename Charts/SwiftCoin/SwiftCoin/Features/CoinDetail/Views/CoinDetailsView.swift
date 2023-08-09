//
//  CoinDetailsView.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI

struct CoinDetailsView: View {
    // MARK: - Properties
    let coin: Coin
    private let viewModel: CoinDetailsViewModel
    
    init(_ coin: Coin) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coin)
    }
    
    // MARK: - Layout
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ChartView(viewModel: viewModel)
                    .frame(height: 250)
                    .padding(.vertical)
                
                CoinDetailSectionView(model: viewModel.overviewSectionModel) 
                    .padding(.vertical)
                
                CoinDetailSectionView(model: viewModel.additionalDetailsSectionModel)
                    .padding(.vertical)
            }
        }
        .padding()
        .navigationTitle(viewModel.coinName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                coinToolbarLogo
            })
        }
    }
}

// MARK: - ViewBuilders
private extension CoinDetailsView {
    var coinToolbarLogo: some View {
        HStack {
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Theme.textColor.opacity(0.5))
            
            VStack(alignment: .center) {
                if let url = URL(string: coin.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .ignoresSafeArea(.all)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                } else {
                    Image(systemName: "number.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.orange)
                }
            }
            .frame(width: 25, height: 25)
        }
    }
}

// MARK: - PreviewProvider
struct CoinDetailsView_Previews: PreviewProvider {
    static var coins: [Coin] {
        let coinsResult = try! JSONMapper.decode(MockResultFiles.coinList.rawValue, type: [Coin].self)
        return coinsResult
    }
    
    static var previews: some View {
        NavigationView {
            CoinDetailsView(coins.first!)
        }
    }
}
