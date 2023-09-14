//
//  ContentView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-08.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var expenseVM: ExpenseDateRangeViewModel

    var body: some View {
        NavigationView {
            VStack {
                SummaryExpenseView(expenseVM: expenseVM)
                DateRangePickerView(expenseVM: expenseVM, fromDate: expenseVM.dateRange.from, toDate: expenseVM.dateRange.to)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    private static var viewModel = ExpenseDateRangeViewModel()
    
    static var previews: some View {
        ContentView(expenseVM: viewModel)
    }
}
