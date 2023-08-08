//
//  TipKitAppApp.swift
//  TipKitApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import TipKit

@main
struct TipKitAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    do {
                        try await Tips.configure {
                            DisplayFrequency(.immediate)
                            // By setting `shouldReset = true` the tip persistence is not store
                            // And the tips will always be shown when the app opens.
                            // DatastoreLocation(.applicationDefault, shouldReset: true)
                            
                            // For a better handling you can use a `bool @Parameter`
                            // and a list of `Rule` to control your custom Tip exhibition
                            DatastoreLocation(.applicationDefault)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
