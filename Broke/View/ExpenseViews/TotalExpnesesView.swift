//
//  TotalExpnesesView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct TotalExpenesesView: View {
    @ObservedObject var expenseVM: ExpenseViewModel
    
    var body: some View {
        HStack {
            Text("Total Expenses:")
            Spacer()
            Text(expenseVM.getTotalCostString()).foregroundColor(Color("ExpenseTotalTextColor")).bold()
        }.font(.title).padding()
    }
}
struct TotalExpnesesView_Previews: PreviewProvider {
    static let expenseVM = ExpenseViewModel()
    
    static var previews: some View {
        TotalExpenesesView(expenseVM: expenseVM)
    }
}
