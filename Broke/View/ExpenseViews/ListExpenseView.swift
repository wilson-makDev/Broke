//
//  ExpenseListView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct ListExpenseView: View {
    @ObservedObject var expenseVM: ExpenseDateRangeViewModel
    
    var body: some View {
        List(expenseVM.expenseArray) { expense in
            RowExpenseView(expense: expense)
                .listRowSeparator(.hidden) //Not getting new data here
        }
        .listStyle(.inset)
        .animation(.easeIn, value: expenseVM.expenseArray.count)
    }
}

struct ListExpenseView_Previews: PreviewProvider {
    static let expenseVM = ExpenseDateRangeViewModel()
    
    static var previews: some View {
        ListExpenseView(expenseVM: expenseVM).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
