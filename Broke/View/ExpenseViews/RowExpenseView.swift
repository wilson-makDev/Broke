//
//  RowExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-12.
//

import SwiftUI

struct RowExpenseView: View {
    var expense: Expense
    @State private var opened = false
    @State private var isActive = false
    
    @EnvironmentObject var expenseVM: ExpenseViewModel
    
    var body: some View {
        NavigationLink {
            FormExpenseView(edit: expense)
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Text(expense.name ?? "").font(.headline)
                    Spacer()
                    Text(CurrencyFormater().numberFormatter.string(for: expense.amount) ?? "$0.00").font(.title)
                }
                
                Spacer()
                
                HStack {
                    Text(showCategoryLabel(name: expense.category?.name))
                    Spacer()
                    Text(expense.dateCreated?.formatted(date: .abbreviated, time: .omitted) ?? "")
                }
                
                if opened && !(expense.details ?? "").isEmpty {
                    Divider()
                    Text(expense.details!).padding(.vertical)
                }
            }
        }
        .foregroundColor(getCategoryColor(categoryColorHex: expense.category?.textColor, defaultColor: "ExpenseTextColor"))
        .padding()
        .background(getCategoryColor(categoryColorHex: expense.category?.backgroundColor, defaultColor: "ExpenseColor"))
        .animation(.easeInOut, value: opened)
    }
    
    private func getCategoryColor(categoryColorHex: String?, defaultColor: String) -> Color {
        if let safeCategoryHex = categoryColorHex {
            return Color(hex: safeCategoryHex)
        } else {
            return Color(defaultColor)
        }
    }
    
    private func showCategoryLabel(name: String?) -> String {
        if let safeName = name {
            return CategoryViewModel.DEFAULT_CATEGORY_NAME == safeName ? "" : safeName
        } else {
            return ""
        }
    }
}

struct RowExpenseView_Previews: PreviewProvider {
    
    static var expenseVM = ExpenseViewModel()
    
    static var previews: some View {
        RowExpenseView(expense: expenseVM.expenseArray.first!)
            .frame(maxWidth: 350, maxHeight: 100)
            .environmentObject(expenseVM)
    }
}
