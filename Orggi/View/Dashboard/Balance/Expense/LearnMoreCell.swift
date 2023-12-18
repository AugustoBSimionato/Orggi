//
//  LearnMoreCell.swift
//  Orggi
//
//  Created by Augusto Simionato on 10/12/23.
//

import SwiftUI

struct LearnMoreCell: View {
    var image: String
    var title: String
    var subtitle: String
    var background: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .foregroundStyle(background)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                    .frame(height: 130)
                
                Image(systemName: image)
                    .font(.system(size: 50))
                    .foregroundStyle(.white)
            }
            Text(title)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.vertical, 3)
            Text(subtitle)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.bottom, 15)
        }
        .background(.buttonDashboardBackground)
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
}
