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
    private static let viewContext = PersistenceController.preview.container.viewContext //TODO:Change to proper container
    
    private static var request = Category.fetchRequest()
    
    static let DEFAULT_CATEGORY_NAME = "None"
    
    @Published var categoryOptionsArray: [Category] = []
    
    init() {
        Self.request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchCategoryData()
        
        if !self.hasCategoryWithName(Self.DEFAULT_CATEGORY_NAME) {
            self.addCategory(called: Self.DEFAULT_CATEGORY_NAME, color: CategoryColor(color: .black))
        }
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
    
    func getCategoryNames() -> [String] {
        return categoryOptionsArray.map { category in
            if let safeName = category.name {
                return safeName
            } else {
                return "Unavailable"
            }
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
    
    func addCategory(called name: String, color: CategoryColor) {
        if !self.hasCategoryWithName(name) {
            let newCategory = Category(context: Self.viewContext)
            newCategory.name = name.capitalized
            
            (newCategory.r, newCategory.g, newCategory.b) = color.getInt16ColorTuple()
            
            self.save()
            self.fetchCategoryData()
        }
    }
    
    func changeCategoryColour(name: String, color: CategoryColor) -> Bool {
        if !self.hasCategoryWithName(name) {
            return false
        }
        
        if let categoryToChange = categoryOptionsArray.first(where: { category in category.name == name.lowercased() }) {
            (categoryToChange.r, categoryToChange.g, categoryToChange.b) = color.getInt16ColorTuple()
        }
        
        self.save()
        self.fetchCategoryData()
        
        return true
    }
    
    struct CategoryColor {
        var r: UInt8 = 0
        var g: UInt8 = 0
        var b: UInt8 = 0
        
        init(color: Color) {
            r = UInt8(color.cgColor!.components![0])
            g = UInt8(color.cgColor!.components![1])
            b = UInt8(color.cgColor!.components![2])
        }
        
        func getColorTuple() -> (r: UInt8, g: UInt8, b: UInt8) {
            (r, g, b)
        }
        
        static func getSwiftColor(of category: Category) -> Color {
            Color(red: Double(category.r), green: Double(category.g), blue: Double(category.b))
        }
        
        func getInt16ColorTuple() -> (Int16, Int16, Int16) {
            (Int16(r), Int16(g), Int16(b))
        }
    }
}
