//
//  DateRangePickerView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct DateRangePickerView: View {
    @ObservedObject var expenseVM: ExpenseViewModel
    @State var fromDate : Date
    @State var toDate : Date
    
    var body: some View {
        VStack {
            Text("Date Range").font(.headline)
            HStack {
                DatePicker("From:", selection: $fromDate , displayedComponents: [.date])
                    .onChange(of: fromDate) { newFromDate in
                        expenseVM.changeDateRange(newFromDate, toDate)
                    }
                DatePicker("To:", selection: $toDate, displayedComponents: [.date])
                    .onChange(of: toDate) { newToDate in
                        expenseVM.changeDateRange(fromDate, newToDate)
                    }
            }
        }
        .padding()
        .datePickerStyle(.compact)
        .font(.callout)
    }
}

struct DateRangePickerView_Previews: PreviewProvider {
    static let expenseVM = ExpenseViewModel()
    private static let dateRange: (from: Date, to: Date) = (Calendar.current.date(byAdding: DateComponents(month: -1), to: Date())!,
                                                                   Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!)
    
    static var previews: some View {
        DateRangePickerView(expenseVM: expenseVM, fromDate: dateRange.from, toDate: dateRange.to)
    }
}
