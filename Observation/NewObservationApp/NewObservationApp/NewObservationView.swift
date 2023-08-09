//
//  NewObservationView.swift
//  NewObservationApp
//
//  Created by Rogério Toledo on 09/08/23.
//

import SwiftUI
import Observation

// MARRK: - New way
// By adding this macro
// Swift starts to track the view that access the properties of this observable class
// With this tracking, is possible to eliminate unnecessary UI updates (which used to make the app to hang)
@Observable class UserProfile {
    var name: String
    var jobTitle: String
    var followerCount: Int
    var bio: String
    
    init(name: String, jobTitle: String, followerCount: Int, bio: String) {
        self.name = name
        self.jobTitle = jobTitle
        self.followerCount = followerCount
        self.bio = bio
    }
}

struct NewObservationView: View {
    var user = UserProfile(name: "Roger", jobTitle: "iOS Dev", followerCount: 99, bio: "")
    
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
    NewObservationView()
}
