//
//  NavigationLinkByBankView.swift
//  Orggi
//
//  Created by Augusto Simionato on 04/12/23.
//

import SwiftUI

struct ByBankNavigationLinkView: View {
    var bankName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Spacer()
                Image(systemName: "arrow.up.forward.square.fill")
                    .foregroundStyle(.accent)
                    .font(.system(size: 25))
            }
            Text(bankName)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
        }
        .padding(15)
        .background(.buttonDashboardBackground)
        .cornerRadius(10)
    }
}

#Preview {
    ByBankNavigationLinkView(bankName: "Bradesco")
}
