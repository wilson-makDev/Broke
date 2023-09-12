//
//  Expense.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-11.
//

import Foundation
import CoreData

extension Expense {
    static func withName(_ name: String, context: NSManagedObjectContext) -> [Expense] {
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        request.predicate = NSPredicate(format: "name = %@", name)
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        
        let expenses: [Expense]
        
        do {
            expenses = try context.fetch(request)
            print("Data fetched")
        } catch {
            print("Fetch error: \(error)")
            expenses = []
        }
        
        return expenses
    }
    
    static func withinDateRange(startDate: Date, endDate: Date, context: NSManagedObjectContext) -> [Expense] {
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        let fromDate = NSPredicate(format: "dateCreated >= %@", startDate as NSDate)
        let toDate = NSPredicate(format: "dateCreated <= %@", endDate as NSDate)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromDate, toDate])
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        
        let expenses: [Expense]
        
        do {
            expenses = try context.fetch(request)
            print("Data fetched")
        } catch {
            print("Fetch error: \(error)")
            expenses = []
        }
        
        return expenses
    }
    
    static func previewAll(context: NSManagedObjectContext) -> [Expense] {
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        
        let expenses: [Expense]
        
        do {
            expenses = try context.fetch(request)
            print("Data fetched")
        } catch {
            print("Fetch error: \(error)")
            expenses = []
        }
        
        return expenses
    }
}
