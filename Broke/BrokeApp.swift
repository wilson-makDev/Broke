 //
//  BrokeApp.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-08.
//

import SwiftUI

@main
struct BrokeApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var expenseVM = ExpenseViewModel()
    @StateObject var dateRangeVM = DateRangeViewModel()
    
    init() {
        
        //TODO: Do not call StateObject before views are loaded 
        expenseVM.changeDateRange(dateRangeVM.dateRange.from, dateRangeVM.dateRange.to)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(expenseVM: expenseVM, dateRangeVM: dateRangeVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
