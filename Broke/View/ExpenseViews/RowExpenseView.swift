//
//  RowExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-12.
//

import SwiftUI

struct RowExpenseView: View {
    @ObservedObject var expense: Expense
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
                Text(expense.category ?? "")
                Spacer()
                Text(expense.dateCreated?.formatted(date: .abbreviated, time: .omitted) ?? "")
            }
            
            if opened && !(expense.details ?? "").isEmpty {
                Divider()
                Text(expense.details!).padding(.vertical)
            }
        }
        .padding()
        .foregroundColor(.accentColor)
        .background(.yellow)
        .cornerRadius(10)
        .animation(.easeInOut, value: opened)
        .onTapGesture {
            opened.toggle()
        }
    }
}

struct RowExpenseView_Previews: PreviewProvider {
    
    static let context = PersistenceController.preview.container.viewContext
    static var expense = Expense.previewAll(context: context).first ?? Expense(context: context)
    
    static var previews: some View {
        RowExpenseView(expense: self.expense)
            .frame(maxWidth: 350, maxHeight: 100)
    }
}
