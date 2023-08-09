//
//  CoinDetailSectionView.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI

struct CoinDetailSectionView: View {
    // MARK: - Properties
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    let model: CoinDetailsSectionModel
    
    // MARK: - Layout
    var body: some View {
        VStack {
            Text(model.title)
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                ForEach(model.stats) { stat in
                    StatisticView(model: stat)
                }
            }
        }
    }
}

// MARK: - PreviewProvider
struct CoinDetailSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailSectionView(model: CoinDetailsSectionModel(title: "Preview", stats: []))
    }
}
