//
//  ExpenseViewModel.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-14.
//

import Foundation
import CoreData

class ExpenseViewModel: ObservableObject {
    private let viewContent = PersistenceController.shared.container.viewContext
    private var predicate: NSPredicate = NSPredicate()
    private var sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor()]
    
    @Published var expenseArray: [Expense] = []
    
    init() {
        fetchExpenseData()
    }
    
    func modifyFetch(predicate: NSPredicate, sortDescriptor: [NSSortDescriptor]) {
        self.predicate = predicate
        self.sortDescriptors = sortDescriptor
    }
    
    func fetchExpenseData() {
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        request.predicate = self.predicate
        request.sortDescriptors = self.sortDescriptors
        
        do {
            expenseArray = try viewContent.fetch(request)
        } catch {
            print("ExpenseViewModel fetching error: [\(error)]")
        }
    }
    
    func save() {
        do {
            try viewContent.save()
        } catch {
            print("ExpenseViewModel saving error: [\(error)]")
        }
    }
    
    func addExpesnse(name: String, details: String, category: String, amount: Float) {
        let expense = Expense(context: viewContent)
        expense.dateCreated = Date()
        expense.name = name
        expense.details = details
        expense.category = category
        expense.amount = amount
        
        save()
        self.fetchExpenseData()
    }
}
