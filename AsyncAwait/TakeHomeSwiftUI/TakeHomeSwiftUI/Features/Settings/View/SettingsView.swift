//
//  SettingsView.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 22/08/22.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    @AppStorage(UserDefaultsKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
    
    // MARK: - Layout
    var body: some View {
        Form {
            hapticsView
        }
        .navigationTitle("Settings")
    }
}

// MARK: - Subviews
private extension SettingsView {
    var hapticsView: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
