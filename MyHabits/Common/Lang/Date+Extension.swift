//
//  Date+Extension.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 22/10/2023.
//

import Foundation

extension Date {
    
    func toString(destPattern dest: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dest
        return formatter.string(from: self)
    }
}
