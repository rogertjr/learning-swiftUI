//
//  HeaderView.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: HomeViewModel
    
    // MARK: - User Interface
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(viewModel.currentDate.format("MMMM"))
                    .foregroundStyle(.darkBlue)
                
                Text(viewModel.currentDate.format("YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            
            Text(viewModel.currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
            
            /// Week Slider
            TabView(selection: $viewModel.currentWeekIndex) {
                ForEach(viewModel.weekSlider.indices, id: \.self) { index in
                    WeekView(viewModel: viewModel, week: viewModel.weekSlider[index])
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .topTrailing, content: {
            Button(action: {}, label: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(.circle)
                    .foregroundColor(.darkBlue)
            })
        })
        .padding(15)
        .background(.white)
        .onChange(of: viewModel.currentWeekIndex, initial: false) { oldValue, newValue in
            /// Creating When it reaches first/last Page
            if newValue == 0 || newValue == (viewModel.weekSlider.count - 1) {
                viewModel.createWeek = true
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HeaderView(viewModel: .previewData)
}
