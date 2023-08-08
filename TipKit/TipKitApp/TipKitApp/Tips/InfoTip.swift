//
//  InfoTip.swift
//  TipKitApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI
import TipKit

struct InfoTip: Tip {
    static var numberOfTimesVisited: Event = Event(id: "xyz.decodely.tip.event.numberoftimesvisited")
    
    var title: Text {
        Text("Tap here to get infos")
    }
    
    var message: Text? {
        Text("Dummy message")
    }
    
    var asset: Image? {
        Image(systemName: "info.circle")
    }
    
    var options: [TipOption] {
        return [
            // Indicated the number of times that the tip will be present before be invalidated
             Tips.MaxDisplayCount(3)
        ]
    }
    
    var rules: [Rule] {
        return [#Rule(Self.numberOfTimesVisited) { $0.donations.count > 1 }]
    }
}

