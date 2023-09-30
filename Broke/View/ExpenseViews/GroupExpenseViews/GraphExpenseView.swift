//
//  GraphExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-29.
//

import SwiftUI
import Charts

struct GraphExpenseView: View {
    @ObservedObject var expenseVM: ExpenseViewModel
    
    init(expenseVM: ExpenseViewModel) {
        self.expenseVM = expenseVM
    }
    
    var body: some View {
        Chart {
            ForEach(expenseVM.expenseArray) { expense in
                let safeExpense = ExpenseFormData(from: expense)
                BarMark(
                    x: .value("Date", safeExpense.dateCreated.formatted(date: .numeric, time: .omitted)),
                    y: .value("Spent", safeExpense.amount)
                )
                .foregroundStyle(safeExpense.category.categoryBackgroundColor)
            }
        }
        .chartYAxis {
            AxisMarks(format: Decimal.FormatStyle.Currency.currency(code: Locale.current.currency!.identifier))
        }
        .chartXScale(domain: .automatic(reversed: true))
        .animation(.default, value: expenseVM.expenseArray)
    }
}

#Preview {
    GraphExpenseView(expenseVM: ExpenseViewModel())
}
