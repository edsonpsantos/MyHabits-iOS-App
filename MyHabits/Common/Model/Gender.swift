//
//  Gender.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 17/08/2023.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable{
    case male = "Male"
    case female = "Female"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index{
        return Self.allCases.firstIndex{self==$0} ?? 0
    }
}
