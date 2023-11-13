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
    
    private static var userDefaultRange: DateRange {
        return DateRange(
            from: Self.userDefaults.getValue(ofKey: .from) ?? Self.defaultDateRange.from,
            to: Self.userDefaults.getValue(ofKey: .to) ?? Self.defaultDateRange.to
        )
    }
    
    @Published private var _dateRange: DateRange
    @Published private var _scheduleChoice: ScheduleChoice
    
    var dateRange: DateRange {
        get {
            _dateRange
        }
        set {
            _dateRange = newValue
            saveDate(_dateRange)
        }
    }
    
    var scheduleChoice: ScheduleChoice {
        get {
            _scheduleChoice
        }
        set {
            _scheduleChoice = newValue
            saveSchedule(_scheduleChoice)
            dateRange = _scheduleChoice.dateRange() ?? Self.userDefaultRange
        }
    }
    
    init() {
        var schedule: ScheduleChoice = .custom
        if let rawScheduleValue: String = Self.userDefaults.getValue(ofKey: .scheduleChoice) {
            schedule = ScheduleChoice(rawValue: rawScheduleValue) ?? schedule
        }
        
        _scheduleChoice = schedule
        _dateRange = schedule.dateRange() ?? Self.userDefaultRange
    }
    
    private func saveDate(_ newDate: DateRange) {
        if scheduleChoice == .custom {
            Self.userDefaults.setValue(of: .from, withValue: newDate.from)
            Self.userDefaults.setValue(of: .to, withValue: newDate.to)
        }
    }
    
    private func saveSchedule(_ newSchedule: ScheduleChoice) {
        Self.userDefaults.setValue(of: .scheduleChoice, withValue: newSchedule.rawValue)
    }
    
    enum ScheduleChoice: String, CaseIterable, Identifiable {
        var id: Self {
            self
        }
        
        case custom
        case day
        case week
        case month
        
        func dateRange() -> DateRange? {
            switch self {
            case .custom:
                return nil
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
