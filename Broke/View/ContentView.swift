//
//  ContentView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-08.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var expenseVM: ExpenseViewModel
    @ObservedObject var dateRangeVM: DateRangeViewModel

    var body: some View {
        NavigationStack {
            VStack {
                GraphExpenseView().frame(height: 150).padding()
                SummaryExpenseView()
                DateRangePickerView(dateRangeVM: dateRangeVM)
            }
        }
        .background(Color("Background"))
        .onAppear(perform: {
            expenseVM.changeDateRange(dateRangeVM.dateRange.from, dateRangeVM.dateRange.to)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    private static var dateRangeVM = DateRangeViewModel()
    
    static var previews: some View {
        ContentView(dateRangeVM: dateRangeVM).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).environmentObject(ExpenseViewModel())
    }
}
