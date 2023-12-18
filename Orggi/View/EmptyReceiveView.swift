//
//  EmptyReceiveView.swift
//  Orggi
//
//  Created by Augusto Simionato on 13/12/23.
//

import SwiftUI

struct EmptyReceiveView: View {
    var body: some View {
        VStack {
            ContentUnavailableView(label: {
                Label("No data", systemImage: "list.bullet.rectangle.portrait")
            }, description: {
                Text("Start adding receives to see more information.")
            })
            .foregroundStyle(Color.accentColor)
        }
    }
}

#Preview {
    EmptyReceiveView()
}
