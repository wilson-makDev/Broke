//
//  CategoryFormData.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-25.
//

import Foundation
import SwiftUI

struct CategoryFormData: Hashable {
    var categoryName = CategoryViewModel.DEFAULT_CATEGORY_NAME
    var categoryBackgroundColor = Color("ExpenseColor")
    var categoryTextColor = Color("ExpenseTextColor")
    
    init () {}
    
    init(category: Category?) {
        self.categoryName = category?.name ?? CategoryViewModel.DEFAULT_CATEGORY_NAME
        
        if let safeBackgroundColor = category?.backgroundColor {
            self.categoryBackgroundColor = Color(hex: safeBackgroundColor)
        }
        
        if let safeTextColor = category?.textColor {
            self.categoryTextColor = Color(hex: safeTextColor)
        }
    }
    
    mutating func resetInputs() {
        categoryName = CategoryViewModel.DEFAULT_CATEGORY_NAME
        categoryBackgroundColor = Color("ExpenseColor")
        categoryTextColor = Color("ExpenseTextColor")
    }
}
