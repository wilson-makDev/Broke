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
    
    func setValue<T>(of key: Key, withValue value: T?) {
        Self.userDefaults.setValue(value, forKey: key.rawValue)
    }
    
    func hasValue(of key: Key) -> Bool {
        return Self.userDefaults.value(forKey: key.rawValue) != nil
    }
    
    enum Key: String {
        case from = "fromDate"
        case to = "toDate"
    }
}
