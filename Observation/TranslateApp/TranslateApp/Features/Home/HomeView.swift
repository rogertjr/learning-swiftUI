//
//  ContentView.swift
//  TranslateApp
//
//  Created by Rogério Toledo on 09/08/23.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    let viewModel: HomeViewModel = HomeViewModel()
    
    // MARK: - User Interface
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Text Translation")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "bell.badge")
                            .frame(width: 45, height: 45)
                            .foregroundColor(.primary)
                    }
                    
                    VStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 343, height: 1)
                            .background(.primary.opacity(0.3))
                    }
                    
                    HStack {
                        Picker("Source Language", selection: .constant("")) {
                            ForEach(0..<viewModel.languages.count, id: \.self) { index in
                                Text(viewModel.languages[index])
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        
                        Image(systemName: "arrow.left.arrow.right")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.primary)
                        
                        Picker("Source Language", selection: .constant("")) {
                            ForEach(0..<viewModel.languages.count, id: \.self) { index in
                                Text(viewModel.languages[index])
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    
                    VStack {
                        Text("Translation from Portuguese")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.primary)
                            .padding()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 343, height: 208)
                                .background(.gray.opacity(0.3))
                                .cornerRadius(22)
                            VStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 343, height: 1)
                                    .background(.primary.opacity(0.3))
                                    .offset(y: 55)
                                
                                HStack {
                                    Text("0/500")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.primary.opacity(0.3))
                                        
                                    Spacer()
                                }
                                .offset(y: 60)
                                .padding(.horizontal)
                            }
                            
                            TextField("Enter your text", text: .constant(""), axis: .vertical)
                                .lineLimit(3)
                                .font(.title2)
                                .foregroundStyle(.primary)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: {}, label: {
                        Text("Translate")
                    })
                    .padding()
                    
                    VStack {
                        Text("Translation from English")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.primary)
                            .padding()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 343, height: 208)
                                .background(.gray.opacity(0.3))
                                .cornerRadius(22)
                            VStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 343, height: 1)
                                    .background(.primary.opacity(0.3))
                                    .offset(y: 55)
                                
                                HStack {
                                    Text("0/500")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.primary.opacity(0.3))
                                        
                                    Spacer()
                                }
                                .offset(y: 60)
                                .padding(.horizontal)
                            }
                            
                            Text("Your text translated")
                                .font(.title2)
                                .foregroundStyle(.primary)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
