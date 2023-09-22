//
//  Persistence.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-08.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
//        let utilitiesCategory = Category(context: viewContext)
//        utilitiesCategory.name = "Utilities"
//        utilitiesCategory.r = 0
//        utilitiesCategory.g = 0
//        utilitiesCategory.b = 0
//        
//        let groceriesCategory = Category(context: viewContext)
//        groceriesCategory.name = "Groceries"
//        groceriesCategory.r = 0
//        groceriesCategory.g = 0
//        groceriesCategory.b = 0
//        
//        let newExpense = Expense(context: viewContext)
//        newExpense.name = "Cheese"
//        newExpense.details = "I wanted cheese"
//        newExpense.category = groceriesCategory
//        newExpense.dateCreated = Calendar.current.date(byAdding: DateComponents(day: -2), to: Date())!
//        newExpense.amount = 3.00
//        
//        let newExpense2 = Expense(context: viewContext)
//        newExpense2.name = "Water"
//        newExpense2.details = ""
//        newExpense2.category = utilitiesCategory
//        newExpense2.dateCreated = Calendar.current.date(byAdding: DateComponents(day: -5), to: Date())!
//        newExpense2.amount = 310.00
        
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Broke")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
