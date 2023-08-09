//
//  ContentView.swift
//  NewObservationApp
//
//  Created by Rogério Toledo on 09/08/23.
//

import SwiftUI

// MARRK: - "Old Fashioned way"
// Cons - Causes unnecessary UI updates and also may cause slowness
class User: ObservableObject {
    @Published var name: String
    @Published var jobTitle: String
    @Published var followerCount: Int
    @Published var bio: String
    
    init(name: String, jobTitle: String, followerCount: Int, bio: String) {
        self.name = name
        self.jobTitle = jobTitle
        self.followerCount = followerCount
        self.bio = bio
    }
}

struct ContentView: View {
    @StateObject var user = User(name: "Roger",
                                 jobTitle: "iOS Dev",
                                 followerCount: 99,
                                 bio: "")
    var body: some View {
        VStack(alignment: .center, content: {
            Text(user.name)
                .font(.title.bold())
            Text(user.jobTitle)
                .foregroundStyle(.secondary)
            Text("\(user.followerCount) followers")
                .foregroundStyle(.secondary)
            
            Button(action: {
                user.followerCount += 1
            }, label: {
                Text("Add follower")
            })
            .buttonStyle(.borderedProminent)
            .padding(.top)
            
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
