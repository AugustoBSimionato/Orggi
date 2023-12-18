//
//  SplashscreenView.swift
//  Orggi
//
//  Created by Augusto Simionato on 26/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SplashscreenView: View {
    @State private var isAnimating = true
    @State private var isAppearing = true
    
    var body: some View {
        VStack {
            AnimatedImage(name: "icone_o.gif", isAnimating: $isAnimating)
                .resizable()
                .frame(width: 300, height: 300)
                .opacity(isAppearing ? 0.2 : 1)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.05)) {
                self.isAppearing.toggle()
            }
        }
        .onDisappear {
            withAnimation {
                self.isAnimating.toggle()
            }
        }
    }
}

#Preview {
    SplashscreenView()
}
