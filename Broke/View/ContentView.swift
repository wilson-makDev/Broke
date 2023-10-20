//
//  ContentView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-08.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var expenseVM: ExpenseViewModel
    @ObservedObject var dateRangeVM: DateRangeViewModel

    var body: some View {
        NavigationStack {
            VStack {
                GraphExpenseView(expenseVM: expenseVM).frame(height: 150).padding()
                SummaryExpenseView(expenseVM: expenseVM)
                DateRangePickerView(expenseVM: expenseVM, dateRangeVM: dateRangeVM)
            }
        }
        .background(Color("Background"))
        .onAppear(perform: {
            expenseVM.changeDateRange(dateRangeVM.dateRange.from, dateRangeVM.dateRange.to)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    private static var expenseVM = ExpenseViewModel()
    private static var dateRangeVM = DateRangeViewModel()
    
    static var previews: some View {
        ContentView(expenseVM: expenseVM, dateRangeVM: dateRangeVM).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
