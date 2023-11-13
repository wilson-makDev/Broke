//
//  UserDefaultsModel.swift
//  Broke
//
//  Created by Wilson Mak on 2023-10-18.
//

import Foundation

struct UserDefaultsModel {
    private static let userDefaults = UserDefaults.standard
    
    func getValue<T>(ofKey key: Key) -> T? {
        let value = Self.userDefaults.value(forKey: key.rawValue)
        
        if let valueSafe = value as? T {
            return valueSafe
        }
        
        return nil
    }
    
    func setValue<T>(of key: Key, withValue value: T?) { //TODO: value must be primitive, date or data object, make more clear
        Self.userDefaults.setValue(value, forKey: key.rawValue)
    }
    
    func hasValue(of key: Key) -> Bool {
        let value = Self.userDefaults.value(forKey: key.rawValue)
        return value != nil
    }
    
    enum Key: String {
        case from = "fromDate"
        case to = "toDate"
        case scheduleChoice = "scheduleChoice"
    }
}
