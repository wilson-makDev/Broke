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

    var body: some Scene {
        WindowGroup {
            ContentView(dateRangeVM: dateRangeVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(expenseVM)
        }
    }
}
