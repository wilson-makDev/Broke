//
//  AddExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-10.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var name : String = ""
    @State private var description : String = ""
    @State private var amount : Float = 0.00
    @State private var categoryName: String = CategoryViewModel.DEFAULT_CATEGORY_NAME
    @State private var newCategoryName: String = ""
    @State private var dateCreated = Date()
    @State private var categoryColor = Color(red: 0, green: 0, blue: 0)
    
    @ObservedObject var expenseVM: ExpenseViewModel
    
    private let currencyFormat = CurrencyFormater()
    
    var body: some View {
        NavigationView {
            VStack {
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
                            Picker("Category", selection: $categoryName) {
                                ForEach(expenseVM.categoryVM.getCategoryNames(), id: \.self) { item in
                                    Text(item)
                                }
                            }
                            .disabled(!newCategoryName.isEmpty)
                            
                            Divider().padding(.bottom)
                            HStack {
                                TextField(text: $newCategoryName) {
                                    Text("New Category")
                                }
                                ColorPicker(selection: $categoryColor, supportsOpacity: false) {
                                    Text("")
                                }.hidden()
                            }
                            Button("Add") {
                                expenseVM.categoryVM.addCategory(called: newCategoryName, color: CategoryViewModel.CategoryColor(color: categoryColor))
                                
                                categoryName = newCategoryName
                                newCategoryName = ""
                            }
                            .disabled(newCategoryName.isEmpty)
                        }
                        .buttonStyle(.borderless)
                    }
                    
                    Section("Date") {
                        DatePicker("Purchased On:", selection: $dateCreated, displayedComponents: [.date])
                    }
                    Button("Add Expense") {
                        let category = expenseVM.categoryVM.getCategoryByName(categoryName)
                        expenseVM.addExpense(name: name, details: description, category: category!, amount: amount, date: dateCreated)

                        resetInputs()
                    }.disabled(!validExpense())
                }
            }
            .navigationTitle("Add Expense")
        }
    }
    
    func validExpense() -> Bool {
        return !name.isEmpty && !description.isEmpty && !dateCreated.description.isEmpty
    }
    
    func resetInputs() {
        name = ""
        description = ""
        amount = 0.00
        categoryName = CategoryViewModel.DEFAULT_CATEGORY_NAME
        dateCreated = Date()
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(expenseVM: ExpenseViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
