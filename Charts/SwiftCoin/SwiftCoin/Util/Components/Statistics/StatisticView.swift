//
//  StatisticView.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI

struct StatisticView: View {
    // MARK: - Properties
    let model: StatisticModel
    
    // MARK: - Layout
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.title)
                .font(.caption)
            
            Text(model.value)
                .font(.headline)
            
            
            if let percentChange = model.percentageChange {
                HStack(spacing: 4) {
                    Image(systemName: percentChange > 0 ? "triangle.fill": "arrowtriangle.down.fill")
                        .font(.caption)
                    
                    Text(percentChange.toPercentString())
                        .font(.caption.bold())
                }
                .foregroundColor(percentChange > 0 ? .green : .red)
            }
        }
    }
}

// MARK: - PreviewProvider
struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(model: StatisticModel(title: "Preview", value: "N/a", percentageChange: nil))
    }
}
