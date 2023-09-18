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
            Text(expenseVM.getTotalCostString()).foregroundColor(.init(red: 0, green: 0, blue: 0)).bold()
        }.font(.title).padding()
    }
}
struct TotalExpnesesView_Previews: PreviewProvider {
    static let expenseVM = ExpenseViewModel()
    
    static var previews: some View {
        TotalExpenesesView(expenseVM: expenseVM)
    }
}
