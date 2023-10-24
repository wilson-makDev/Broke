//
//  SummaryExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-11.
//

import SwiftUI

struct SummaryExpenseView: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel
    @State var selectedExpense: Expense? = nil
    
    var body: some View {
        VStack(alignment: .center) {
            TotalExpenesesView()
            
            Spacer()
            
            if expenseVM.expenseArray.isEmpty {
                Text("Wow no expenses here!").font(.title3)
                Spacer()
            } else {
                ListExpenseView()
                    .padding()
            }

            AddExpenseButtonView()
        }.animation(.default, value: expenseVM.expenseArray.isEmpty)
    }
}

struct SummaryExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryExpenseView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ExpenseViewModel())
    }
}
