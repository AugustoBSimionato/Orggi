//
//  DashboardView.swift
//  Orggi
//
//  Created by Augusto Simionato on 14/11/23.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet1 = false
    @State private var isShowingItemSheet2 = false
    @Query(sort: \Expense.value, order: .reverse) var expenses: [Expense]
    
    var body: some View {
        let expenseExpenses = expenses.filter { $0.type == "Expense" }
        let totalExpense = expenseExpenses.reduce(0) { $0 + $1.value }
        let receiveExpenses = expenses.filter { $0.type == "Receive" }
        let totalReceive = receiveExpenses.reduce(0) { $0 + $1.value }
        
        let bradesco = Dictionary(grouping: expenses.filter { $0.bankAccount == "Bradesco" }, by: { $0.category })
            .mapValues { expenses in expenses.reduce(0) { $0 + $1.value } }
        let itau = Dictionary(grouping: expenses.filter { $0.bankAccount == "Itaú" }, by: { $0.category })
            .mapValues { expenses in expenses.reduce(0) { $0 + $1.value } }
        let inter = Dictionary(grouping: expenses.filter { $0.bankAccount == "Inter" }, by: { $0.category })
            .mapValues { expenses in expenses.reduce(0) { $0 + $1.value } }
        let santander = Dictionary(grouping: expenses.filter { $0.bankAccount == "Santander" }, by: { $0.category })
            .mapValues { expenses in expenses.reduce(0) { $0 + $1.value } }
        let nubank = Dictionary(grouping: expenses.filter { $0.bankAccount == "Nubank" }, by: { $0.category })
            .mapValues { expenses in expenses.reduce(0) { $0 + $1.value } }
        
        NavigationStack {
            VStack {
                ZStack {
                    Color.gray.opacity(0.1).ignoresSafeArea()
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                HStack {
                                    NavigationLink(destination: ResumeReceiveView(expenses: expenses)) {
                                        BalanceReceiveView(expenses: expenses)
                                    }
                                    Spacer()
                                    NavigationLink(destination: ResumeExpenseView(expenses: expenses)) {
                                        BalanceExpenseView(expenses: expenses)
                                    }
                                }
                                
                                if !expenses.isEmpty {
                                    if totalExpense < totalReceive {
                                        Text("You're doing a great job!")
                                            .foregroundStyle(.gray)
                                            .padding(.horizontal)
                                            .font(.footnote)
                                            .bold()
                                    } else {
                                        Text("Hold on, the month is not ended yet!")
                                            .foregroundStyle(.gray)
                                            .padding(.horizontal)
                                            .font(.footnote)
                                            .bold()
                                    }
                                }
                            }
                            .padding()
                            
                            Text("Your banks")
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                                .padding(.horizontal)
                            if (bradesco.count != 0) || (itau.count != 0) || (inter.count != 0) || (santander.count != 0) || (nubank.count != 0) {
                                VStack {
                                    HStack {
                                        if (bradesco.count != 0) {
                                            NavigationLink(destination: ResumeExpenseView(expenses: expenses)) {
                                                ByBankNavigationLinkView(bankName: "Bradesco")
                                            }
                                        }
                                        if (itau.count != 0) {
                                            Spacer()
                                            NavigationLink(destination: ResumeExpenseView(expenses: expenses)) {
                                                ByBankNavigationLinkView(bankName: "Itaú")
                                            }
                                        }
                                    }
                                    HStack {
                                        if (inter.count != 0) {
                                            NavigationLink(destination: ResumeExpenseView(expenses: expenses)) {
                                                ByBankNavigationLinkView(bankName: "Inter")
                                            }
                                        }
                                        if (santander.count != 0) {
                                            Spacer()
                                            NavigationLink(destination: ResumeExpenseView(expenses: expenses)) {
                                                ByBankNavigationLinkView(bankName: "Santander")
                                            }
                                        }
                                    }
                                    if (nubank.count != 0) {
                                        HStack {
                                            NavigationLink(destination: ResumeExpenseView(expenses: expenses)) {
                                                ByBankNavigationLinkView(bankName: "Nubank")
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 5)
                            } else {
                                HStack {
                                    EmptyExpenseView()
                                }
                            }
                            
                            Group {
                                Text("Categories")
                                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                                    .padding(.horizontal)
                                    .padding(.top, 15)
                                
                                NavigationLink(destination: ExpensesRowView(expenses: expenses, category: "Shopping")) {
                                    ByCategoryNavigationLinkView(title: "Shopping", image: "basket.fill", flag: .red)
                                }
                                NavigationLink(destination: ExpensesRowView(expenses: expenses, category: "Trip")) {
                                    ByCategoryNavigationLinkView(title: "Trip", image: "beach.umbrella.fill", flag: .blue)
                                }
                                NavigationLink(destination: ExpensesRowView(expenses: expenses, category: "Car")) {
                                    ByCategoryNavigationLinkView(title: "Car", image: "car.fill", flag: .green)
                                }
                                NavigationLink(destination: ExpensesRowView(expenses: expenses, category: "Grocery Store")) {
                                    ByCategoryNavigationLinkView(title: "Grocery Store", image: "cart.fill", flag: .orange)
                                }
                                NavigationLink(destination: ExpensesRowView(expenses: expenses, category: "Health")) {
                                    ByCategoryNavigationLinkView(title: "Health", image: "dumbbell.fill", flag: .mint)
                                }
                                NavigationLink(destination: ExpensesRowView(expenses: expenses, category: "Pharmacy")) {
                                    ByCategoryNavigationLinkView(title: "Pharmacy", image: "pill.fill", flag: .cyan)
                                }
                                NavigationLink(destination: ExpensesRowView(expenses: expenses, category: "Pet")) {
                                    ByCategoryNavigationLinkView(title: "Pet", image: "pawprint.fill", flag: .brown)
                                }
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingItemSheet1) { AddExpenseSheet() }
            .sheet(isPresented: $isShowingItemSheet2) { SettingsView() }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        isShowingItemSheet2 = true
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 17))
                            .bold()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        isShowingItemSheet1 = true
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 18))
                            .bold()
                    }
                }
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    DashboardView()
}
