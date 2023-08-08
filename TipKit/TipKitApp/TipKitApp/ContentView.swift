//
//  ContentView.swift
//  TipKitApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import TipKit

struct ContentView: View {
    private var themeTip = ThemeTip()
    private var infoTip = InfoTip()
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Open twice to show tip") {
                    VStack {
                        
                    }
                    .navigationTitle("Info tip")
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                
                            } label: {
                                Image(systemName: "info.circle")
                                    .foregroundStyle(.primary)
                            }
                            .popoverTip(infoTip, arrowEdge: .top)
                        }
                    })
                    .onAppear(perform: {
                        InfoTip.numberOfTimesVisited.donate()
                    })
                }
            }
            .navigationTitle("TipKit App")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        ThemeTip.showTip = true
                    } label: {
                        Image(systemName: "lightbulb")
                            .foregroundStyle(.primary)
                    }
                    .popoverTip(themeTip, arrowEdge: .top)
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
