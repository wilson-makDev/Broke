//
//  ExpenseFormData.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-22.
//

import Foundation
import SwiftUI

enum ExpenseFormRole {
    case add
    case edit(orignal: Expense)
    
    func getTitle() -> String {
        switch self {
        case .add:
            return "Add Expense"
        case .edit:
            return "Edit Expense"
        }
    }
    
    func getButtonText() -> String {
        switch self {
        case .add:
            return "Add Expense"
        case .edit:
            return "Save Changes"
        }
    }
}

struct ExpenseFormData {
    var name = ""
    var details = ""
    var amount : Float = 0.00
    var dateCreated = Date()
    var category = CategoryFormData()
    
    init() {}
    
    init(from expense: Expense) {
        name = expense.name ?? name
        details = expense.details ?? details
        amount = expense.amount
        dateCreated = expense.dateCreated ?? dateCreated
        category = CategoryFormData(category: expense.category)
    }
    
    func validExpense() -> Bool {
        return !name.isEmpty && !dateCreated.description.isEmpty
    }
    
    mutating func resetInputs() {
        name = ""
        details = ""
        amount = 0.00
        dateCreated = Date()
        category.resetInputs()
    }
}
