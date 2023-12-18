//
//  Expense.swift
//  Orggi
//
//  Created by Augusto Simionato on 14/11/23.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var date: Date
    var value: Double
    var type: String
    var category: String
    var paymentType: String
    var bankAccount: String
    
    init(name: String, date: Date, value: Double, type: String, category: String, paymentType: String, bankAccount: String) {
        self.name = name
        self.date = date
        self.value = value
        self.type = type
        self.category = category
        self.paymentType = paymentType
        self.bankAccount = bankAccount
    }
}
