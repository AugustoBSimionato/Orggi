//
//  InvestmentsView.swift
//  Orggi
//
//  Created by Augusto Simionato on 23/11/23.
//

import SwiftUI
import SwiftData
import Charts

struct InvestmentsView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @State private var isShowingItemSheet2 = false
    @Query(sort: \Expense.value, order: .reverse) var expenses: [Expense]
    
    var body: some View {
        NavigationStack {
            VStack {
                if expenses.isEmpty {
                    EmptyInvestmentView()
                } else {
                    List {
                        Section("Investment Capital") {
                            VStack {
                                Text("Gráfico aqui")
                            }
                        }
                        Section("All Assets") {
                            ResumeExpenseView(expenses: expenses)
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingItemSheet) { AddExpenseSheet() }
            .sheet(isPresented: $isShowingItemSheet2) { AddAssetSheet() }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        isShowingItemSheet2 = true
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 19))
                            .bold()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        isShowingItemSheet = true
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 19))
                            .bold()
                    }
                }
            }
            .navigationTitle("Investments")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    InvestmentsView()
}
