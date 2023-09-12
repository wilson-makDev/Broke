//
//  CurrencyFormatter.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-10.
//

import Foundation

struct CurrencyFormater {
    let numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
    }
}
