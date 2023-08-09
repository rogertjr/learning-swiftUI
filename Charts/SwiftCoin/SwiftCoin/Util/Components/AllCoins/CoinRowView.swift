//
//  CoinRowView.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI

struct CoinRowView: View {
    // MARK: - Properties
    let coin: Coin
    
    // MARK: - Layout
    var body: some View {
        HStack {
            Text(coin.marketCapRank.toRankString())
                .font(.caption)
                .foregroundColor(.gray)
                        
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
            .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.subheadline.bold())
                    .padding(.leading, 4)
                
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 6)
            }
            .padding(.leading, 2)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(coin.currentPrice.toCurrencyString())
                    .font(.subheadline.bold())
                    .padding(.leading, 4)
                
                Text(coin.priceChangePercentage24H.toPercentString())
                    .font(.caption)
                    .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .red)
                    .padding(.leading, 6)
            }
        }
    }
}

// MARK: - PreviewProvider
struct CoinRowView_Previews: PreviewProvider {
    static var coins: [Coin] {
        let coinsResult = try! JSONMapper.decode(MockResultFiles.coinList.rawValue, type: [Coin].self)
        return coinsResult
    }
    
    static var previews: some View {
        CoinRowView(coin: coins.first!)
            .previewLayout(.sizeThatFits)
    }
}
