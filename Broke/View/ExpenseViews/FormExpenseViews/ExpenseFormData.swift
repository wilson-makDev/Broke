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
    var name : String = ""
    var details : String = ""
    var amount : Float = 0.00
    var categoryName: String = CategoryViewModel.DEFAULT_CATEGORY_NAME
    var dateCreated = Date()
    var categoryColor = Color(red: 0, green: 0, blue: 0)
    
    init() {}
    
    init(from expense: Expense) {
        name = expense.name ?? name
        details = expense.details ?? details
        amount = expense.amount
        categoryName = expense.category?.name ?? categoryName
        dateCreated = expense.dateCreated ?? dateCreated
        categoryColor = Color(red: 0, green: 0, blue: 0)
    }
    
    func validExpense() -> Bool {
        return !name.isEmpty && !dateCreated.description.isEmpty
    }
    
    mutating func resetInputs() {
        name = ""
        details = ""
        amount = 0.00
        categoryName = CategoryViewModel.DEFAULT_CATEGORY_NAME
        dateCreated = Date()
    }
}
