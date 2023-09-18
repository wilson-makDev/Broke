//
//  CategoryViewModel.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-18.
//

import Foundation
import CoreData

class CategoryViewModel: ObservableObject {
    private static let viewContext = PersistenceController.preview.container.viewContext
    
    private static var request = NSFetchRequest<Category>(entityName: "Category")
    
    @Published var categoryOptionsArray: [Category] = []
    
    init() {
        Self.request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchCategoryData()
    }
    
    func fetchCategoryData() {
        do {
            categoryOptionsArray = try Self.viewContext.fetch(Self.request)
        } catch {
            print("CategoryViewModel fetching error: [\(error)]")
        }
    }
    
    func save() {
        do {
            try Self.viewContext.save()
        } catch {
            print("ExpenseViewModel saving error: [\(error)]")
        }
    }
    
    func addCategory(name: String, color: CategoryColor) {
        var newCategory = Category(context: Self.viewContext)
        newCategory.name = name
        (newCategory.r, newCategory.g, newCategory.b) = color.getInt16ColorTuple()
        
        self.save()
        self.fetchCategoryData()
    }
    
    struct CategoryColor {
        var r: UInt8 = 0
        var g: UInt8 = 0
        var b: UInt8 = 0
        
        func getColorTuple() -> (r: UInt8, g: UInt8, b: UInt8) {
            (r, g, b)
        }
        
        func getInt16ColorTuple() -> (Int16, Int16, Int16) {
            (Int16(r), Int16(g), Int16(b))
        }
    }
}
