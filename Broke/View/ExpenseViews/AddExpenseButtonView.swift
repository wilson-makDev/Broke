//
//  AddExpenseButtonView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct AddExpenseButtonView: View {
    
    @ObservedObject var expenseVM: ExpenseDateRangeViewModel
    
    var body: some View {
        NavigationLink {
            AddExpenseView(expenseVM: expenseVM)
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
                .frame(minWidth: 200)
        }
        .padding()
        .foregroundColor(.accentColor)
        .background(.yellow)
        .cornerRadius(10)
    }
}

struct AddExpenseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseButtonView(expenseVM: ExpenseDateRangeViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
