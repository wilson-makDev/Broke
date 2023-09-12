//
//  SummaryExpenseView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-11.
//

import SwiftUI

struct SummaryExpenseView: View {
    @Environment(\.managedObjectContext) var context
    
    @State private var endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!
    @State private var startDate = Calendar.current.date(byAdding: DateComponents(month: -1), to: Date())!
    
    
    var body: some View {
        
        let expenses = Expense.withinDateRange(startDate: startDate, endDate: endDate, context: context)
        
        let totalExpensesAmount = expenses.reduce(0) { partialResult, expense in
            partialResult + expense.amount
        }
        
        if expenses.isEmpty {
            Text("No Expenses")
        } else {
            VStack {
                HStack {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                    Spacer()
                    DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                }
                .padding(.horizontal)
                .datePickerStyle(.compact)

                HStack {
                    Text("Total Expenses:")
                    Spacer()
                    Text(CurrencyFormater().numberFormatter.string(for: totalExpensesAmount) ?? "$0.00").foregroundColor(.init(red: 0, green: 0, blue: 0)).bold()
                }.font(.title).padding()
                
                List(expenses) { expense in
                    RowExpenseView(expense: expense).listRowSeparator(.hidden)
                }
                .listStyle(.inset)
            }
        }

    }
}

struct SummaryExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryExpenseView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
