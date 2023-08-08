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
                Section {
                    NavigationLink {
                        DetailedBookSalesView(salesViewModel: salesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleBookSalesView(salesViewModel: salesViewModel)
                    }
                }
                
                Section {
                    NavigationLink {
                        SalesByWeekdayView(salesViewModel: salesViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleSalesByWeekdayView(salesViewModel: salesViewModel)
                    }
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
