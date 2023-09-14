//
//  TotalExpnesesView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct TotalExpenesesView: View {
    @ObservedObject var expenseVM: ExpenseDateRangeViewModel
    
    var body: some View {
        HStack {
            Text("Total Expenses:")
            Spacer()
            Text(CurrencyFormater().numberFormatter.string(for: expenseVM.getTotalExpenses()) ?? "$0.00").foregroundColor(.init(red: 0, green: 0, blue: 0)).bold()
        }.font(.title).padding()
    }
}
struct TotalExpnesesView_Previews: PreviewProvider {
    static let expenseVM = ExpenseDateRangeViewModel()
    
    static var previews: some View {
        TotalExpenesesView(expenseVM: expenseVM)
    }
}
