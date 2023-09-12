//
//  AddExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-10.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var categories = ["Bills", "Alcohol"]
    
    @State private var name : String = ""
    @State private var description : String = ""
    @State private var amount : Float = 0.00
    @State private var category: String = ""
    @State private var newCategory: String = ""
    @State private var dateCreated = Date()
    
    private let currencyFormat = CurrencyFormater()
    
    @Environment(\.managedObjectContext) var context
    
    init() {
        category = categories.first!
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add Expense")
                Form {
                    Section("Name") {
                        TextField(text: $name) {
                            Text("Required")
                        }
                    }
                    Section("Description") {
                        TextEditor(text: $description)
                    }
                    Section("Amount") {
                        TextField("$0.00", value: $amount, formatter: currencyFormat.numberFormatter)
                            .keyboardType(.numberPad)
                    }
                    Section("Category") {
                        VStack {
                            Picker("Category", selection: $category) {
                                ForEach(categories, id: \.self) { item in
                                    Text(item)
                                }
                            }
                            .disabled(!newCategory.isEmpty)
                            
                            Divider()
                            TextField(text: $newCategory) {
                                Text("New Category")
                            }
                            Button("Add") {
                                if !newCategory.isEmpty {
                                    categories.append(newCategory)
                                    category = newCategory
                                    newCategory = ""
                                }
                            }
                        }
                        .buttonStyle(.borderless)
                    }
                    Section("Date") {
                        DatePicker("Purchased On:", selection: $dateCreated, displayedComponents: [.date])
                    }
                    Button("Add Expense") {
                        let expense = Expense(context: context)
                        expense.name = name
                        expense.details = description
                        expense.category = category
                        expense.amount = amount
                        expense.dateCreated = Date()
                        
                        try? context.save()
                        
                        resetInputs()
                    }.disabled(!validExpense())
                }
            }
        }
    }
    
    func validExpense() -> Bool {
        return !name.isEmpty && !description.isEmpty && !dateCreated.description.isEmpty
    }
    
    func resetInputs() {
        name = ""
        description = ""
        amount = 0.00
        category = ""
        dateCreated = Date()
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
