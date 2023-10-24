//
//  TotalExpnesesView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct TotalExpenesesView: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel
    
    var body: some View {
        HStack {
            Text("Total Expenses:")
            Spacer()
            Text(expenseVM.getTotalCostString()).foregroundColor(Color("ExpenseTotalTextColor")).bold()
        }.font(.title).padding()
    }
}
struct TotalExpnesesView_Previews: PreviewProvider {
    static var previews: some View {
        TotalExpenesesView().environmentObject(ExpenseViewModel())
    }
}
