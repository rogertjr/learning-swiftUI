//
//  ThemeTip.swift
//  TipKitApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import Foundation
import TipKit

struct ThemeTip: Tip {
    @Parameter
    static var showTip: Bool = false
    static var numberOfTimesVisited: Event = Event(id: "xyz.decodely.tip.event.numberoftimesvisited")
    
    var title: Text {
        Text("Try change the app theme")
    }
    
    var message: Text? {
        Text("You can change the app look and feel to present dark or light theme")
    }
    
    var asset: Image? {
        Image(systemName: "lightbulb")
    }
    
    var options: [TipOption] {
        return [
            // Indicated the number of times that the tip will be present before be invalidated
             Tips.MaxDisplayCount(2)
        ]
    }
    
    var rules: [Rule] {
        return [#Rule(Self.$showTip) { $0 == true }]
    }
}
