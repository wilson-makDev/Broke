//
//  ExpenseListView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct ListExpenseView: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("Recent").font(.subheadline)
            List {
                ForEach(expenseVM.expenseArray) { expense in
                    RowExpenseView(expense: expense)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                expenseVM.deleteExpense(expense)
                            } label: {
                                Text("Delete")
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                        .cornerRadius(5)
                }
            }
            .listStyle(.plain)
            .animation(.default, value: expenseVM.expenseArray)
            .scrollIndicators(.visible)
        }
        .padding(.horizontal, 1)
    }
}

struct ListExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ListExpenseView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ExpenseViewModel())
    }
}
