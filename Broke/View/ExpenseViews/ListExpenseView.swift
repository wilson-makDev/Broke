//
//  ExpenseListView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct ListExpenseView: View {
    var expenses: [Expense]
    
    var body: some View {
        ScrollView {
            ForEach(expenses) { expense in
                RowExpenseView(expense: expense)
            }
        }
        .animation(.easeIn, value: expenses.count)
        .scrollIndicators(.visible)
    }
}

struct ListExpenseView_Previews: PreviewProvider {
    static let expenseVM = ExpenseDateRangeViewModel()
    
    static var previews: some View {
        ListExpenseView(expenses: expenseVM.expenseArray).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
