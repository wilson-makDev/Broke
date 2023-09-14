//
//  ExpenseViewModel.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-14.
//

import Foundation
import CoreData

class ExpenseViewModel: ObservableObject {
    private let viewContent = PersistenceController.preview.container.viewContext
    var predicate: NSPredicate?
    var sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(key: "dateCreated", ascending: false)]
    
    @Published var expenseArray: [Expense] = []
    
    init() {
        fetchExpenseData()
    }
    
    func fetchExpenseData() {
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        
        if predicate != nil {
            request.predicate = self.predicate
        }
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
        
        self.save()
        self.fetchExpenseData()
    }
}
