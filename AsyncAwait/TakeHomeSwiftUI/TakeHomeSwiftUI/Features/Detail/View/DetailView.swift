//
//  DetailView.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 21/08/22.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Properties
    @StateObject private var viewModel = DetailViewModel()
    @Environment(\.dismiss) private var dismiss
    let userID: Int
        
    // MARK: - Layout
    var body: some View {
        ZStack {
            background
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        profileAvatarView
                        Group {
                            userDetailView
                            linkView
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Theme.detailBackground,
                                    in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Details")
        .task {
            await viewModel.fetchUserDetail(userID)
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
            Button("OK") {
                dismiss()
            }
        }
    }
}

// MARK: - Subviews
private extension DetailView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var userDetailView: some View {
        VStack(alignment: .leading, spacing: 8) {
            PillView(id: viewModel.userDetail?.data.id ?? 0)
            Group {
                firstNameView
                lastNameView
                emailView
            }
            .foregroundColor(Theme.text)
        }
    }
}

// MARK: - View Builders
private extension DetailView {
    @ViewBuilder
    func formHeader(_ text: String) -> some View {
        Text(text)
            .font(.system(.body, design: .rounded).weight(.semibold))
    }
    
    @ViewBuilder
    func formDescription(_ text: String) -> some View {
        Text(text)
            .font(.system(.subheadline, design: .rounded))
    }
    
    @ViewBuilder
    var firstNameView: some View {
        formHeader("First Name")
        formDescription(viewModel.userDetail?.data.firstName ?? "-")
        Divider()
    }
    
    @ViewBuilder
    var lastNameView: some View {
        formHeader("Last Name")
        formDescription(viewModel.userDetail?.data.lastName ?? "-")
        
        Divider()
    }
    
    @ViewBuilder
    var emailView: some View {
        formHeader("Email")
        formDescription(viewModel.userDetail?.data.email ?? "-")
    }
    
    @ViewBuilder
    var profileAvatarView: some View {
        if let absoluteString = viewModel.userDetail?.data.avatar,
           let avatarURL = URL(string: absoluteString) {
            AsyncImage(url: avatarURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(height: 250, alignment: .center)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    @ViewBuilder
    var linkView: some View {
        if let absoluteString = viewModel.userDetail?.support.url,
           let supportUrl = URL(string: absoluteString),
           let supportText = viewModel.userDetail?.support.text {
            Link(destination: supportUrl) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(supportText)
                        .foregroundColor(Theme.text)
                        .font(.system(.body, design: .rounded).weight(.semibold))
                        .multilineTextAlignment(.leading)
                    
                    Text(absoluteString)
                }
                
                Spacer()
                
                Symbols.link
                    .font(.system(.title3, design: .rounded))
            }
        }
    }
}

// MARK: - PreviewProvider
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(userID: 1)
        }
    }
}
