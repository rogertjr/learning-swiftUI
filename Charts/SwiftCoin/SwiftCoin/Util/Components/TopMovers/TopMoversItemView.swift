//
//  TopMoversItemView.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI

struct TopMoversItemView: View {
    // MARK: - Properties
    let coin: Coin
    
    // MARK: - Layout
    var body: some View {
        VStack(alignment: .leading) {
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
            .padding(.bottom, 8)
            
            HStack(spacing: 2) {
                Text(coin.symbol.uppercased())
                    .font(.caption.bold())
                
                Text(coin.currentPrice.toCurrencyString())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text(coin.priceChangePercentage24H.toPercentString())
                .font(.title2)
                .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .red)
        }
        .frame(width: 140, height: 140)
        .background(Theme.itemBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}

// MARK: - PreviewProvider
struct TopMoversItemView_Previews: PreviewProvider {
    static var coins: [Coin] {
        let coinsResult = try! JSONMapper.decode(MockResultFiles.coinList.rawValue, type: [Coin].self)
        return coinsResult
    }
    
    static var previews: some View {
        TopMoversItemView(coin: coins.first!)
            .previewLayout(.sizeThatFits)
    }
}
