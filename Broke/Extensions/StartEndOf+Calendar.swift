//
//  StartEndOf+Calendar.swift
//  Broke
//
//  Created by Wilson Mak on 2023-10-24.
//

import Foundation

extension Calendar {
    func endOfDay(for date: Date) -> Date {
        if let safeDate = self.date(bySettingHour: 23, minute: 59, second: 59, of: self.startOfDay(for: date)) {
            return safeDate
        }
        
        print("Could not find end of day for \(date) with calendar: \(self)")
        return date
    }
    
    func startOfWeek(for date: Date) -> Date {
        if let endOfWeek = self.date(bySetting: .weekday, value: 7, of: date) {
            if let safeDate = self.date(byAdding: DateComponents(weekday: -6), to: self.startOfDay(for: endOfWeek)) {
                return safeDate
            }
            
            print("Could not find start of week for \(date) with calendar: \(self)")
            return date
        }
        
        print("Could not find end of week for \(date) with calendar: \(self)")
        return date
    }
    
    func endOfWeek(for date: Date) -> Date {
        if let safeDate = self.date(bySetting: .weekday, value: 7, of: date) {
            return self.endOfDay(for: safeDate)
        }
        
        print("Could not find end of week for \(date) with calendar: \(self)")
        return date
    }
    
    func startOfMonth(for date: Date) -> Date {
        var monthOfDate = self.dateComponents([.year, .month], from: self.startOfDay(for: date))
        monthOfDate.day = 1
        
        if let safeDate = self.date(from: monthOfDate) {
            return self.startOfDay(for: safeDate)
        }
        print("Could not find start of month for \(date) with calendar: \(self)")
        return date
    }
    
    func endOfMonth(for date: Date) -> Date {
        if let safeDate = self.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(for: date)) {
            return self.endOfDay(for: safeDate)
        }
        print("Could not find end of month for \(date) with calendar: \(self)")
        return date
    }
}
