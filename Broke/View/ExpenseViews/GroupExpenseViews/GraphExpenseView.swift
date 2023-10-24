//
//  GraphExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-29.
//

import SwiftUI
import Charts

struct GraphExpenseView: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel
    
    var body: some View {
        Chart {
            ForEach(expenseVM.expenseArray.sorted(by: { lhsExp, rhsExp in
                let safeLhs = ExpenseFormData(from: lhsExp)
                let safeRhs = ExpenseFormData(from: rhsExp)
                
                if safeLhs.dateCreated == safeRhs.dateCreated {
                    return safeLhs.category.categoryName < safeRhs.category.categoryName
                }
                
                return safeLhs.dateCreated > safeRhs.dateCreated
            })) { expense in
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
    GraphExpenseView().environmentObject(ExpenseViewModel())
}
