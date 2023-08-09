//
//  HapticsManager.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 22/08/22.
//

import Foundation
import UIKit

fileprivate final class HapticsManager {
    // MARK: - Properties
    static let shared = HapticsManager()
    private let feedback = UINotificationFeedbackGenerator()
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Methods
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
}

// MARK: - Function
func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hapticsEnabled) {
        HapticsManager.shared.trigger(notification)
    }
}
