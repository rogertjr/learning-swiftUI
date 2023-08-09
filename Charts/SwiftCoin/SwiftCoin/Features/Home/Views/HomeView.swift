//
//  ContentView.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @StateObject private var viewModel = AppViewModel()
    
    // MARK: - Layout
    var body: some View {
        NavigationStack {
            if viewModel.coins.isEmpty {
                Spacer()
                
                VStack(alignment: .center) {
                    Text("Coin list is empty")
                        .font(.subheadline.bold())
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    TopMoversView()
                        .environmentObject(viewModel)

                    Divider()
                        .padding(.horizontal)
                    
                    AllCoinsView()
                        .environmentObject(viewModel)
                }
                .navigationTitle("Live Prices")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        Button {
                            viewModel.resetData()
                            Task {
                                await viewModel.fetchCoins()
                            }
                        } label: {
                            Image(systemName: "goforward")
                                .font(.caption)
                                .foregroundColor(Theme.textColor)
                        }
                    })
                    
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Menu {
                            Section {
                                Text("Sort")
                                Picker(selection: $viewModel.sort) {
                                    Label("Ascending", systemImage: "arrow.up").tag(Sort.asc)
                                    Label("Descending", systemImage: "arrow.down").tag(Sort.desc)
                                } label: {
                                    Text("Sort By")
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.caption)
                                .foregroundColor(Theme.textColor)
                        }
                    })
                }
                .onTapGesture { UIApplication.shared.endEditing() }
            }
        }
        .searchable(text: $viewModel.searchText)
        .task {
            await viewModel.fetchCoins()
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
            Button("Retry", role: .cancel) {
                Task {
                    await viewModel.fetchCoins()
                }
            }
            Button("Cancel", role: .destructive) { }
        }
        .overlay(content: {
            ZStack {
                if case .isLoading = viewModel.state {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Theme.background)
                }
            }
        })
    }
}

// MARK: - PreviewProvider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
