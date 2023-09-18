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
    
    private static let defaultDateRange: (from: Date, to: Date) = (Calendar.current.date(byAdding: DateComponents(month: -1), to: Date())!,
                                                                   Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!)
    
    @StateObject var expenseVM = ExpenseViewModel(from: defaultDateRange.from, to: defaultDateRange.to)

    var body: some Scene {
        WindowGroup {
            ContentView(expenseVM: expenseVM, fromDate: Self.defaultDateRange.from, toDate: Self.defaultDateRange.to)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
