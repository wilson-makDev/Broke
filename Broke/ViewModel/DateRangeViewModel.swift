//
//  DateRangeViewModel.swift
//  Broke
//
//  Created by Wilson Mak on 2023-10-18.
//

import Foundation

class DateRangeViewModel: ObservableObject {
    
    //TODO: Should set time to start of day for default
    private static let defaultDateRange = DateRange(from: Calendar.current.date(byAdding: DateComponents(month: -1), to: Date())!,
                                                    to: Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!)
    private static let userDefaults = UserDefaultsModel()
    private static let emptyDate: Date? = nil

    @Published private(set) var dateRange: DateRange
    
    init() {
        self.dateRange = DateRange(
            from: Self.userDefaults.getValue(ofKey: .from) ?? Self.defaultDateRange.from,
            to: Self.userDefaults.getValue(ofKey: .to) ?? Self.defaultDateRange.to
        )
    }
    
    func clearSavedDateRangeBound(of bound: Bound) {
        switch bound {
        case .from:
            Self.userDefaults.setValue(of: .from, withValue: Self.emptyDate)
        case .to:
            Self.userDefaults.setValue(of: .to, withValue: Self.emptyDate)
        }
    }
    
    func clearSavedDateRange() {
        Self.userDefaults.setValue(of: .from, withValue: Self.emptyDate)
        Self.userDefaults.setValue(of: .to, withValue: Self.emptyDate)
    }
    
    func setDateRangeBound(of bound: Bound, with newDate: Date, updateDefaults toSave: Bool = false) {
        switch bound {
        case .from:
            dateRange.from = newDate
            if (toSave) {
                Self.userDefaults.setValue(of: .from, withValue: newDate)
            }
        case .to:
            dateRange.to = newDate
            if (toSave) {
                Self.userDefaults.setValue(of: .to, withValue: newDate)
            }
        }
    }
    
    func setDateRange(with newDateRange: DateRange, updateDefaults toSave: Bool = false) {
        dateRange = newDateRange
        if (toSave) {
            Self.userDefaults.setValue(of: .from, withValue: newDateRange.from)
            Self.userDefaults.setValue(of: .to, withValue: newDateRange.to)
        }
    }
    
    func hasBoundSaved(for bound: Bound) -> Bool {
        switch bound {
        case .from:
            return Self.userDefaults.hasValue(of: .from)
        case .to:
            return Self.userDefaults.hasValue(of: .to)
        }
    }
    
    enum Bound {
        case from
        case to
    }
    
    struct DateRange {
        var from: Date
        var to: Date
    }
}
