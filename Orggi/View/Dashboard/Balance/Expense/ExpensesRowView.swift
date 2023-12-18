//
//  ResumeByTypeView.swift
//  Orggi
//
//  Created by Augusto Simionato on 19/11/23.
//

import SwiftUI
import Charts

struct ExpensesRowView: View {
    var expenses: [Expense]
    var category: String
    
    var body: some View {
        let shoppingExpenses = expenses.filter { $0.category == "\(category)" }
        let expensesByMonth = Dictionary(grouping: shoppingExpenses) { Calendar.current.component(.month, from: $0.date) }
            .mapValues { expenses in expenses.reduce(0) { $0 + $1.value } }
        
        if expensesByMonth.isEmpty {
            EmptyExpenseView()
        } else {
            List {
                Section {
                    Chart {
                        ForEach(expensesByMonth.keys.sorted(), id: \.self) { month in
                            BarMark(
                                x: .value("Mês", monthName(from: month)),
                                y: .value("Valor", expensesByMonth[month] ?? 0)
                            )
                            .cornerRadius(5.0)
                        }
                    }
                    .frame(height: 300)
                    .padding()
                }
                ForEach(expensesByMonth.keys.sorted(), id: \.self) { month in
                    Section(header: Text(monthName(from: month))) {
                        ForEach(shoppingExpenses.filter { Calendar.current.component(.month, from: $0.date) == month }, id: \.self) { expense in
                            ExpenseCell(expense: expense)
                        }
                    }
                }
            }
            .navigationTitle("Despesas com \(category)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func monthName(from month: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let date = dateFormatter.date(from: "\(month)")
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date!)
    }
}
