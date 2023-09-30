//
//  CategoryViewModel.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-18.
//

import Foundation
import CoreData
import SwiftUI

class CategoryViewModel: ObservableObject {
    private let viewContext: NSManagedObjectContext
    
    private static var request = Category.fetchRequest()
    
    static let DEFAULT_CATEGORY_NAME = "None"
    static let DEFAULT_BACKGROUND_COLOR = Color("ExpenseColor").toHexString()
    static let DEFAULT_TEXT_COLOR = Color("ExpenseTextColor").toHexString()
    
    @Published var categoryOptionsArray: [Category] = []
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        Self.request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchCategoryData()
        
        if !self.hasCategoryWithName(Self.DEFAULT_CATEGORY_NAME) {
            self.addCategory(called: Self.DEFAULT_CATEGORY_NAME, backgroundColor: Self.DEFAULT_BACKGROUND_COLOR, textColor: Self.DEFAULT_TEXT_COLOR)
        }
    }
    
    func fetchCategoryData() {
        do {
            categoryOptionsArray = try viewContext.fetch(Self.request)
        } catch {
            print("CategoryViewModel fetching error: [\(error)]")
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("ExpenseViewModel saving error: [\(error)]")
        }
    }
    
    //Returned category cannot be modifed
    func getCategoryByName(_ name: String) -> Category? {
        return categoryOptionsArray.first { category in
            category.name == name
        }
    }
    
    private func hasCategoryWithName(_ name: String) -> Bool {
        categoryOptionsArray.contains(where: { category in category.name == name.capitalized })
    }
    
    func addCategory(called name: String, backgroundColor: String, textColor: String) {
        if !self.hasCategoryWithName(name) {
            let newCategory = Category(context: viewContext)
            newCategory.name = name.capitalized
            
            newCategory.backgroundColor = backgroundColor
            newCategory.textColor = textColor
            
            self.save()
            self.fetchCategoryData()
        }
    }
    
    func changeCategoryColour(name: String, backgroundColor: String, textColor: String) {
        if !self.hasCategoryWithName(name) {
            return
        }
        
        if let categoryToChange = categoryOptionsArray.first(where: { category in category.name == name.capitalized }) {
            categoryToChange.backgroundColor = backgroundColor
            categoryToChange.textColor = textColor
        }
        
        self.save()
        self.fetchCategoryData()
    }
    
    func getColorMapping() -> [String: Color] {
        return categoryOptionsArray.reduce(into: [String:Color]()) { partialResult, category in
            let safeCategory = CategoryFormData(category: category)
            partialResult[safeCategory.categoryName] = safeCategory.categoryBackgroundColor
        }
    }
}
