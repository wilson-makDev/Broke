//
//  ExpenseViewModel.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-14.
//

import Foundation
import CoreData

class ExpenseViewModel: ObservableObject {
    private static let viewContent = PersistenceController.preview.container.viewContext //TODO:Change to proper container
    private static var request = Expense.fetchRequest()
    
    var categoryVM = CategoryViewModel()
    
    @Published private(set) var expenseArray: [Expense] = []
    
    init() {
        Self.request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        fetchExpenseData()
    }
    
    func fetchExpenseData() {
        do {
            expenseArray = try Self.viewContent.fetch(Self.request)
        } catch {
            print("ExpenseViewModel fetching error: [\(error)]")
        }
    }
    
    func save() {
        do {
            try Self.viewContent.save()
        } catch {
            print("ExpenseViewModel saving error: [\(error)]")
        }
    }
    
    func addExpense(name: String, details: String, category: Category, amount: Float, date: Date) {
        let expense = Expense(context: Self.viewContent)
        expense.dateCreated = date
        expense.name = name
        expense.details = details
        expense.category = category
        expense.amount = amount
        
        self.save()
        self.fetchExpenseData()
    }
    
    func deleteExpense(_ expense: Expense) {
        Self.viewContent.delete(expense)
        self.save()
        self.fetchExpenseData()
    }
    
    func getTotalCostString() -> String {
        let sumAsFloat = self.expenseArray.reduce(0) { partialResult, expense in
            partialResult + expense.amount
        }
        
        return CurrencyFormater().numberFormatter.string(for: sumAsFloat) ?? "$NIL"
    }
}

extension ExpenseViewModel {
    convenience init(from: Date, to: Date) {
        Self.request.predicate = Self.updateDateFetchString(from, to)
        self.init()
    }
    
    private static func updateDateFetchString(_ from: Date, _ to: Date) -> NSPredicate {
        let fromDate = NSPredicate(format: "dateCreated >= %@", from as NSDate)
        let toDate = NSPredicate(format: "dateCreated <= %@", to as NSDate)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromDate, toDate])
        
        return predicate
    }
    
    func changeDateRange(_ from: Date, _ to: Date) {
        Self.request.predicate = Self.updateDateFetchString(from, to)
        self.fetchExpenseData()
    }
}
