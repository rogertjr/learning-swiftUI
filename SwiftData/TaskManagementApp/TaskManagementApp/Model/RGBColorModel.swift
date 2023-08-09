//
//  RGBColorModel.swift
//  TaskManagementApp
//
//  Created by Rogério Toledo on 08/08/23.
//

import Foundation
import SwiftUI

struct RGBColorModel: Codable {
    // MARK: - Properties
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double

    // MARK: - Inits
    init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    init(_ color: Color) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
        self.alpha = Double(alpha)
    }

    // MARK: - Helpers
    func toSwiftUIColor() -> Color {
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

