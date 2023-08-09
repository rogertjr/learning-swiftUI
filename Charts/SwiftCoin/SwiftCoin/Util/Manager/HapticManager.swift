//
//  HapticManager.swift
//  SwiftCoin
//
//  Created by Rogério Toledo on 18/01/23.
//

import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
