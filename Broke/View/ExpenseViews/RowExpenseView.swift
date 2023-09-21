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
    
    var body: some View {
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
        .foregroundColor(.white)
        .padding()
        .background(CategoryViewModel.CategoryColor.getSwiftColor(of: expense.category!))
        .animation(.easeInOut, value: opened)
        .onTapGesture {
            opened.toggle()
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
    
    static let context = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        RowExpenseView(expense: ExpenseViewModel().expenseArray.first!)
            .frame(maxWidth: 350, maxHeight: 100)
    }
}
