//
//  AddExpenseButtonView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct AddExpenseButtonView: View {
    
    @ObservedObject var expenseVM: ExpenseViewModel
    
    var body: some View {
        NavigationLink {
            FormExpenseView(expenseVM: expenseVM)
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
                .frame(minWidth: 200)
        }
        .padding()
        .foregroundColor(Color("ExpenseTextColor"))
        .background(Color("ExpenseColor"))
        .cornerRadius(5)
    }
}

struct AddExpenseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseButtonView(expenseVM: ExpenseViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
