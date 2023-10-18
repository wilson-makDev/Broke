//
//  DateRangePickerView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-13.
//

import SwiftUI

struct DateRangePickerView: View {
    @ObservedObject var expenseVM: ExpenseViewModel
    @ObservedObject var dateRangeVM: DateRangeViewModel
    
    @State private var isFromLocked: Bool
    @State private var isToLocked: Bool
    
    init(expenseVM: ExpenseViewModel, dateRangeVM: DateRangeViewModel) {
        self.expenseVM = expenseVM
        self.dateRangeVM = dateRangeVM
        self.isFromLocked = dateRangeVM.hasBoundSaved(for: .from)
        self.isToLocked = dateRangeVM.hasBoundSaved(for: .to)
    }
    
    var body: some View {
        VStack {
            Text("Date Range").font(.headline)
            HStack {
                Lock(isLocked: $isFromLocked, label: "From") {
                    isFromLocked ? dateRangeVM.saveBound(for: .from) : dateRangeVM.clearSavedBound(of: .from)
                }
                Spacer()
                Lock(isLocked: $isToLocked, label: "To") {
                    isToLocked ? dateRangeVM.saveBound(for: .to) : dateRangeVM.clearSavedBound(of: .to)
                }
            }
            HStack {
                DatePicker("", selection: $dateRangeVM.dateRange.from , displayedComponents: [.date])
                    .onChange(of: dateRangeVM.dateRange.from) { newFromDate in
                        expenseVM.changeDateRange(newFromDate, dateRangeVM.dateRange.to)
                    }
                    .disabled(isFromLocked)
                    .labelsHidden()
                
                Spacer()
                DatePicker("", selection: $dateRangeVM.dateRange.to, displayedComponents: [.date])
                    .onChange(of: dateRangeVM.dateRange.to) { newToDate in
                        expenseVM.changeDateRange(dateRangeVM.dateRange.from, newToDate)
                    }
                    .disabled(isToLocked)
            }
            .datePickerStyle(.compact)
        }
        .padding()
        .font(.callout)
    }
    
    private struct Lock: View {
        @Binding var isLocked: Bool
        var label: String
        var onLockToggle: () -> Void
        
        var body: some View {
            Button(action: {
                isLocked.toggle()
                onLockToggle()
            }, label: {
                Text(label)
                if isLocked {
                    Image(systemName: "lock")
                } else {
                    Image(systemName: "lock.open")
                }
            })
        }
    }
}

struct DateRangePickerView_Previews: PreviewProvider {
    static let expenseVM = ExpenseViewModel()
    static let dateRangeVM = DateRangeViewModel()
    private static let dateRange: (from: Date, to: Date) = (Calendar.current.date(byAdding: DateComponents(month: -1), to: Date())!,
                                                                   Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!)
    
    static var previews: some View {
        DateRangePickerView(expenseVM: expenseVM, dateRangeVM: dateRangeVM)
    }
}
