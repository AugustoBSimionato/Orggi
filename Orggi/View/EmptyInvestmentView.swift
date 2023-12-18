//
//  EmptyInvestmentView.swift
//  Orggi
//
//  Created by Augusto Simionato on 23/11/23.
//

import SwiftUI

struct EmptyInvestmentView: View {
    var body: some View {
        VStack {
            ContentUnavailableView(label: {
                Image(systemName: "list.bullet.below.rectangle")
                    .font(.system(size: 40))
                Text("No assets")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            }, description: {
                Text("Start adding assets to see more information.")
                    .font(.system(size: 17, design: .rounded))
            })
            .foregroundStyle(Color.accentColor)
        }
    }
}

#Preview {
    EmptyInvestmentView()
}
