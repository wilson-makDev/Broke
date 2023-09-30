//
//  SummaryExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-11.
//

import SwiftUI

struct SummaryExpenseView: View {
    @ObservedObject var expenseVM: ExpenseViewModel
    @State var selectedExpense: Expense? = nil
    
    var body: some View {
        VStack(alignment: .center) {
            TotalExpenesesView(expenseVM: expenseVM)
            
            Spacer()
            
            if expenseVM.expenseArray.isEmpty {
                Text("Wow no expenses here!").font(.title3)
                Spacer()
            } else {
                ListExpenseView(expenseVM: expenseVM)
                    .padding()
            }

            AddExpenseButtonView(expenseVM: expenseVM)
        }.animation(.default, value: expenseVM.expenseArray.isEmpty)
    }
}

struct SummaryExpenseView_Previews: PreviewProvider {
    static let expenseVM = ExpenseViewModel()
    
    static var previews: some View {
        SummaryExpenseView(expenseVM: expenseVM).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
