//
//  BalanceReceiveView.swift
//  Orggi
//
//  Created by Augusto Simionato on 03/12/23.
//

import SwiftUI

struct BalanceReceiveView: View {
    var expenses: [Expense]
    
    func formattedValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            let receiveExpenses = expenses.filter { $0.type == "Receive" }
            let totalReceive = receiveExpenses.reduce(0) { $0 + $1.value }
            HStack {
                Image(systemName: "arrow.down.forward.square.fill")
                    .foregroundStyle(.green)
                    .font(.system(size: 25))
                Spacer()
                Text("R$ \(formattedValue(totalReceive))")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.trailing)
            }
            Text("Receives")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
        }
        .padding(15)
        .background(.buttonDashboardBackground)
        .cornerRadius(10)
    }
}


#Preview {
    BalanceReceiveView(expenses: [Expense(name: "Açai", date: .now, value: 17.90, type: "Expense", category: "Trip", paymentType: "Cash", bankAccount: "Bradesco")])
}
