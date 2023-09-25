//
//  AddExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-10.
//

import SwiftUI

struct FormExpenseView: View {    
    @State private var newCategoryName: String = ""
    @State private var expenseData: ExpenseFormData = ExpenseFormData()
    @ObservedObject var expenseVM: ExpenseViewModel
    
    @Environment(\.presentationMode) var presentation
    
    private var role: ExpenseFormRole
    private let currencyFormat = CurrencyFormater()
    
    init(expenseVM: ExpenseViewModel) {
        self.expenseVM = expenseVM
        role = .add
    }
    
    init(edit expense: Expense, expenseVM: ExpenseViewModel) {
        self.init(expenseVM: expenseVM)
        expenseData = ExpenseFormData(from: expense)
        role = .edit(orignal: expense)
    }
    
    var body: some View {

        VStack {
            Form(content: {
                Section("Name") {
                    TextField(text: $expenseData.name) {
                        Text("Required")
                    }
                }
                Section("Description") {
                    TextEditor(text: $expenseData.details)
                }
                Section("Amount") {
                    TextField("$0.00", value: $expenseData.amount, formatter: currencyFormat.numberFormatter)
                        .keyboardType(.numberPad)
                }
                Section("Category") {
                    VStack {
                        Picker("Category", selection: $expenseData.category) {
                            ForEach(expenseVM.categoryVM.categoryOptionsArray) { item in
                                if let safeName = item.name {
                                    Text(safeName).tag(CategoryFormData(category: item))
                                }
                                
                            }
                        }
                        .disabled(!newCategoryName.isEmpty)
                        
                        Divider().padding()
                        
                        HStack {
                            ColorPicker(selection: $expenseData.category.categoryBackgroundColor, supportsOpacity: false) {
                                Text("Background")
                            }
                            ColorPicker(selection: $expenseData.category.categoryTextColor, supportsOpacity: false) {
                                Text("Text")
                            }
                        }
                        
                        Divider().padding()
                        
                        TextField(text: $newCategoryName) {
                            Text("New Category")
                        }
      
                        Button("Add") {
                            expenseVM.categoryVM.addCategory(
                                called: newCategoryName,
                                backgroundColor: expenseData.category.categoryBackgroundColor.toHexString(),
                                textColor: expenseData.category.categoryTextColor.toHexString()
                            )
                            
                            expenseData.category.categoryName = newCategoryName
                            newCategoryName = ""
                        }
                        .disabled(newCategoryName.isEmpty)
                    }
                    .buttonStyle(.borderless)
                }
                
                Section("Date") {
                    DatePicker("Purchased On:", selection: $expenseData.dateCreated, displayedComponents: [.date])
                }

                Button(role.getButtonText()) {
                    if let category = expenseVM.categoryVM.getCategoryByName(expenseData.category.categoryName) {
                        switch role {
                        case .add:
                            expenseVM.addExpense(name: expenseData.name, details: expenseData.details, category: category, amount: expenseData.amount, date: expenseData.dateCreated)
                        case .edit(let orignal):
                            expenseVM.updateExpense(orignalExpense: orignal, name: expenseData.name, details: expenseData.details, category: category, amount: expenseData.amount, date: expenseData.dateCreated)
                        }

                        expenseData.resetInputs()
                        self.presentation.wrappedValue.dismiss()
                    } else {
                        print("FormExpenseView cannot add/edit, category not found")
                    }
                }.disabled(!expenseData.validExpense())
            })
        }
        .navigationTitle(role.getTitle())
    }
}

struct FormExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        FormExpenseView(expenseVM: ExpenseViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
