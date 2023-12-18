//
//  ResumeReceiveView.swift
//  Orggi
//
//  Created by Augusto Simionato on 05/12/23.
//

import SwiftUI
import Charts

struct ResumeReceiveView: View {
    var expenses: [Expense]
    
    var body: some View {
        let allReceives = expenses.filter { $0.type == "Receive" }
        let receivesByMonth = Dictionary(grouping: allReceives) { Calendar.current.component(.month, from: $0.date) }
            .mapValues { expenses in expenses.reduce(0) { $0 + $1.value } }
        
        VStack {
            if allReceives.isEmpty {
                EmptyReceiveView()
            } else {
                VStack {
                    Chart {
                        ForEach(receivesByMonth.keys.sorted(), id: \.self) { month in
                            BarMark(
                                x: .value("Mês", monthName(from: month)),
                                y: .value("Valor", receivesByMonth[month] ?? 0)
                            )
                            .cornerRadius(5.0)
                        }
                    }
                    .frame(height: 300)
                    .padding(.top)
                    
                    List {
                        ForEach(receivesByMonth.keys.sorted(), id: \.self) { month in
                            Section(header: Text(monthName(from: month))) {
                                ForEach(allReceives.filter { Calendar.current.component(.month, from: $0.date) == month }, id: \.self) { expense in
                                    ExpenseCell(expense: expense)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle("Receives")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func monthName(from month: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let date = dateFormatter.date(from: "\(month)")
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date!)
    }
}

#Preview {
    ResumeReceiveView(expenses: [Expense(name: "Açai", date: .now, value: 16.90, type: "Expense", category: "Trip", paymentType: "Cash", bankAccount: "Bradesco")])
}
