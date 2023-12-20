//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 14/12/23.
//

import SwiftUI

struct SettingsView: View {
	// MARK: - Properties
	@AppStorage("userName") private var userName: String = ""
	@AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
	@AppStorage("lockInBackground") private var lockInBackground: Bool = false
	
	// MARK: - Layout
    var body: some View {
		NavigationStack {
			List {
				Section("User") {
					TextField("Your name", text: $userName)
				}
				
				Section("App Lock") {
					Toggle("Enable App Lock", isOn: $isAppLockEnabled)
					if isAppLockEnabled {
						Toggle("Lock when app goes background", isOn: $lockInBackground)
					}
				}
			}
			.navigationTitle("Settings")
		}
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
}
