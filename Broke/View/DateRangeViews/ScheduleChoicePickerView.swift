//
//  ScheduleChoicePickerView.swift
//  Broke
//
//  Created by Wilson Mak on 2023-10-20.
//

import SwiftUI

struct ScheduleChoicePickerView: View {
    typealias ScheduleChoice = DateRangeViewModel.ScheduleChoice
    
    @ObservedObject var dateRangeVM: DateRangeViewModel
    
    var body: some View {
        Picker("Date Range", selection: $dateRangeVM.scheduleChoice) {
            ForEach(ScheduleChoice.allCases) {choice in
                Text(choice.rawValue)
            }
        }
        .pickerStyle(.segmented)

    }
}

#Preview {
    return ScheduleChoicePickerView(dateRangeVM: DateRangeViewModel())
}
