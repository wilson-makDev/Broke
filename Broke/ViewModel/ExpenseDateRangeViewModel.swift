//
//  ExpenseDateRangeViewModel.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-14.
//

import Foundation
import SwiftUI
import CoreData

class ExpenseDateRangeViewModel: ExpenseViewModel {
    private(set) var dateRange: (from: Date, to: Date) = (Calendar.current.date(byAdding: DateComponents(month: -1), to: Date())!,
                                                          Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!)
    
    override init() {
        super.init()
        self.updateFetchString()
        self.fetchExpenseData()
    }
    
    init(from: Date, to: Date) {
        self.dateRange = (from, to)
        super.init()
        self.updateFetchString()
        self.fetchExpenseData()
    }
    
    private func updateFetchString() {
        let fromDate = NSPredicate(format: "dateCreated >= %@", dateRange.from as NSDate)
        let toDate = NSPredicate(format: "dateCreated <= %@", dateRange.to as NSDate)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromDate, toDate])
        
        self.predicate = predicate
    }
    
    func changeDateRange(from: Date) {
        self.dateRange.from = from
        self.updateFetchString()
        self.fetchExpenseData()
    }
    
    func changeDateRange(to: Date) {
        self.dateRange.to = to
        self.updateFetchString()
        self.fetchExpenseData()
    }
    
    func changeDateRange(from: Date, to: Date) {
        self.dateRange = (from, to)
        self.updateFetchString()
        self.fetchExpenseData()
    }
    
    func getTotalExpenses() -> Float {
        return self.expenseArray.reduce(0) { partialResult, expense in
            partialResult + expense.amount
        }
    }
    
}
