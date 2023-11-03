//
//  DateRangeViewModel.swift
//  Broke
//
//  Created by Wilson Mak on 2023-10-18.
//

import Foundation

class DateRangeViewModel: ObservableObject {
    private static let today = Date()
    private static let calendar = Calendar.current

    private static let defaultDateRange = DateRange(from: calendar.date(byAdding: DateComponents(month: -1), to: calendar.startOfDay(for: today))!,
                                                    to: calendar.endOfDay(for: today))
    private static let userDefaults = UserDefaultsModel()
    private static let emptyDate: Date? = nil
    
    @Published var dateRange: DateRange
    
    init() {
        self.dateRange = DateRange(
            from: Self.userDefaults.getValue(ofKey: .from) ?? Self.defaultDateRange.from,
            to: Self.userDefaults.getValue(ofKey: .to) ?? Self.defaultDateRange.to
        )
    }
    
    func clearSavedBound(of bound: Bound) {
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
    
    func saveBound(for bound: Bound) {
        switch bound {
        case .from:
            Self.userDefaults.setValue(of: .from, withValue: dateRange.from)
        case .to:
            Self.userDefaults.setValue(of: .to, withValue: dateRange.to)
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
    
    func setToScheduleRange(of schedule: ScheduleChoice) {
        dateRange = schedule.dateRange()
    }
    
    enum Bound {
        case from
        case to
    }
    
    enum ScheduleChoice {
        case day
        case week
        case month
        
        func dateRange() -> DateRange {
            switch self {
            case .day:
                return DateRange(from: calendar.startOfDay(for: today), to: calendar.endOfDay(for: today))
            case .week:
                return DateRange(from: calendar.startOfWeek(for: today), to: calendar.endOfWeek(for: today))
            case .month:
                return DateRange(from: calendar.startOfMonth(for: today), to: calendar.endOfMonth(for: today))
            }
        }
    }
    
    struct DateRange {
        var from: Date
        var to: Date
    }
}
