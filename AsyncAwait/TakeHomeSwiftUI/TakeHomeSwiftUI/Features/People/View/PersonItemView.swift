//
//  PersonItemView.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 21/08/22.
//

import SwiftUI

struct PersonItemView: View {
    // MARK: - Properties
    let user: User
    
    // MARK: - Layout
    var body: some View {
        VStack(spacing: .zero) {
            
            AsyncImage(url: .init(string: user.avatar)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 130)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(height: 130)
            }
            
            VStack(alignment: .leading) {
                PillView(id: user.id)
                
                Text("\(user.firstName) \(user.lastName)")
                    .foregroundColor(Theme.text)
                    .font(.system(.body, design: .rounded))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Theme.detailBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Theme.text.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

// MARK: - PreviewProvider
struct PersonItemView_Previews: PreviewProvider {
    static var prewviewUser: User {
        let users = try! JSONMapper.decode("UsersResponse", type: Users.self)
        return users.data.first!
    }
    
    static var previews: some View {
        PersonItemView(user: prewviewUser)
            .frame(width: 250)
    }
}
