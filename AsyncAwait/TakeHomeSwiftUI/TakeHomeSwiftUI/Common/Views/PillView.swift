//
//  PillView.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 21/08/22.
//

import SwiftUI

struct PillView: View {
    // MARK: - Properties
    let id: Int
    
    // MARK: - Layout
    var body: some View {
        Text("#\(id)")
            .font(.system(.caption, design: .rounded).bold())
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Theme.pill, in: Capsule())
    }
}

// MARK: - PreviewProvider
struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(id: 0)
            .previewLayout(.sizeThatFits)
    }
}
