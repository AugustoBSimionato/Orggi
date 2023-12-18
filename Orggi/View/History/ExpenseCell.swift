//
//  ExpenseCell.swift
//  Orggi
//
//  Created by Augusto Simionato on 14/11/23.
//

import SwiftUI

struct ExpenseCell: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(expense.type == "Receive" ? .green.opacity(0.8) : expense.type == "Expense" ? .red.opacity(0.8) : .gray)
                    .frame(width: 70, height: 35)
                
                Text(expense.date, format: .dateTime.month(.abbreviated).day())
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.dateLabel)
            }
            .padding(.trailing, 5)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(expense.name)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                
                Text(expense.type)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
            }
            
            Spacer()
            
            Text(expense.value, format: .currency(code: "BRL"))
                .font(.system(size: 18, weight: .semibold, design: .rounded))
        }
        .padding(4)
    }
}

#Preview {
    ExpenseCell(expense: Expense(name: "Açaí da barra", date: .now, value: 16.90, type: "Expense", category: "Shopping", paymentType: "Cash", bankAccount: "Bradesco"))
        .previewLayout(.sizeThatFits)
}
