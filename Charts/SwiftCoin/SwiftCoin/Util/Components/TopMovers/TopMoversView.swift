//
//  TopMoversView.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI

struct TopMoversView: View {
    // MARK: - Properties
    @EnvironmentObject var viewModel: AppViewModel
    
    // MARK: - Layout
    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Movers")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.topMovingCoins) { coin in
                        NavigationLink {
                            CoinDetailsView(coin)
                        } label: {
                            TopMoversItemView(coin: coin)
                                .tint(Theme.textColor)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding()
    }
}

// MARK: - PreviewProvider
struct TopMoversView_Previews: PreviewProvider {
    static var previews: some View {
        TopMoversView()
            .environmentObject(AppViewModel(CoinService()))
    }
}
