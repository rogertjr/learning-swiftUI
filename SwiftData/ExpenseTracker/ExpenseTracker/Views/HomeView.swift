//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 14/12/23.
//

import SwiftUI

struct HomeView: View {
	// MARK: - Properties
	@AppStorage("isFirstTime") private var isFirtTime: Bool = true
	@AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
	@AppStorage("lockInBackground") private var lockInBackground: Bool = false
	
	@State private var activeTab: Tab = .recents
	
	// MARK: - Layout
    var body: some View {
		LockView(lockType: .biometric,
				 lockPin: "",
				 isEnabled: isAppLockEnabled,
				 lockWhenAppGoesBackground: lockInBackground) {
			TabView(selection: $activeTab) {
				RecentsView()
					.tag(Tab.recents)
					.tabItem { Tab.recents.tabContent }
				
				SearchView()
					.tag(Tab.search)
					.tabItem { Tab.search.tabContent }
				
				ChartsView()
					.tag(Tab.charts)
					.tabItem { Tab.charts.tabContent }
				
				SettingsView()
					.tag(Tab.settings)
					.tabItem { Tab.settings.tabContent }
			}
			.tint(appTint)
			.sheet(isPresented: $isFirtTime, content: {
				IntroView()
					.interactiveDismissDisabled()
			})
		}
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
