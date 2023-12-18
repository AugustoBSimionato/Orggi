//
//  ExpenseUpdateSheet.swift
//  Orggi
//
//  Created by Augusto Simionato on 14/11/23.
//

import SwiftUI

struct ExpenseUpdateSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var expense: Expense
    
    let expenseCategories: [String] = [
        "Shopping", "Trip", "Car", "Grocery Store", "Health", "Pharmacy", "Pet"
    ]
    let expenseTypes: [String] = [
        "Expense", "Receive"
    ]
    let paymentTypes: [String] = [
        "Cash", "Credit Card", "Debit Card"
    ]
    let bankAccounts: [String] = [
        "Bradesco", "Itaú", "Inter", "Santander", "Nubank"
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic information") {
                    TextField("Description", text: $expense.name)
                    
                    DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                    
                    TextField("Value", value: $expense.value, format: .currency(code: "BRL"))
                        .keyboardType(.numberPad)
                        .scrollDismissesKeyboard(.automatic)
                    
                    Picker("Type", selection: $expense.type) {
                        ForEach(expenseTypes, id: \.self) { expenseType in
                            Text(expenseType).tag(expenseType)
                        }
                    }
                    
                    if expense.type == "Expense" {
                        Picker("Category", selection: $expense.category) {
                            ForEach(expenseCategories, id: \.self) { expenseCategory in
                                Text(expenseCategory).tag(expenseCategory)
                            }
                        }
                    }
                }
                
                Section("More information") {
                    Group {
                        if expense.type == "Expense" {
                            Picker("Payment Method", selection: $expense.paymentType) {
                                ForEach(paymentTypes, id: \.self) { paymentType in
                                    Text(paymentType).tag(paymentType)
                                }
                            }
                        }
                        
                        Picker("Bank Account", selection: $expense.bankAccount) {
                            ForEach(bankAccounts, id: \.self) { bankAccount in
                                Text(bankAccount).tag(bankAccount)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Update \(expense.type)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                    }
                }
            }
        }
    }
}

#Preview {
    ExpenseUpdateSheet(expense: Expense(name: "Chocolate", date: .now, value: 10.0, type: "Receive", category: "Shopping", paymentType: "Cash", bankAccount: "Bradesco"))
}
