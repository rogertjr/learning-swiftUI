//
//  SwiftCoinApp.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI

@main
struct SwiftCoinApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .tint(Theme.textColor)
        }
    }
}
