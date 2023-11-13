//
//  DateRangePickerView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct DateRangePickerView: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel
    @ObservedObject var dateRangeVM: DateRangeViewModel
    
    init(dateRangeVM: DateRangeViewModel) {
        self.dateRangeVM = dateRangeVM
    }
    
    var body: some View {
        VStack {
            HStack {
                DatePicker("", selection: $dateRangeVM.dateRange.from , displayedComponents: [.date])
                    .onChange(of: dateRangeVM.dateRange.from) { newFromDate in
                        expenseVM.changeDateRange(newFromDate, dateRangeVM.dateRange.to)
                    }
                    .disabled(dateRangeVM.scheduleChoice != .custom)
                    .labelsHidden()
                Spacer()
                Text("Date Range").font(.headline)
                Spacer()
                DatePicker("", selection: $dateRangeVM.dateRange.to, displayedComponents: [.date])
                    .onChange(of: dateRangeVM.dateRange.to) { newToDate in
                        expenseVM.changeDateRange(dateRangeVM.dateRange.from, newToDate)
                    }
                    .disabled(dateRangeVM.scheduleChoice != .custom)
            }
            .datePickerStyle(.compact)

            ScheduleChoicePickerView(dateRangeVM: dateRangeVM)
            
        }
        .padding()
        .font(.callout)
    }
}

struct DateRangePickerView_Previews: PreviewProvider {
    static let expenseVM = ExpenseViewModel()
    static let dateRangeVM = DateRangeViewModel()
    private static let dateRange: (from: Date, to: Date) = (Calendar.current.date(byAdding: DateComponents(month: -1), to: Date())!,
                                                                   Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!)
    
    static var previews: some View {
        DateRangePickerView(dateRangeVM: dateRangeVM).environmentObject(ExpenseViewModel())
    }
}
