//
//  SummaryExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-11.
//

import SwiftUI

struct SummaryExpenseView: View {
    @ObservedObject var expenseVM: ExpenseDateRangeViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Expenses").font(.title)
            Spacer(minLength: 200)
            TotalExpenesesView(expenseVM: expenseVM)
            AddExpenseButtonView(expenseVM: expenseVM)
            
            if expenseVM.expenseArray.isEmpty {
                Spacer()
                Text("Wow no expenses here!").font(.title3)
                Spacer()
            } else {
                ListExpenseView(expenseVM: expenseVM)
            }

        }
    }
}

struct SummaryExpenseView_Previews: PreviewProvider {
    static let expenseVM = ExpenseDateRangeViewModel()
    
    static var previews: some View {
        SummaryExpenseView(expenseVM: expenseVM).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
