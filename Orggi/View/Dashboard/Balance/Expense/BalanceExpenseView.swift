//
//  UpcomingExpensesView.swift
//  Orggi
//
//  Created by Augusto Simionato on 21/11/23.
//

import SwiftUI

struct BalanceExpenseView: View {
    var expenses: [Expense]
    
    func formattedValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            let receiveExpenses = expenses.filter { $0.type == "Expense" }
            let totalExpense = receiveExpenses.reduce(0) { $0 + $1.value }
            HStack {
                Image(systemName: "arrow.up.forward.square.fill")
                    .foregroundStyle(.red)
                    .font(.system(size: 25))
                Spacer()
                Text("R$ \(formattedValue(totalExpense))")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.trailing)
            }
            Text("Expenses")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
        }
        .padding(15)
        .background(.buttonDashboardBackground)
        .cornerRadius(10)
    }
}


#Preview {
    BalanceExpenseView(expenses: [Expense(name: "Açai", date: .now, value: 17.90, type: "Expense", category: "Trip", paymentType: "Cash", bankAccount: "Bradesco")])
}
