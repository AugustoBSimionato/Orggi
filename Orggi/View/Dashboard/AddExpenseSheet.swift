//
//  AddExpenseSheet.swift
//  Orggi
//
//  Created by Augusto Simionato on 14/11/23.
//

import SwiftUI

struct AddExpenseSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    @State private var expenseCategory: String = "Shopping"
    @State private var paymentType: String = "Cash"
    @State private var expenseType: String = "Expense"
    @State private var bankAccount: String = "Bradesco"
    @State private var showAlert = false
    
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
            VStack {
                Form {
                    Section("Basic information") {
                        TextField("Description", text: $name)
                        
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                        
                        TextField("Value", value: $value, format: .currency(code: "BRL"))
                            .keyboardType(.numberPad)
                            .scrollDismissesKeyboard(.immediately)
                        
                        Picker("Type", selection: $expenseType) {
                            ForEach(expenseTypes, id: \.self) { expenseType in
                                Text(expenseType).tag(expenseType)
                            }
                        }
                        
                        if expenseType == "Expense" {
                            Picker("Category", selection: $expenseCategory) {
                                ForEach(expenseCategories, id: \.self) { expenseCategory in
                                    Text(expenseCategory).tag(expenseCategory)
                                }
                            }
                        }
                    }
                    
                    Section("More information") {
                        Group {
                            if expenseType == "Expense" {
                                Picker("Payment Method", selection: $paymentType) {
                                    ForEach(paymentTypes, id: \.self) { paymentType in
                                        Text(paymentType).tag(paymentType)
                                    }
                                }
                            }
                            
                            Picker("Bank Account", selection: $bankAccount) {
                                ForEach(bankAccounts, id: \.self) { bankAccount in
                                    Text(bankAccount).tag(bankAccount)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("New \(expenseType)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        if isInputValid() {
                            let expense = Expense(name: name, date: date, value: value, type: expenseType, category: expenseCategory, paymentType: paymentType, bankAccount: bankAccount)
                            context.insert(expense)
                            let impactMed = UIImpactFeedbackGenerator(style: .soft)
                            impactMed.impactOccurred()
                            dismiss()
                        } else {
                            showAlert = true
                        }
                    } label: {
                        Text("Add")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("✋"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func isInputValid() -> Bool {
        return !name.isEmpty && value != 0
    }
}

#Preview {
    AddExpenseSheet()
}
