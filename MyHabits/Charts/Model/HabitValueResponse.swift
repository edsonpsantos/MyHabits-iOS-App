//
//  HabitValueResponse.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 12/01/2024.
//

import Foundation

struct HabitValueResponse: Decodable {
    let id: Int
    let value: Int
    let habitId: Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case habitId = "habit_id"
        case createdDate = "create_date "
    }
}
