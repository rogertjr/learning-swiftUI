//
//  PeopleView.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 21/08/22.
//

import SwiftUI

struct PeopleView: View {
    // MARK: - Properties
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    @StateObject private var viewModel = PeopleViewModel()
    
    // MARK: - Layout
    var body: some View {
        NavigationView {
            ZStack {
                background
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        gridView
                            .padding(.horizontal)
                    }
                    .overlay(alignment: .bottom) {
                        if viewModel.isFetching {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    createButtonView
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    refreshButtonView
                }
            }
            .task {
                if !viewModel.hasAppeared {
                    await viewModel.fetchUsers()
                    viewModel.hasAppeared = true
                }
            }
            .sheet(isPresented: $viewModel.shouldPresentCreate) {
                CreateView {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.viewModel.shouldPresentSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
                Button("Retry") {
                    Task {
                        await viewModel.fetchUsers()
                    }
                }
            }
            .overlay {
                if viewModel.shouldPresentSuccess {
                    CheckmarkPopOverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.viewModel.shouldPresentSuccess.toggle()
                                }
                            }
                        }
                }
            }
        }
    }
}

// MARK: - Subviews
private extension PeopleView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var gridView: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.users, id: \.id) { user in
                NavigationLink {
                    DetailView(userID: user.id)
                } label: {
                    PersonItemView(user: user)
                        .task {
                            if viewModel.hasReachedEnd(of: user) && !viewModel.isFetching {
                                await viewModel.fetchNextSetOfUsers()
                            }
                        }
                }
            }
        }
    }
    
    var createButtonView: some View {
        Button {
            viewModel.shouldPresentCreate.toggle()
        } label: {
            Symbols.plus
                .font(.system(.headline, design: .rounded).bold())
        }
        .disabled(viewModel.isLoading)
    }
    
    var refreshButtonView: some View {
        Button {
            Task {
                await viewModel.fetchUsers()
            }
        } label: {
            Symbols.refresh
                .font(.system(.headline, design: .rounded).bold())
        }
        .disabled(viewModel.isLoading)
    }
}

// MARK: - Preview
struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
