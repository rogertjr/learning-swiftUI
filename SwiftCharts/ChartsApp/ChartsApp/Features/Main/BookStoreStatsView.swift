//
//  BookStoreStatsView.swift
//  ChartsApp
//
//  Created by Rogério Toledo on 07/08/23.
//

import SwiftUI

struct BookStoreStatsView: View {
    // MARK: - Properties
    @StateObject var salesViewModel = SalesViewModel.previewData
    
    // MARK: - User Interface
    var body: some View {
        NavigationStack {
            List {
                
                NavigationLink {
                    DetailedBookSalesView(salesViewModel: salesViewModel)
                } label: {
                    SimpleBookSalesView(salesViewModel: salesViewModel)
                }

            }
            .navigationTitle("Your Book Store Stats")
        }
    }
}

// MARK: - Preview
#Preview {
    BookStoreStatsView()
}
