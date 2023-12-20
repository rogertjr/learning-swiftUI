//
//  IntroView.swift
//  ExpenseTracker
//
//  Created by Rogério Toledo on 14/12/23.
//

import SwiftUI

struct IntroView: View {
	// MARK: - Properties
	@AppStorage("isFirstTime") private var isFirtTime: Bool = true
	
	// MARK: - Layout
    var body: some View {
		VStack(spacing: 15) {
			Text("What's new in the\nExpense Tracker")
				.font(.largeTitle.bold())
				.multilineTextAlignment(.center)
				.padding(.top, 65)
				.padding(.bottom, 35)
			
			VStack(alignment: .leading, spacing: 25) {
				pointView("dollarsign",
						  title: "Transactions",
						  subTitle: "Keep track of your earnings and expenses.")
				
				pointView("chart.bar.fill",
						  title: "Visual Charts",
						  subTitle: "View your transctions using eye-catching graphic representations.")
				
				pointView("magnifyingglass",
						  title: "Advance filters",
						  subTitle: "Find the expenses you want by advance search and filtering.")
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.horizontal, 15)
			
			Spacer(minLength: 10)
			
			Button(action: { isFirtTime = false }, label: {
				Text("Continue")
					.fontWeight(.bold)
					.foregroundStyle(.white)
					.frame(maxWidth: .infinity)
					.padding(.vertical, 15)
					.background(appTint.gradient, in: .rect(cornerRadius: 12))
					.contentShape(.rect)
			})
		}
		.padding(15)
    }
}

// MARK: - Builders
private extension IntroView {
	@ViewBuilder
	func pointView(_ symbol: String, title: String, subTitle: String) -> some View {
		HStack(spacing: 20) {
			Image(systemName: symbol)
				.font(.largeTitle)
				.foregroundStyle(appTint.gradient)
				.frame(width: 45)
			
			VStack(alignment: .leading, spacing: 6) {
				Text(title)
					.font(.title3)
					.fontWeight(.semibold)
				
				Text(subTitle)
					.foregroundStyle(.gray)
			}
		}
	}
}

// MARK: - Preview
#Preview {
    IntroView()
}
