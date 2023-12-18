//
//  EmptyExpenseView.swift
//  Orggi
//
//  Created by Augusto Simionato on 15/11/23.
//

import SwiftUI

struct EmptyExpenseView: View {
    var body: some View {
        VStack {
            ContentUnavailableView(label: {
                Label("No data", systemImage: "list.bullet.rectangle.portrait")
            }, description: {
                Text("Start adding expenses to see more information.")
            })
            .foregroundStyle(Color.accentColor)
        }
    }
}

#Preview {
    EmptyExpenseView()
}
