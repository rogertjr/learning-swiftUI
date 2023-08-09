//
//  OffsetKey.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

