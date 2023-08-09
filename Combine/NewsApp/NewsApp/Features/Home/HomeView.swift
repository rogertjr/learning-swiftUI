//
//  ContentView.swift
//  NewsApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.openURL) var openURL
    
    // MARK: - User Interface
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error) {
                    viewModel.getArticles()
                }
            case .success(let articles):
                NavigationView {
                    List(articles) { item in
                        ArticleView(article: item)
                            .onTapGesture {
                                fetchUrl(item.url)
                            }
                    }
                    .navigationTitle(Text("News"))
                }
            }
        }
        .onAppear {
            viewModel.getArticles()
        }
    }
    
    // MARK: - Helpers
    private func fetchUrl(_ url: String?) {
        guard let link = url, let url = URL(string: link) else { return }
        openURL(url)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
