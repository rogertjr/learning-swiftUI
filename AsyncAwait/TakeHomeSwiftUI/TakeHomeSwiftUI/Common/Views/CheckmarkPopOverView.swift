//
//  CheckmarkPopOverView.swift
//  TakeHomeSwiftUI
//
//  Created by Rogério Toledo on 22/08/22.
//

import SwiftUI

struct CheckmarkPopOverView: View {    
    // MARK: - Layout
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle, design: .rounded).bold())
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10,
                                                            style: .continuous))
    }
}

// MARK: - PreviewProvider
struct CheckmarkPopOverView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkPopOverView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.blue)
    }
}
