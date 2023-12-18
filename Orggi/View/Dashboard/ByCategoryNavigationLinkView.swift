//
//  NavigationLinkByTypeView.swift
//  Orggi
//
//  Created by Augusto Simionato on 24/11/23.
//

import SwiftUI
import SwiftData

struct ByCategoryNavigationLinkView: View {
    var title: String
    var image: String
    var flag: Color
    
    @Environment(\.modelContext) var context
    @Query(sort: \Expense.value, order: .reverse) var expenses: [Expense]
    
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(flag)
                        .opacity(0.2)
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: image)
                        .font(.system(size: 22))
                        .foregroundStyle(flag)
                }
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("Access more information about this category")
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                }
                .padding(.leading, 7)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(15)
        }
        .background(.buttonDashboardBackground)
        .cornerRadius(10)
        .padding(.horizontal, 13)
        .padding(.vertical, 3)
    }
}

#Preview {
    ByCategoryNavigationLinkView(title: "Shopping", image: "basket.fill", flag: .red)
}
