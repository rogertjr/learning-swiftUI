//
//  NewObservationAppApp.swift
//  NewObservationApp
//
//  Created by Rogério Toledo on 09/08/23.
//

import SwiftUI

@main
struct NewObservationAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("ObservableObject", systemImage: "person")
                    }
                
                NewObservationView()
                    .tabItem {
                        Label("@Observable", systemImage: "person.circle")
                    }
            }
        }
    }
}
