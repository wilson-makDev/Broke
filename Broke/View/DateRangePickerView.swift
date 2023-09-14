//
//  DateRangePickerView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct DateRangePickerView: View {
    @ObservedObject var expenseVM: ExpenseDateRangeViewModel
    @State var fromDate : Date
    @State var toDate : Date
    
    var body: some View {
        VStack {
            Text("Date Range").font(.headline)
            HStack {
                DatePicker("From:", selection: $fromDate , displayedComponents: [.date])
                    .onChange(of: fromDate) { newValue in
                        expenseVM.changeDateRange(from: newValue)
                    }
                DatePicker("To:", selection: $toDate, displayedComponents: [.date])
                    .onChange(of: toDate) { newValue in
                        expenseVM.changeDateRange(to: newValue)
                    }
            }
        }
        .padding()
        .datePickerStyle(.compact)
        .font(.callout)
    }
}

struct DateRangePickerView_Previews: PreviewProvider {
    static let expenseVM = ExpenseDateRangeViewModel()
    
    static var previews: some View {
        DateRangePickerView(expenseVM: expenseVM, fromDate: expenseVM.dateRange.from, toDate: expenseVM.dateRange.to)
    }
}
