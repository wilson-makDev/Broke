//
//  CategoryPickerView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-25.
//

import SwiftUI

struct CategoryPickerView: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel
    @State var newCategoryName = ""
    @State var showAddCategoryPrompt = false
    @Binding var categoryData: CategoryFormData
    
    var body: some View {
        VStack {
            HStack {
                if showAddCategoryPrompt {
                    TextField("Name", text: $newCategoryName)
                    Spacer()
                    Button("Add") {
                        expenseVM.categoryVM.addCategory(
                            called: newCategoryName,
                            backgroundColor: CategoryViewModel.DEFAULT_BACKGROUND_COLOR,
                            textColor: CategoryViewModel.DEFAULT_TEXT_COLOR
                        )

                        if let safeCategory = expenseVM.categoryVM.getCategoryByName(newCategoryName) {
                            categoryData = CategoryFormData(category: safeCategory)
                        }
                        newCategoryName = ""
                        
                        showAddCategoryPrompt.toggle()
                    }
                    .disabled(newCategoryName.isEmpty)
                    Button("Cancel") {
                        showAddCategoryPrompt.toggle()
                    }
                } else {
                    VStack {
                        Menu(categoryData.categoryName) {
                            Picker("Category", selection: $categoryData) {
                                ForEach(expenseVM.categoryVM.categoryOptionsArray) { item in
                                    if let safeName = item.name {
                                        Text(safeName).tag(CategoryFormData(category: item))
                                    }
                                }
                            }.menuOrder(.priority)
                            
                            Button(action: {
                                showAddCategoryPrompt.toggle()
                            }, label: {
                                Text("New Category")
                            })

                        }
                    }
                    
                    Spacer()
                    
                    if categoryData.categoryName != CategoryViewModel.DEFAULT_CATEGORY_NAME {
                        VStack {
                            ColorPicker(selection: $categoryData.categoryBackgroundColor, supportsOpacity: false) {
                                Text("Background:")
                            }
                            ColorPicker(selection: $categoryData.categoryTextColor, supportsOpacity: false) {
                                Text("Text:")
                            }
                        }
                        .frame(maxWidth: 150)
                    }
                }
            }
        }.buttonStyle(.borderless)
    }
}

#Preview {
    @State var categoryData = CategoryFormData()
    return CategoryPickerView(categoryData: $categoryData).environmentObject(ExpenseViewModel())
}
