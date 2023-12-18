//
//  MainView.swift
//  Orggi
//
//  Created by Augusto Simionato on 15/11/23.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Query(sort: \Expense.value, order: .reverse) var expenses: [Expense]
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashscreenView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5))
            } else {
                TabView {
                    NavigationStack {
                        DashboardView()
                    }
                    .tabItem {
                        Image(systemName: "chart.pie.fill")
                        Text("Dashboard")
                    }
//                    NavigationStack {
//                        InvestmentsView()
//                    }
//                    .tabItem {
//                        Image(systemName: "chart.xyaxis.line")
//                        Text("Investments")
//                    }
//                    NavigationStack {
//                        GoalsView()
//                    }
//                    .tabItem {
//                        Image(systemName: "medal.fill")
//                        Text("Goals")
//                    }
                    NavigationStack {
                        HistoryView(expenses: expenses)
                    }
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis.ascending.badge.clock")
                        Text("History")
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                withAnimation {
                    self.showSplash = false
                }
            }
        }
    }
}

#Preview {
    MainView()
}
