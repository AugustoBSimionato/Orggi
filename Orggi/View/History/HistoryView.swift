//
//  ExpensesByMonthView.swift
//  Orggi
//
//  Created by Augusto Simionato on 15/11/23.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @State private var editExpense: Expense?
    @State private var searchExpenses = ""
    
    var expenses: [Expense]
    
    var filteredExpenses: [Expense] {
        guard !searchExpenses.isEmpty else { return expenses }
        return expenses.filter { $0.name.localizedCaseInsensitiveContains(searchExpenses) }
    }
    
    var body: some View {
        let expensesByMonth = Dictionary(grouping: filteredExpenses) { Calendar.current.component(.month, from: $0.date) }
        NavigationStack {
            VStack {
                if expenses.isEmpty {
                    EmptyExpenseView()
                } else if filteredExpenses.isEmpty {
                    ContentUnavailableView.search
                        .foregroundStyle(Color.accentColor)
                } else {
                    List {
                        ForEach(expensesByMonth.keys.sorted(), id: \.self) { month in
                            Section(header: Text(monthName(from: month))) {
                                ForEach(expensesByMonth[month] ?? [], id: \.self) { expense in
                                    ExpenseCell(expense: expense)
                                        .contextMenu {
                                            Button {
                                                editExpense = expense
                                            } label: {
                                                HStack {
                                                    Text("Update \(expense.type)")
                                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                                    Image(systemName: "pencil.and.outline")
                                                }
                                            }
                                            .onLongPressGesture {
                                                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                                impactMed.impactOccurred()
                                            }
                                        }
                                        .swipeActions(edge: .trailing) {
                                            Button(role: .destructive) {
                                                context.delete(expense)
                                                let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                                impactMed.impactOccurred()
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchExpenses, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "search-expenses")
        }
        .sheet(isPresented: $isShowingItemSheet) { AddExpenseSheet() }
        .sheet(item: $editExpense) { expense in
            ExpenseUpdateSheet(expense: expense)
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

func monthName(from month: Int) -> String {
    let dateFormatter = DateFormatter()
    let _ = dateFormatter.date(from: "\(month)")
    return dateFormatter.monthSymbols[month - 1]
}

#Preview {
    HistoryView(expenses: [Expense(name: "Açai", date: .now, value: 16.90, type: "Expense", category: "Shopping", paymentType: "Cash", bankAccount: "Bradesco")])
}
