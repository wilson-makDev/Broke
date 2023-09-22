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
    var fromDate: Date
    var toDate: Date

    var body: some View {
        NavigationStack {
            VStack {
                SummaryExpenseView(expenseVM: expenseVM)
                DateRangePickerView(expenseVM: expenseVM, fromDate: fromDate, toDate: toDate)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    private static var viewModel = ExpenseViewModel()
    private static let dateRange: (from: Date, to: Date) = (Calendar.current.date(byAdding: DateComponents(month: -1), to: Date())!,
                                                                   Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!)
    
    static var previews: some View {
        ContentView(expenseVM: viewModel, fromDate: dateRange.from, toDate: dateRange.to).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
